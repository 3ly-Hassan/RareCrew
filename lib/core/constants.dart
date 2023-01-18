class Constants {
  //Auth Constants
  static final RegExp emailValidatorRegExp =
      RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  static const String kEmailNullError = "Please Enter Your Email";
  static const String kInvalidEmailError = "Please Enter A valid Email";
  static const String kPassNullError = "Please Enter Your Password";
  static const String kShortPassError = "Password is very weak";
  static const String kMatchPassError = "Password does not match";
  static const String kTitleRequired = "Title is required";
  static const String kBodyRequired = "Body is required";
  //SharedPreferences Keys
  static const String emailKey = "email";
}
