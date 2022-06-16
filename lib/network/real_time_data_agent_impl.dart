import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:we_chat_app/blocs/home_bloc.dart';
import 'package:we_chat_app/data/vos/conversation_vo_for_home_page.dart';
import 'package:we_chat_app/data/vos/message_vo.dart';
import 'package:we_chat_app/data/vos/user_vo.dart';
import 'package:we_chat_app/network/chat_data_agent.dart';
import 'package:we_chat_app/network/cloud_firestore_data_agent_impl.dart';
import 'package:we_chat_app/network/wechat_data_agent.dart';
import 'dart:math';

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
    return createMessageInRealTimeDatabaseForLoggedInUser(message, userVo)
        .then((_) {
      return createMessageInRealTimeDatabaseForSentUser(message, userVo);
    });
  }

  Future<void> createMessageInRealTimeDatabaseForLoggedInUser(
      MessageVO message, UserVO? userVo) {
    return databaseRef
        .child(contactsAndMessagesPath)
        .child(_firestoreDataAgent.getLoggedInUser().id ?? "")
        .child(userVo?.id ?? "")
        .child(message.timeStamp.toString())
        .set(message.toJson());
  }

  Future<void> createMessageInRealTimeDatabaseForSentUser(
      MessageVO message, UserVO? userVo) {
    return databaseRef
        .child(contactsAndMessagesPath)
        .child(userVo?.id ?? "")
        .child(_firestoreDataAgent.getLoggedInUser().id ?? "")
        .child(message.timeStamp.toString())
        .set(message.toJson());
  }

  @override
  Stream<List<MessageVO>> getMessages(
      String loggedInUserId, String sentUserId) {
    return databaseRef
        .child(contactsAndMessagesPath)
        .child(loggedInUserId)
        .child(sentUserId)
        .onValue
        .map((event) {
      return (event.snapshot.value != null)
          ? event.snapshot.value.values.map<MessageVO>((element) {
              return MessageVO.fromJson(Map<String, dynamic>.from(element));
            }).toList()
          : [];
    });
  }

  @override
  Stream<List<Future<ConversationVOForHomePage>>> getConversations(
      String loggedInUserId) {

    return databaseRef
        .child(contactsAndMessagesPath)
        .child(loggedInUserId)
        .onValue
        .map((event) {
      // var temp = event.snapshot.value.values.toList();
      // print("The result is $temp........");
      // return Stream.empty();
      ///
      // var result = event.snapshot.value.keys.toList().map<String>((key) => key.toString()).toList().map<ConversationVOForHomePage>((key) async {
      //   ConversationVOForHomePage conversationVo = await _firestoreDataAgent.getUserById(key).then((user) async {
      //     var temp = event.snapshot.value[key].keys
      //         .map((key) => int.parse(key))
      //         .toList();
      //
      //     temp.sort();
      //     lastMessageId = temp[temp.length - 1];
      //     ConversationVOForHomePage c2 = await getLastMessageById(key, lastMessageId).then((message) {
      //       return ConversationVOForHomePage(
      //         conversationId: key,
      //         name: user.userName ?? "",
      //         profileImage: user.profilePicture ?? "",
      //         lastMessage: message.message ?? "",
      //       );
      //     });
      //     return c2;
      //   });
      //   return conversationVo;
      // }).toList();
      // return result;

      // List<String> contactIdList = event.snapshot.value.keys.toList().map<String>((key) => key.toString()).toList();
      // List<Future<ConversationVOForHomePage>> conversationList = contactIdList.map<Future<ConversationVOForHomePage>>((contactId) async {
      //   UserVO user = await _firestoreDataAgent.getUserById(contactId);
      //   List<int> messageList = event.snapshot.value[contactId].keys.map<int>((messageId) => int.parse(messageId)).toList();
      //   messageList.sort();
      //   int lastMessageId = messageList[messageList.length - 1];
      //   MessageVO messageVo = await getLastMessageById(contactId, lastMessageId);
      //   return ConversationVOForHomePage(
      //     conversationId: contactId,
      //     name: user.userName ?? "",
      //     profileImage: user.profilePicture ?? "",
      //     lastMessage: messageVo.message ?? "",
      //   );
      // }).toList();
      // return Stream.value(conversationList);
      if(event.snapshot.value?.keys != null) {
        List<String> contactIdList = event.snapshot.value.keys.toList().map<String>((key) => key.toString()).toList();
        var result = contactIdList.map<Future<ConversationVOForHomePage>>((contactId) async {

          UserVO user = await _firestoreDataAgent.getUserById(contactId);

          List<int> messageList = event.snapshot.value[contactId].keys.toList()
              .map<int>((messageId) => int.parse(messageId))
              .toList();
          messageList.sort();
          int lastMessageId = messageList[messageList.length - 1];


          MessageVO messageVo =
          await getLastMessageById(loggedInUserId, contactId, lastMessageId);
          // await Future.delayed(Duration(seconds: 2));
          ConversationVOForHomePage conversation = ConversationVOForHomePage(
            conversationId: contactId,
            name: user.userName ?? "",
            profileImage: user.profilePicture ?? "",
            lastMessage: messageVo.message ?? "",
            userVo: user,
          );
          return conversation;
        }).toList();

        return result;
      } else {
        return [];
      }
    });
  }

  Future<MessageVO> getLastMessageById(String loggedInUserId, String contactId, int lastMessageId) {
    return databaseRef
        .child(contactsAndMessagesPath)
        .child(loggedInUserId)
        .child(contactId)
        .child(lastMessageId.toString())
        .once()
        .then((snapShot) {
      return MessageVO.fromJson(Map<String, dynamic>.from(snapShot.value));
    });
  }

  @override
  Future<void> deleteConversationFromLoggedInUser(String loggedInUserId, String conversationId) {
    return databaseRef
    .child(contactsAndMessagesPath)
        .child(loggedInUserId)
        .child(conversationId)
        .remove();
  }

  @override
  Future<void> deleteConversationFromChatUser(String loggedInUserId, String conversationId) {
    return databaseRef
    .child(contactsAndMessagesPath)
        .child(conversationId)
        .child(loggedInUserId)
        .remove();
  }



}
