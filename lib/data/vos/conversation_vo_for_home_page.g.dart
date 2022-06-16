// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation_vo_for_home_page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConversationVOForHomePage _$ConversationVOForHomePageFromJson(
        Map<String, dynamic> json) =>
    ConversationVOForHomePage(
      name: json['name'] as String?,
      profileImage: json['profileImage'] as String?,
      conversationId: json['conversationId'] as String?,
      lastMessage: json['lastMessage'] as String?,
      userVo: json['userVo'] == null
          ? null
          : UserVO.fromJson(json['userVo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ConversationVOForHomePageToJson(
        ConversationVOForHomePage instance) =>
    <String, dynamic>{
      'name': instance.name,
      'profileImage': instance.profileImage,
      'conversationId': instance.conversationId,
      'lastMessage': instance.lastMessage,
      'userVo': instance.userVo,
    };
