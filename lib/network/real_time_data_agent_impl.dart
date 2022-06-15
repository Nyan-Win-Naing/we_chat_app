import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:we_chat_app/data/vos/message_vo.dart';
import 'package:we_chat_app/data/vos/user_vo.dart';
import 'package:we_chat_app/network/chat_data_agent.dart';
import 'package:we_chat_app/network/cloud_firestore_data_agent_impl.dart';
import 'package:we_chat_app/network/wechat_data_agent.dart';

/// Database Paths
const contactsAndMessagesPath = "contactsAndMessagesPath";

/// File Upload References
const fileUploadRef = "uploads";

class RealTimeDatabaseDataAgentImpl extends ChatDataAgent {
  static final RealTimeDatabaseDataAgentImpl _singleton =
      RealTimeDatabaseDataAgentImpl._internal();

  factory RealTimeDatabaseDataAgentImpl() {
    return _singleton;
  }

  RealTimeDatabaseDataAgentImpl._internal();

  /// Database
  var databaseRef = FirebaseDatabase.instance.reference();

  /// Firestore Data Agent
  WechatDataAgent _firestoreDataAgent = CloudFirestoreDataAgentImpl();

  /// Storage
  var firebaseStorage = FirebaseStorage.instance;

  /// Auth
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Future<void> sendNewMessage(MessageVO message, UserVO? userVo) {
    // return databaseRef
    //     .child(contactsAndMessagesPath)
    //     .child(_firestoreDataAgent.getLoggedInUser().id ?? "")
    //     .child(userVo?.id ?? "")
    //     .child(message.timeStamp.toString())
    //     .set(message.toJson());
    return createMessageInRealTimeDatabaseForLoggedInUser(message, userVo).then((_) {
      return createMessageInRealTimeDatabaseForSentUser(message, userVo);
    });
  }

  Future<void> createMessageInRealTimeDatabaseForLoggedInUser(MessageVO message, UserVO? userVo) {
    return databaseRef
        .child(contactsAndMessagesPath)
        .child(_firestoreDataAgent.getLoggedInUser().id ?? "")
        .child(userVo?.id ?? "")
        .child(message.timeStamp.toString())
        .set(message.toJson());
  }

  Future<void> createMessageInRealTimeDatabaseForSentUser(MessageVO message, UserVO? userVo) {
    return databaseRef
        .child(contactsAndMessagesPath)
        .child(userVo?.id ?? "")
        .child(_firestoreDataAgent.getLoggedInUser().id ?? "")
        .child(message.timeStamp.toString())
        .set(message.toJson());
  }

  @override
  Stream<List<MessageVO>> getMessages(String loggedInUserId, String sentUserId) {
    return databaseRef.child(contactsAndMessagesPath).child(loggedInUserId).child(sentUserId).onValue
        .map((event) {
          return (event.snapshot.value != null) ? event.snapshot.value.values.map<MessageVO>(
              (element) {
                return MessageVO.fromJson(Map<String, dynamic>.from(element));
              }
          ).toList() : [];
    });
  }
}
