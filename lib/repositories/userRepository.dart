import 'package:esra/models/child.dart';
import 'package:esra/models/faq.dart';
import 'package:esra/utils/errorHandler.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:esra/api/userApiClient.dart';
import 'package:esra/utils/constants.dart';
import 'package:meta/meta.dart';

class UserRepository {
  final _storage = FlutterSecureStorage();
  UserApiClient userApiClient = UserApiClient();

  UserRepository();

  ///_______________________________________
  /// Register a New User
  ///---------------------------------------
  Future<void> registerUser(
    String email,
    String password,
  ) async {
    await userApiClient.registerUser(
      email: email,
      password: password,
    );
  }

  ///_______________________________________
  /// Login User
  ///---------------------------------------
  Future<void> login(
    String email,
    String password,
  ) async {
    String token = await userApiClient.login(email, password);
    await persistToken(token);
  }

  Future<void> persistToken(String token) async {
    await _storage.write(key: Strings.ESRA_USER_TOKEN, value: token);
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: Strings.ESRA_USER_TOKEN);
  }

  Future<String> readToken() async {
    return await _storage.read(key: Strings.ESRA_USER_TOKEN);
  }

  Future<bool> isSignedIn() async {
    String token = await readToken();
    return (token != null && token.isNotEmpty);
  }

  /// TODO replace by the actuall user fetching form api
  /// This is called from [AuthenticationBloc] if the state is [LoggedIn]
  Future<List<Child>> getChildren() async {
    String token = await readToken();
    return await userApiClient.getChildren(token);
    // return "Authenticated User";
  }

  Future<List<Child>> addChild({String name, String dob, String gender}) async {
    String token = await readToken();
    await userApiClient.addNewChild(name, dob, gender, token);
    List<Child> childrenList = await getChildren();
    await updateLocalChildrenCount(childrenList.length);
    return childrenList;
  }

  Future<void> updateLocalChildrenCount(int newCount) async {
    await _storage.write(
        key: Strings.ESRA_USER_CHILDREN_COUNT, value: newCount.toString());
  }

  Future<int> readLocalChildrenCount() async {
    String childrenCount =
        await _storage.read(key: Strings.ESRA_USER_CHILDREN_COUNT);
    return int.parse(childrenCount);
  }

  Future<List<Faq>> getFaqList() async {
    return await userApiClient.getFaqs();
  }

  ///
  ///
  /// FIREBASE AUTH
  /// --> Send Verification Code from Firebase Auth
  ///
  ///

  // Phone Verification Id
  String _verificationId;

  Future<bool> sendVerCode({@required String email}) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    bool isUserAutoVerified = false;

    /// Automatic verification without the need of code input
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
      _verificationId = verId;
    };

    /// Firebase has sent a verification code to the phone number
    /// We need to keep hold onto the verification code since we need it
    /// to manually sign user in if the autho retrieve didn't occure!
    final PhoneCodeSent smsCodeSent =
        (String verId, [int forceCodeResend]) async {
      _verificationId = verId;
    };

    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential credential) async {
      try {
        _auth.signInWithCredential(credential);
        await userApiClient.activateUser(email); // we have to notify the ui!!!
        isUserAutoVerified = true;
      } catch (e) {}
    };

    // final PhoneVerificationFailed veriFailed = (AuthException exception) {
    //   throw ErrorHandler(Strings.PHONE_VERIFICATION_ERROR);
    // };
    // await _auth.verifyPhoneNumber(
    //   phoneNumber: "+974" + phoneNumber,
    //   codeAutoRetrievalTimeout: autoRetrieve,
    //   codeSent: smsCodeSent,
    //   timeout: const Duration(seconds: 5),
    //   verificationCompleted: verificationCompleted,
    //   verificationFailed: veriFailed,
    // );

    return isUserAutoVerified;
  }

  ///
  /// --> Verify the entered activation code
  /// This function should be called after the user has received the verification code
  /// entered the code in the actiation page and hit 'VERIFY' button
  ///
  Future<void> verifyPhoneNo(
      {@required String smsCode, @required String email}) async {
    final AuthCredential credential = PhoneAuthProvider.getCredential(
        verificationId: _verificationId, smsCode: smsCode);
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      await userApiClient.activateUser(email);
    } catch (e) {
      throw ErrorHandler(Strings.PHONE_VERIFICATION_ERROR);
    }
  }
}
