import 'package:flutter/cupertino.dart';
import 'package:rare_crew/core/cache_helper.dart';
import 'package:rare_crew/core/constants.dart';
import 'package:rare_crew/core/helper_functions.dart';
import 'package:rare_crew/services/firabase_auth_service.dart';

class AuthViewModel extends ChangeNotifier {
  String? email;
  void getEmailFromCache() async {
    email = await CacheHelper.getData(key: Constants.emailKey);
    notifyListeners();
  }

  bool _loginPage = true;
  bool get loginPage => _loginPage;
  bool _isSecure = true;
  bool get isSecure => _isSecure;
  void togglebetweenloginAndSignUp() {
    _loginPage = !_loginPage;
    notifyListeners();
  }

  void changePasswordVisibility() {
    _isSecure = !_isSecure;
    notifyListeners();
  }

  void login(String email, String password, VoidCallback success,
      VoidCallback error) async {
    try {
      final user = await AuthServices.login(email, password);
      await CacheHelper.saveData(key: Constants.emailKey, value: user!.email);
      success();
    } catch (e) {
      error();
      showCentralToast(text: 'Error has Occurred!', state: ToastStates.error);
    }
  }

  void register(String email, String password, VoidCallback success,
      VoidCallback error) async {
    try {
      await AuthServices.signUp(email, password);
      success();
    } catch (e) {
      error();
      showCentralToast(text: 'Error has Occurred!', state: ToastStates.error);
    }
  }

  void logout(VoidCallback success, VoidCallback error) async {
    try {
      await AuthServices.logOut();
      success();
    } catch (e) {
      error();
      showCentralToast(text: 'Error has Occurred!', state: ToastStates.error);
    }
  }
}
