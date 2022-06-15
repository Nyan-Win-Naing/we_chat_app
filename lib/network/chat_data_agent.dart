import 'package:we_chat_app/data/vos/message_vo.dart';
import 'package:we_chat_app/data/vos/user_vo.dart';

abstract class ChatDataAgent {
  /// Chat
  Future<void> sendNewMessage(MessageVO message, UserVO? userVo);
  Stream<List<MessageVO>> getMessages(String loggedInUserId, String sentUserId);

}