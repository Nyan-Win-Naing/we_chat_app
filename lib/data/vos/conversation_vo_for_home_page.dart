
import 'package:json_annotation/json_annotation.dart';
import 'package:we_chat_app/data/vos/user_vo.dart';

part 'conversation_vo_for_home_page.g.dart';

@JsonSerializable()
class ConversationVOForHomePage {
  String? name;
  String? profileImage;
  String? conversationId;
  String? lastMessage;
  UserVO? userVo;

  ConversationVOForHomePage({
    this.name,
    this.profileImage,
    this.conversationId,
    this.lastMessage,
    this.userVo,
  });


  @override
  String toString() {
    return 'ConversationVOForHomePage{name: $name, lastMessage: $lastMessage, userVo: $userVo}';
  }

  factory ConversationVOForHomePage.fromJson(Map<String, dynamic> json) =>
      _$ConversationVOForHomePageFromJson(json);

  Map<String, dynamic> toJson() => _$ConversationVOForHomePageToJson(this);
}
