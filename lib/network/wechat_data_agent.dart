import 'dart:io';

import 'package:we_chat_app/data/vos/moment_vo.dart';
import 'package:we_chat_app/data/vos/user_vo.dart';

abstract class WechatDataAgent {
  /// Moments
  Stream<List<MomentVO>> getMoments();

  Future<void> addNewMoment(MomentVO moment);

  Future<void> deletePost(int postId);

  Stream<MomentVO> getMomentById(int momentId);
  Future<String> uploadFileToFirebase(File file);

  /// Authentication
  Future registerNewUser(UserVO newUser);
  Future login(String email, String password);
  bool isLoggedIn();
  UserVO getLoggedInUser();
  Future logOut();
  Stream<UserVO> getUserById(String userId);
  Future<void> addNewContact(UserVO userVo);
}