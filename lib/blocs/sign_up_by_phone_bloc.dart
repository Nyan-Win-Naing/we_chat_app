import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SignUpByPhoneBloc extends ChangeNotifier {
  /// States
  String name = "";
  String phoneNumber = "";
  String password = "";
  File? uploadPhoto;

  String countryName = "";
  String countryCode = "";

  bool isDisposed = false;

  bool isSignUpError = false;

  SignUpByPhoneBloc({
    String name = "",
    String phoneNumber = "",
    String password = "",
    File? uploadPhoto,
    String countryName = "",
    String countryCode = "",
  }) {
    this.name = name;
    this.phoneNumber = phoneNumber;
    this.password = password;
    this.countryName = countryName;
    this.countryCode = countryCode;
    this.uploadPhoto = uploadPhoto;
    _notifySafely();
  }

  void onTapCountry(String countryName, String countryCode) {
    this.countryName = countryName;
    this.countryCode = countryCode;
  }

  void onNameChanged(String name) {
    this.name = name;
  }

  void onPhoneNumberChanged(String phoneNumber) {
    this.phoneNumber = phoneNumber;
  }

  void onPasswordChanged(String password) {
    this.password = password;
  }

  void onImageChosen(File imageFile) {
    uploadPhoto = imageFile;
    _notifySafely();
  }

  void onTapDeleteImage() {
    uploadPhoto = null;
    _notifySafely();
  }

  Future onTapAcceptAndContinue() {
    if (name.isEmpty || phoneNumber.isEmpty || password.isEmpty) {
      isSignUpError = true;
      _notifySafely();
      return Future.error("Error");
    } else {
      isSignUpError = false;
      phoneNumber = "$countryCode $phoneNumber";
      return Future.value("Success");
    }
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
