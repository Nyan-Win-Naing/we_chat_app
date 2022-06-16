import 'package:we_chat_app/data/vos/conversation_vo_for_home_page.dart';
import 'package:we_chat_app/data/vos/message_vo.dart';
import 'package:we_chat_app/data/vos/user_vo.dart';

abstract class ChatDataAgent {
  /// Chat
  Future<void> sendNewMessage(MessageVO message, UserVO? userVo);
  Stream<List<MessageVO>> getMessages(String loggedInUserId, String sentUserId);
  Stream<List<Future<ConversationVOForHomePage>>> getConversations(String loggedInUserId);
  Future<void> deleteConversationFromLoggedInUser(String loggedInUserId, String conversationId);
  Future<void> deleteConversationFromChatUser(String loggedInUserId, String conversationId);
}