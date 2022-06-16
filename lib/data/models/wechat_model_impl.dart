import 'dart:io';

import 'package:flutter/services.dart';
import 'package:we_chat_app/data/models/authentication_model.dart';
import 'package:we_chat_app/data/models/authentication_model_impl.dart';
import 'package:we_chat_app/data/models/wechat_model.dart';
import 'package:we_chat_app/data/vos/conversation_vo_for_home_page.dart';
import 'package:we_chat_app/data/vos/message_vo.dart';
import 'package:we_chat_app/data/vos/moment_vo.dart';
import 'package:we_chat_app/data/vos/user_vo.dart';
import 'package:we_chat_app/network/chat_data_agent.dart';
import 'package:we_chat_app/network/cloud_firestore_data_agent_impl.dart';
import 'package:we_chat_app/network/real_time_data_agent_impl.dart';
import 'package:we_chat_app/network/wechat_data_agent.dart';

class WechatModelImpl extends WechatModel {
  static final WechatModelImpl _singleton = WechatModelImpl._internal();

  factory WechatModelImpl() {
    return _singleton;
  }

  WechatModelImpl._internal();

  /// Data Agents
  WechatDataAgent mDataAgent = CloudFirestoreDataAgentImpl();
  ChatDataAgent mChatDataAgent = RealTimeDatabaseDataAgentImpl();

  /// Other models
  AuthenticationModel authModel = AuthenticationModelImpl();

  @override
  Stream<List<MomentVO>> getMoments() {
    return mDataAgent.getMoments();
  }

  @override
  Future<void> addNewMoment(
      String description, File? imageFile, File? videoFile) {
    if (imageFile != null) {
      return mDataAgent
          .uploadFileToFirebase(imageFile)
          .then((downloadUrl) => craftMomentVO(description, downloadUrl, ""))
          .then((newMoment) => mDataAgent.addNewMoment(newMoment));
    } else if (videoFile != null) {
      return mDataAgent
          .uploadFileToFirebase(videoFile)
          .then((downloadUrl) => craftMomentVO(description, "", downloadUrl))
          .then((newMoment) => mDataAgent.addNewMoment(newMoment));
    } else {
      return craftMomentVO(description, "", "")
          .then((newMoment) => mDataAgent.addNewMoment(newMoment));
    }
  }

  Future<MomentVO> craftMomentVO(
      String description, String imageUrl, String videoUrl) {
    var currentMilliseconds = DateTime.now().millisecondsSinceEpoch;
    var newMoment = MomentVO(
      id: currentMilliseconds,
      userName: "Nyan Win Naing",
      postImage: imageUrl,
      postVideo: videoUrl,
      description: description,
      profilePicture:
          "https://static.wikia.nocookie.net/parody/images/8/8f/Profile_-_Jerry_Mouse_%28Tom_and_Jerry_%282021%29%29.png/revision/latest?cb=20210430032212",
    );
    return Future.value(newMoment);
  }

  @override
  Future<void> deletePost(int postId) {
    return mDataAgent.deletePost(postId);
  }

  @override
  Future<void> editPost(MomentVO moment, File? imageFile, File? videoFile,
      String currentImage, String currentVideo) {
    if (imageFile != null) {
      return mDataAgent
          .uploadFileToFirebase(imageFile)
          .then((downloadUrl) => editMomentVO(moment, downloadUrl, ""))
          .then((moment) => mDataAgent.addNewMoment(moment));
    } else if (videoFile != null) {
      return mDataAgent
          .uploadFileToFirebase(videoFile)
          .then((downloadUrl) => editMomentVO(moment, "", downloadUrl))
          .then((moment) => mDataAgent.addNewMoment(moment));
    } else {
      return editMomentVO(moment, currentImage, currentVideo)
          .then((moment) => mDataAgent.addNewMoment(moment));
    }
  }

  @override
  Stream<MomentVO> getMomentById(int momentId) {
    return mDataAgent.getMomentById(momentId);
  }

  Future<MomentVO> editMomentVO(
      MomentVO moment, String imageUrl, String videoUrl) {
    moment.postImage = imageUrl;
    moment.postVideo = videoUrl;
    return Future.value(moment);
  }

  @override
  Future addNewContactToScanner(UserVO? userVo) {
    return mDataAgent.addNewContactToScanner(userVo ?? UserVO());
  }

  @override
  Future addNewContactToScannedUser(UserVO? scannedUser) {
    return mDataAgent.addNewContactToScannedUser(scannedUser ?? UserVO());
  }

  @override
  Stream<List<UserVO>> getContactsOfLoggedInUser() {
    return mDataAgent.getContactsOfLoggedInUser();
  }

  @override
  Future<void> sendNewMessage(
      UserVO userVo, String message, File? imageFile, File? videoFile) {
    if (imageFile != null) {
      return mDataAgent
          .uploadFileToFirebase(imageFile)
          .then((downloadUrl) => craftNewMessageVo(message, downloadUrl, ""))
          .then((newMessage) =>
              mChatDataAgent.sendNewMessage(newMessage, userVo));
    } else if (videoFile != null) {
      return mDataAgent
          .uploadFileToFirebase(videoFile)
          .then((downloadUrl) => craftNewMessageVo(message, "", downloadUrl))
          .then((newMessage) =>
              mChatDataAgent.sendNewMessage(newMessage, userVo));
    } else {
      return craftNewMessageVo(message, "", "").then(
          (newMessage) => mChatDataAgent.sendNewMessage(newMessage, userVo));
    }
  }

  Future<MessageVO> craftNewMessageVo(
      String message, String imageUrl, String videoUrl) {
    var currentMilliseconds = DateTime.now().millisecondsSinceEpoch;
    var loggedInUserId = authModel.getLoggedInUser().id ?? "";
    return authModel.getUserById(loggedInUserId).then((user) {
      var newMessage = MessageVO(
        imageFile: imageUrl,
        videoFile: videoUrl,
        message: message,
        name: user.userName ?? "",
        profilePic: user.profilePicture ?? "",
        timeStamp: currentMilliseconds,
        userId: user.id ?? "",
      );
      return Future.value(newMessage);
    });
  }

  @override
  Stream<List<MessageVO>> getMessages(
      String loggedInUserId, String sentUserId) {
    return mChatDataAgent.getMessages(loggedInUserId, sentUserId);
  }

  @override
  Stream<List<Future<ConversationVOForHomePage>>> getConversations(
      String loggedInUserId) {
    return mChatDataAgent.getConversations(loggedInUserId);
  }

  @override
  Future<void> deleteConversation(
      String loggedInUserId, String conversationId) {
    return mChatDataAgent
        .deleteConversationFromLoggedInUser(loggedInUserId, conversationId)
        .then((_) {
      mChatDataAgent.deleteConversationFromChatUser(
          loggedInUserId, conversationId);
    });
  }
}
