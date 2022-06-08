import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:we_chat_app/data/vos/moment_vo.dart';
import 'package:we_chat_app/network/wechat_data_agent.dart';

/// Collections
const momentCollection = "moment";

const fileUploadRef = "uploads";

class CloudFirestoreDataAgentImpl extends WechatDataAgent {
  /// Firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Storage
  final firebaseStorage = FirebaseStorage.instance;

  @override
  Stream<List<MomentVO>> getMoments() {
    return _firestore
        .collection(momentCollection)
        .snapshots()
        .map((querySnapShot) {
      return querySnapShot.docs.map<MomentVO>((document) {
        return MomentVO.fromJson(document.data());
      }).toList();
    });
  }

  @override
  Future<void> addNewMoment(MomentVO moment) {
    return _firestore
        .collection(momentCollection)
        .doc(moment.id.toString())
        .set(moment.toJson());
  }

  @override
  Future<void> deletePost(int postId) {
    return _firestore
        .collection(momentCollection)
        .doc(postId.toString())
        .delete();
  }

  @override
  Stream<MomentVO> getMomentById(int momentId) {
    return _firestore
        .collection(momentCollection)
        .doc(momentId.toString())
        .get()
        .asStream()
        .where((documentSnapShot) => documentSnapShot.data() != null)
        .map((documentSnapShot) => MomentVO.fromJson(documentSnapShot.data()!));
  }

  @override
  Future<String> uploadFileToFirebase(File file) {

    return firebaseStorage
        .ref(fileUploadRef)
        .child("${DateTime.now().millisecondsSinceEpoch}")
        .putFile(file)
        .then((taskSnapShot) => taskSnapShot.ref.getDownloadURL());

    // return firebaseStorage
    //     .ref(fileUploadRef)
    //     .child("${DateTime.now().millisecondsSinceEpoch}")
    //     .putFile(file)
    //     .then((taskSnapShot) => taskSnapShot.ref.getDownloadURL());
  }
}
