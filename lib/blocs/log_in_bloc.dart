import 'package:flutter/foundation.dart';
import 'package:we_chat_app/data/models/authentication_model.dart';
import 'package:we_chat_app/data/models/authentication_model_impl.dart';

class LogInBloc extends ChangeNotifier {
  /// States
  bool isLoading = false;
  String email = "";
  String password = "";

  bool isDisposed = false;

  /// Model
  AuthenticationModel authModel = AuthenticationModelImpl();

  Future onTapLogin() {
    _showLoading();
    return authModel.login(email, password).whenComplete(() => _hideLoading());
  }

  void onChangedEmail(String email) {
    this.email = email;
    _notifySafely();
  }

  void onChangedPassword(String password) {
    this.password = password;
    _notifySafely();
  }


  void _showLoading() {
    isLoading = true;
    _notifySafely();
  }

  void _hideLoading() {
    isLoading = false;
    _notifySafely();
  }

  void _notifySafely() {
    if(!isDisposed) {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
  }
}