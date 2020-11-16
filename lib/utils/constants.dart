class Strings {
  /// The [APP_TITLE] is used as the home [AppBar()] title
  /// It is also used in the [main.dart] file as [MaterialApp] title, and in the [DrawerHeader]
  static const String APP_TITLE = "ESRA";

  /// API
  // static const String SERVER_URL = 'http://192.168.2.104:3000/';
  static const String SERVER_URL = 'https://hbkuesra.herokuapp.com/';
  static const String INFERENCE_URL =
      'https://xza68yn910.execute-api.us-east-1.amazonaws.com/Prod/invocations/';
  static const String REMOTE = '';
  static const String REGISTER_USER_URI = 'api/user/register';
  static const String LOGIN_USER_URI = 'api/user/login';
  static const String ACTIVATE_USER_URI = 'api/user/activate';
  static const String FORGOT_PASS_URI = 'api/user/forgotPassword';
  static const String GET_USER_URI = 'api/user/getUser';
  static const String ADD_CHILD_URI = 'api/child/addChild';
  static const String PREDICTION_URI = 'api/model/predict';
  static const String SAVE_PREDICTION_URI = 'api/child/savePrediction';
  static const String GET_PRESIGNED_URL = 'api/inference/generatePresignedUrl';
  static const String SAVE_FEEDBACK_URI = 'api/child/saveFeedback';
  static const String GET_FAQS = 'api/faq/getFAQs';

  /// User Repositories
  static const String ESRA_USER_TOKEN = 'esra_user_token';
  static const String ESRA_USER_CHILDREN_COUNT = "esra_user_childrenCount";

  /// DRAWER
  static const String CHILDREN_TITLE = "Children";
  static const String EVALUATE_TITLE = "Evaluate";
  static const String FAQ_TITLE = "FAQ";
  static const String LOGOUT_TITLE = "Logout";
  static const String BOTTOM_MESSAGE =
      "It's great to move around and enjoy ESRA App";

  /// AUTHENTICATION
  static const String REGISTER_BTN_TEXT = "Register";
  static const String LOGIN_BTN_TEXT = "Login";

  /// Form fields
  static const String EMAIL_LABEL = "Email";
  static const String PHONE_NUMBER_LABEL = "Phone Number";
  static const String PHONE_NUMBER_HELPER =
      "The phone number will be used only for account verifications and won't be saved!";
  static const String PASSWORD_LABEL = "Password";
  static const String REPASSWORD_LABEL = "Confirm Password";

  /// ERRORS and EXCEPTIONS
  static const String NO_INTERNET_ERROR = "Verify your internet connection";
  static const String LOGIN_ERROR = "Login Failure!";
  static const String INVALID_EMAIL = "Invalid Email";
  static const String INVALID_PHONE_NUMBER = "Invalid Phone Number";
  static const String INVALID_PASSWORD = "Invalid Password";
  static const String INVALID_REPASSWORD = "Passwords do not match";
  static const String SOMETHING_WENT_WRONG =
      "Oops! Something went wrong. Please, try again later";
  static const String PHONE_VERIFICATION_ERROR =
      "Verification failed!\nPlease, make sure you enter the code sent";

  /// HOME PAGE
  static const String HOME_NO_CHILDREN_MESSAGE =
      "Add a child to start using ESRA";
  static const String ADD_CHILD_BTN_LABEL = "Add a Child";
  static const String WELCOME_MSG =
      "Welcome to ESRA.\nYour most recent activities will be shown here";
  static const String EVALUATE_DRAWING_BTN = "Evalute a Drawing";

  /// ADD CHILD PAGE
  static const String CHILD_NAME_FORM_LABEL = "First Name";
  static const String CHILD_AGE_FORM_LABEL = "Age (Years)";
  static const String CHILD_GENDER_LABEL = "Gender";
  static const String CHILD_BOY_LABEL = "BOY";
  static const String CHILD_GIRL_LABEL = "GIRL";

  /// CHILDREN LIST PAGE
  static const String CHILDREN_LIST_PAGE_TITLE = 'Your Children';

  /// Evalute page
  static const String NO_CHILD_MESSAGE =
      "No child found! Please, add a child first!";
  static const String EVALUATE_SELECT_CHILD_HINT = "Select a child";
  static const String CAPTURE_BTN_LABEL = "Capture Drawing";
  static const String UPLOAD_BTN_LABEL = "Upload Drawing";
  static const String POSITIVE_LABEL = "POSITIVE";
  static const String NEGATIVE_LABEL = "NEGATIVE";

  static String getLabelDetailText(String label, double score) {
    print('\n LABEL received is: $label');
    String stringLabel =
        label.contains('positive') ? POSITIVE_LABEL : NEGATIVE_LABEL;
    return 'The image reflects ${stringLabel.toLowerCase()} emotions with a score of ${(score * 100).round()}%';
  }

  /// Feedback
  static const String FEEDBACK_CARD_TITLE = "Is this result irrelevant?";
  static const String FEEDBACK_CARD_SUBTITLE =
      "Help us improve our predictions by providing us with your feedback";
  static const String EMPTY_FEEDBACK_ERROR = "Please, enter your feedback";
  static const String FEEDBACK_CONFIRMATION_DIALOG_TITLE = "Feedback Saved";
  static const String FEEDBACK_CONFIRMATION_DIALOG_BODY =
      "Thank you for sharing your feedback with us.";
  static const String PREDICTION_SAVED_CONFIRMATION_DIALOG_TITLE =
      "Prediction Saved";
  static const String PREDICTION_SAVED_CONFIRMATION_DIALOG_BODY =
      "Your child's resuts have been saved successfully!";

  /// Faq
  static const String FAQ_NONE = "There are no FAQs yet";

  /// COMMON
  static const String SAVE_BTN_LABEL = "SAVE";
  static const String DISMISS_BTN_LABEL = "DISMISS";
  static const String SUBMIT_BTN_LABEL = "SUBMIT";
  static const String LOADING_MSG = "Processing...";
}
