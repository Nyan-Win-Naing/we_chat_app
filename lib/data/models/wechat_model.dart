import 'dart:io';

import 'package:we_chat_app/data/vos/conversation_vo_for_home_page.dart';
import 'package:we_chat_app/data/vos/message_vo.dart';
import 'package:we_chat_app/data/vos/moment_vo.dart';
import 'package:we_chat_app/data/vos/user_vo.dart';

abstract class WechatModel {
  Stream<List<MomentVO>> getMoments();
  Future<void> addNewMoment(String description, File? imageFile, File? videoFile, String userName, String profileImage);
  Future<void> deletePost(int postId);
  Stream<MomentVO> getMomentById(int momentId);
  Future<void> editPost(MomentVO moment, File? imageFile, File? videoFile, String currentImage, String currentVideo);

  Future addNewContactToScanner(UserVO? userVo);
  Future addNewContactToScannedUser(UserVO? scannedUser);
  Stream<List<UserVO>> getContactsOfLoggedInUser();
  Future<void> sendNewMessage(UserVO userVo, String message, File? imageFile, File? videoFile);
  Stream<List<MessageVO>> getMessages(String loggedInUserId, String sentUserId);

  Stream<List<Future<ConversationVOForHomePage>>> getConversations(String loggedInUserId);
  Future<void> deleteConversation(String loggedInUserId, String conversationId);
}