import 'dart:io';

import 'package:we_chat_app/data/vos/moment_vo.dart';

abstract class WechatModel {
  Stream<List<MomentVO>> getMoments();
  Future<void> addNewMoment(String description, File? imageFile, File? videoFile);
  Future<void> deletePost(int postId);
  Stream<MomentVO> getMomentById(int momentId);
  Future<void> editPost(MomentVO moment, File? imageFile, File? videoFile, String currentImage, String currentVideo);
}