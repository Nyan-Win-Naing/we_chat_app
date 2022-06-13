// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserVO _$UserVOFromJson(Map<String, dynamic> json) => UserVO(
      id: json['id'] as String?,
      userName: json['user_name'] as String?,
      phone: json['phone'] as String?,
      password: json['password'] as String?,
      email: json['email'] as String?,
      profilePicture: json['profile_picture'] as String?,
      qrCode: json['qr_code'] as String?,
      fcmToken: json['fcm_token'] as String?,
    );

Map<String, dynamic> _$UserVOToJson(UserVO instance) => <String, dynamic>{
      'id': instance.id,
      'user_name': instance.userName,
      'phone': instance.phone,
      'password': instance.password,
      'email': instance.email,
      'profile_picture': instance.profilePicture,
      'qr_code': instance.qrCode,
      'fcm_token': instance.fcmToken,
    };
