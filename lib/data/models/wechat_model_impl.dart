import 'dart:io';

import 'package:flutter/services.dart';
import 'package:we_chat_app/data/models/wechat_model.dart';
import 'package:we_chat_app/data/vos/moment_vo.dart';
import 'package:we_chat_app/network/cloud_firestore_data_agent_impl.dart';
import 'package:we_chat_app/network/wechat_data_agent.dart';

class WechatModelImpl extends WechatModel {

  static final WechatModelImpl _singleton = WechatModelImpl._internal();

  factory WechatModelImpl() {
    return _singleton;
  }

  WechatModelImpl._internal();

  /// Data Agents
  WechatDataAgent mDataAgent = CloudFirestoreDataAgentImpl();

  @override
  Stream<List<MomentVO>> getMoments() {
    return mDataAgent.getMoments();
  }

  @override
  Future<void> addNewMoment(String description, File? imageFile, File? videoFile) {
    if(imageFile != null) {
      return mDataAgent
          .uploadFileToFirebase(imageFile)
          .then((downloadUrl) => craftMomentVO(description, downloadUrl, ""))
          .then((newMoment) => mDataAgent.addNewMoment(newMoment));
    } else if(videoFile != null) {
      return mDataAgent
          .uploadFileToFirebase(videoFile)
          .then((downloadUrl) => craftMomentVO(description, "", downloadUrl))
          .then((newMoment) => mDataAgent.addNewMoment(newMoment));
    } else {
      return craftMomentVO(description, "", "")
          .then((newMoment) => mDataAgent.addNewMoment(newMoment));
    }
  }

  Future<MomentVO> craftMomentVO(String description, String imageUrl, String videoUrl) {
    var currentMilliseconds = DateTime.now().millisecondsSinceEpoch;
    var newMoment = MomentVO(
      id: currentMilliseconds,
      userName: "Nyan Win Naing",
      postImage: imageUrl,
      postVideo: videoUrl,
      description: description,
      profilePicture: "https://static.wikia.nocookie.net/parody/images/8/8f/Profile_-_Jerry_Mouse_%28Tom_and_Jerry_%282021%29%29.png/revision/latest?cb=20210430032212",
    );
    return Future.value(newMoment);
  }

  @override
  Future<void> deletePost(int postId) {
    return mDataAgent.deletePost(postId);
  }

  @override
  Future<void> editPost(MomentVO moment, File? imageFile, File? videoFile) {
    if(imageFile != null) {
      return mDataAgent
          .uploadFileToFirebase(imageFile)
          .then((downloadUrl) => editMomentVO(moment, downloadUrl, ""))
          .then((moment) => mDataAgent.addNewMoment(moment));
    } else if(videoFile != null) {
      return mDataAgent
          .uploadFileToFirebase(videoFile)
          .then((downloadUrl) => editMomentVO(moment, "", downloadUrl))
          .then((moment) => mDataAgent.addNewMoment(moment));
    } else {
      return editMomentVO(moment, "", "")
          .then((moment) => mDataAgent.addNewMoment(moment));
    }
  }

  @override
  Stream<MomentVO> getMomentById(int momentId) {
    return mDataAgent.getMomentById(momentId);
  }

  Future<MomentVO> editMomentVO(MomentVO moment, String imageUrl, String videoUrl) {
    moment.postImage = imageUrl;
    moment.postVideo = videoUrl;
    return Future.value(moment);
  }
}