import 'dart:io';

import 'package:we_chat_app/data/vos/moment_vo.dart';

abstract class WechatDataAgent {
  /// Moments
  Stream<List<MomentVO>> getMoments();

  Future<void> addNewMoment(MomentVO moment);

  Future<void> deletePost(int postId);

  Stream<MomentVO> getMomentById(int momentId);
  Future<String> uploadFileToFirebase(File file);
}