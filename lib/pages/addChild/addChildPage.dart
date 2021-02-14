import 'package:esra/components/dialogs/infoDialog.dart';
import 'package:esra/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esra/bloc/manageChildrenBloc/mangeChildren.dart';
import 'package:esra/components/button.dart';
import 'package:esra/components/toggleButton/toggleButton.dart';
import 'package:esra/repositories/userRepository.dart';
import 'package:esra/utils/constants.dart';

class AddChildPage extends StatefulWidget {
  @override
  _AddChildPageState createState() => _AddChildPageState();
}

class _AddChildPageState extends State<AddChildPage> {
  final TextEditingController _childNameController = TextEditingController();
  final TextEditingController _childAgeController = TextEditingController();
  String _gender;

  ManagechildrenBloc _managechildrenBloc;

  bool get isPopulated =>
      _childNameController.text.isNotEmpty &&
      _childAgeController.text.isNotEmpty;

  bool isAddChildButtonValid(ManagechildrenState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _childNameController.addListener(_onChildNameChanged);
    _childAgeController.addListener(_onChildAgeChanged);
    // _managechildrenBloc = BlocProvider.of<ManagechildrenBloc>(context);

    _gender = 'boy';
  }

  @override
  void dispose() {
    super.dispose();
    _childNameController.dispose();
    _childAgeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.ADD_CHILD_BTN_LABEL),
      ),
      body: BlocListener<ManagechildrenBloc, ManagechildrenState>(
        listener: (context, state) async {
          if (state.isSuccess) {
            // BlocProvider.of<ManagechildrenBloc>(context).add(ChildrenCountChanged(childrenList: state.childrenList));
            Navigator.of(context).pushNamed('/');
          } else if (state.isFailure) {
            print("errrrrrrrrrrrrror");
            // await infoDialog(
            //   context,
            //   Strings.FEEDBACK_CONFIRMATION_DIALOG_TITLE,
            //   Strings.FEEDBACK_CONFIRMATION_DIALOG_BODY,
            // );
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text(state.errorMsg), Icon(Icons.error)],
                  ),
                  backgroundColor: Colors.red,
                ),
              );
          }
        },
        child: BlocBuilder<ManagechildrenBloc, ManagechildrenState>(
          builder: (context, state) {
            if (state.isSubmitting) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    SizedBox(height: 24),
                    Text(Strings.LOADING_MSG),
                  ],
                ),
              );
            }
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Form(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Image(
                          image: AssetImage(AppIllustrations.saveChild),
                        ),
                      ),
                      TextFormField(
                        controller: _childNameController,
                        decoration: InputDecoration(
                          prefixIcon: Image(image: AssetImage(AppIcons.name)),
                          labelText: Strings.CHILD_NAME_FORM_LABEL,
                          labelStyle: TextStyle(color: AppStyles.darkBlue),
                        ),
                        keyboardType: TextInputType.text,
                        autovalidate: true,
                        autocorrect: false,
                        validator: (_) {
                          return !state.isChildNameValid
                              ? 'Name should be at least 3 characters long\nUse only letters and spaces'
                              : null;
                        },
                      ),
                      SizedBox(height: 24),
                      TextFormField(
                        controller: _childAgeController,
                        decoration: InputDecoration(
                          prefixIcon: Image(image: AssetImage(AppIcons.year)),
                          labelText: Strings.CHILD_DOB_FORM_LABEL,
                          labelStyle: TextStyle(color: AppStyles.darkBlue),
                        ),
                        keyboardType: TextInputType.text,
                        autovalidate: true,
                        autocorrect: false,
                        validator: (_) {
                          return !state.isDOBValid
                              ? 'Enter as dd/mm/yyyy\nChild age must be 3 - 16 years old'
                              : null;
                        },
                      ),
                      SizedBox(height: 24),
                      ToggleButton(
                        items: [
                          Strings.CHILD_BOY_LABEL,
                          Strings.CHILD_GIRL_LABEL
                        ],
                        onItemSelected: (value) {
                          setState(() {
                            _gender = value == 0 ? 'boy' : 'girl';
                          });
                        },
                      ),
                      SizedBox(height: 48),
                      RoundButton(
                        label: Strings.SAVE_BTN_LABEL,
                        onPressed: isAddChildButtonValid(state)
                            ? _onFormSubmitted
                            : null,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  _onChildNameChanged() {
    BlocProvider.of<ManagechildrenBloc>(context)
        .add(ChildNameChanged(childName: _childNameController.text));
  }

  _onChildAgeChanged() {
    BlocProvider.of<ManagechildrenBloc>(context)
        .add(ChildAgeChanged(dob: _childAgeController.text));
  }

  void _onFormSubmitted() {
    FocusScope.of(context).unfocus();
    BlocProvider.of<ManagechildrenBloc>(context).add(
      Submitted(
        childName: _childNameController.text,
        dob: _childAgeController.text,
        childGender: _gender,
      ),
    );
  }
}
