import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:we_chat_app/data/models/authentication_model.dart';
import 'package:we_chat_app/data/models/authentication_model_impl.dart';

class SignUpWithEmailBloc extends ChangeNotifier {
  /// States
  bool isLoading = false;
  String name = "";
  String phoneNumber = "";
  String password = "";
  File? uploadPhoto;
  String email = "";

  bool isDisposed = false;

  /// Model
  final AuthenticationModel _model = AuthenticationModelImpl();

  Future onTapRegister(
      String name, String password, String phoneNumber, File? uploadPhoto) {
    _showLoading();
    return _model
        .register(email, name, password, phoneNumber, uploadPhoto)
        .then((value) {
      _model.login(email, password).whenComplete(() => _hideLoading());
    });
  }

  void _showLoading() {
    isLoading = true;
    _notifySafely();
  }

  void _hideLoading() {
    isLoading = false;
    _notifySafely();
  }

  void onEmailChanged(String email) {
    this.email = email;
    _notifySafely();
  }

  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
  }

  void _notifySafely() {
    if (!isDisposed) {
      notifyListeners();
    }
  }
}
