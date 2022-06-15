import 'package:json_annotation/json_annotation.dart';

part 'message_vo.g.dart';

@JsonSerializable()
class MessageVO {
  @JsonKey(name: "image_file")
  String? imageFile;

  @JsonKey(name: "video_file")
  String? videoFile;

  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "name")
  String? name;

  @JsonKey(name: "profile_pic")
  String? profilePic;

  @JsonKey(name: "time_stamp")
  int? timeStamp;

  @JsonKey(name: "user_id")
  String? userId;

  MessageVO({
    this.imageFile,
    this.videoFile,
    this.message,
    this.name,
    this.profilePic,
    this.timeStamp,
    this.userId,
  });

  factory MessageVO.fromJson(Map<String, dynamic> json) =>
      _$MessageVOFromJson(json);

  Map<String, dynamic> toJson() => _$MessageVOToJson(this);
}
