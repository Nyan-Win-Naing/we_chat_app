// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageVO _$MessageVOFromJson(Map<String, dynamic> json) => MessageVO(
      imageFile: json['image_file'] as String?,
      videoFile: json['video_file'] as String?,
      message: json['message'] as String?,
      name: json['name'] as String?,
      profilePic: json['profile_pic'] as String?,
      timeStamp: json['time_stamp'] as int?,
      userId: json['user_id'] as String?,
    );

Map<String, dynamic> _$MessageVOToJson(MessageVO instance) => <String, dynamic>{
      'image_file': instance.imageFile,
      'video_file': instance.videoFile,
      'message': instance.message,
      'name': instance.name,
      'profile_pic': instance.profilePic,
      'time_stamp': instance.timeStamp,
      'user_id': instance.userId,
    };
