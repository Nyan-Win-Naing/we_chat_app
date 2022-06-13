import 'package:json_annotation/json_annotation.dart';

part 'user_vo.g.dart';

@JsonSerializable()
class UserVO {
  @JsonKey(name: "id")
  String? id;

  @JsonKey(name: "user_name")
  String? userName;

  @JsonKey(name: "phone")
  String? phone;

  @JsonKey(name: "password")
  String? password;

  @JsonKey(name: "email")
  String? email;

  @JsonKey(name: "profile_picture")
  String? profilePicture;

  @JsonKey(name: "qr_code")
  String? qrCode;

  @JsonKey(name: "fcm_token")
  String? fcmToken;

  UserVO({
    this.id,
    this.userName,
    this.phone,
    this.password,
    this.email,
    this.profilePicture,
    this.qrCode,
    this.fcmToken,
  });

  factory UserVO.fromJson(Map<String, dynamic> json) =>
      _$UserVOFromJson(json);

  Map<String, dynamic> toJson() => _$UserVOToJson(this);

  @override
  String toString() {
    return 'UserVO{id: $id, userName: $userName, phone: $phone, password: $password, email: $email, profilePicture: $profilePicture, qrCode: $qrCode, fcmToken: $fcmToken}';
  }
}
