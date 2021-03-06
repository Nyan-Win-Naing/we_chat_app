import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:we_chat_app/data/vos/moment_vo.dart';
import 'package:we_chat_app/data/vos/user_vo.dart';
import 'package:we_chat_app/network/wechat_data_agent.dart';

/// Collections
const momentCollection = "moment";

const fileUploadRef = "uploads";

const usersCollection = "users";
const contactsCollection = "contacts";

class CloudFirestoreDataAgentImpl extends WechatDataAgent {
  /// Firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Storage
  final firebaseStorage = FirebaseStorage.instance;

  /// Auth
  FirebaseAuth auth = FirebaseAuth.instance;

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
  }

  @override
  UserVO getLoggedInUser() {
    return UserVO(
      id: auth.currentUser?.uid,
      email: auth.currentUser?.email,
      userName: auth.currentUser?.displayName,
    );
  }

  @override
  bool isLoggedIn() {
    return auth.currentUser != null;
  }

  @override
  Future logOut() {
    return auth.signOut();
  }

  @override
  Future login(String email, String password) {
    return auth.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future registerNewUser(UserVO newUser) {
    return auth
        .createUserWithEmailAndPassword(
            email: newUser.email ?? "", password: newUser.password ?? "")
        .then((credential) =>
            credential.user?..updateDisplayName(newUser.userName))
        .then((user) {
      newUser.id = user?.uid ?? "";
      newUser.qrCode = user?.uid ?? "";
      _addNewUser(newUser);
    });
  }

  Future<void> _addNewUser(UserVO newUser) {
    return _firestore
        .collection(usersCollection)
        .doc(newUser.id.toString())
        .set(newUser.toJson());
  }

  @override
  Future<UserVO> getUserById(String userId) {
    // return _firestore
    //     .collection(usersCollection)
    //     .doc(userId)
    //     .get()
    //     .asStream()
    //     .where((documentSnapShot) => documentSnapShot.data() != null)
    //     .map((documentSnapShot) => UserVO.fromJson(documentSnapShot.data()!));

    return _firestore.collection(usersCollection).doc(userId).get().then(
      (DocumentSnapshot documentSnapshot) {
        return UserVO.fromJson(
            documentSnapshot.data()! as Map<String, dynamic>);
      },
      onError: (e) => print("Error getting document: $e"),
    );
  }

  @override
  Future<void> addNewContactToScanner(UserVO userVo) {
    return _firestore
        .collection(usersCollection)
        .doc(getLoggedInUser().id ?? "")
        .collection(contactsCollection)
        .doc(userVo.id.toString())
        .set(userVo.toJson());
  }

  @override
  Future<void> addNewContactToScannedUser(UserVO userVo) async {
    var scannerId = getLoggedInUser().id ?? "";
    UserVO scannerUser = UserVO();
    await getUserById(scannerId).then((user) {
      scannerUser = user;
    }).catchError((error) {
      debugPrint(error.toString());
    });

    return _firestore
        .collection(usersCollection)
        .doc(userVo.id ?? "")
        .collection(contactsCollection)
        .doc(scannerId)
        .set(scannerUser.toJson());
  }

  @override
  Stream<List<UserVO>> getContactsOfLoggedInUser() {
    String loggedInUserId = getLoggedInUser().id ?? "";
    return _firestore
        .collection(usersCollection)
        .doc(loggedInUserId)
        .collection(contactsCollection)
        .snapshots()
        .map((querySnapShot) {
      return querySnapShot.docs.map<UserVO>((document) {
        return UserVO.fromJson(document.data());
      }).toList();
    });
  }
}
