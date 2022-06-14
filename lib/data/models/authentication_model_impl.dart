import 'dart:io';

import 'package:we_chat_app/data/models/authentication_model.dart';
import 'package:we_chat_app/data/vos/user_vo.dart';
import 'package:we_chat_app/fcm/fcm_service.dart';
import 'package:we_chat_app/network/cloud_firestore_data_agent_impl.dart';
import 'package:we_chat_app/network/wechat_data_agent.dart';

class AuthenticationModelImpl extends AuthenticationModel {

  static final AuthenticationModelImpl _singleton = AuthenticationModelImpl._internal();

  factory AuthenticationModelImpl() {
    return _singleton;
  }

  AuthenticationModelImpl._internal();

  WechatDataAgent mDataAgent = CloudFirestoreDataAgentImpl();

  @override
  UserVO getLoggedInUser() {
    return mDataAgent.getLoggedInUser();
  }

  @override
  bool isLoggedIn() {
    return mDataAgent.isLoggedIn();
  }

  @override
  Future<void> logOut() {
    return mDataAgent.logOut();
  }

  @override
  Future<void> login(String email, String password) {
    return mDataAgent.login(email, password);
  }

  @override
  Future<void> register(String email, String userName, String password, String phone, File? imageFile) {
    if(imageFile != null) {
      return mDataAgent
          .uploadFileToFirebase(imageFile)
          .then((downloadUrl) => craftUserVO(email, userName, password, phone, downloadUrl))
          .then((user) => mDataAgent.registerNewUser(user));
    } else {
      return craftUserVO(email, userName, password, phone, "")
          .then((user) => mDataAgent.registerNewUser(user));
    }
  }

  Future<UserVO> craftUserVO(String email, String userName, String password, String phone, String profileImageUrl) async {
    String fcmToken = "";

    await FCMService().getFcmToken().then((value) {
      fcmToken = value;
    });

    var newUser = UserVO(
      id: "",
      userName: userName,
      phone: phone,
      password: password,
      email: email,
      profilePicture: profileImageUrl,
      qrCode: "",
      fcmToken: fcmToken,
    );
    return Future.value(newUser);
  }

  @override
  Future<UserVO> getUserById(String userId) {
    return mDataAgent.getUserById(userId);
  }

  @override
  Future<void> addNewContact(UserVO userVo) {
    // TODO: implement addNewContact
    throw UnimplementedError();
  }

}