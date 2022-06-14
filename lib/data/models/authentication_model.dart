import 'dart:io';

import 'package:we_chat_app/data/vos/user_vo.dart';

abstract class AuthenticationModel {
  Future<void> login(String email, String password);

  Future<void> register(
    String email,
    String userName,
    String password,
    String phone,
    File? imageFile,
  );

  bool isLoggedIn();

  UserVO getLoggedInUser();

  Future<void> logOut();

  /// Other methods
  Future<UserVO> getUserById(String userId);
  Future<void> addNewContact(UserVO userVo);
}
