import 'package:flutter/foundation.dart';
import 'package:we_chat_app/data/models/authentication_model.dart';
import 'package:we_chat_app/data/models/authentication_model_impl.dart';
import 'package:we_chat_app/data/vos/user_vo.dart';

class ProfileBloc extends ChangeNotifier {
  /// States
  String userName = "";
  String profileImage = "";
  String qrCode = "";
  UserVO? user;

  bool isDisposed = false;


  /// Model
  AuthenticationModel authModel = AuthenticationModelImpl();

  ProfileBloc() {
    var user = authModel.getLoggedInUser();
    _prepopulateForProfilePage(user.id ?? "");
  }

  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
  }

  void _notifySafely() {
    if(!isDisposed) {
      notifyListeners();
    }
  }

  void _prepopulateForProfilePage(String id) {
    authModel.getUserById(id).listen((userVo) {
      userName = userVo.userName ?? "";
      profileImage = userVo.profilePicture ?? "";
      qrCode = userVo.qrCode ?? "";
      user = userVo;
      _notifySafely();
    });
  }

  Future onTapLogout() {
    return authModel.logOut();
  }
}