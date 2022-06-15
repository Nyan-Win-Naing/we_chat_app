import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:we_chat_app/blocs/chat_room_bloc.dart';
import 'package:we_chat_app/data/vos/message_vo.dart';
import 'package:we_chat_app/dummy/chat_vo.dart';
import 'package:we_chat_app/resources/dimens.dart';

class MessageItemView extends StatelessWidget {
  MessageVO? messageVo;
  ChatRoomBloc bloc;

  MessageItemView({required this.messageVo, required this.bloc});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: (bloc.loggedInUserId == (messageVo?.userId ?? ""))
          ? const EdgeInsets.only(left: 60)
          : const EdgeInsets.only(right: 60),
      child: Row(
        mainAxisAlignment: (bloc.loggedInUserId == (messageVo?.userId ?? ""))
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          (bloc.loggedInUserId == (messageVo?.userId ?? ""))
              ? Container()
              : CircleAvatar(
                  radius: screenHeight / 32,
                  backgroundImage: NetworkImage(
                    ((messageVo?.profilePic?.isNotEmpty ?? false)) ? messageVo?.profilePic ?? "" : "https://collegecore.com/wp-content/uploads/2018/05/facebook-no-profile-picture-icon-620x389.jpg",
                  ),
                ),
          SizedBox(width: MARGIN_MEDIUM),
          Flexible(
            flex: 1,
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: MARGIN_CARD_MEDIUM_2, vertical: 10),
              decoration: BoxDecoration(
                color: Color.fromRGBO(243, 243, 243, 1.0),
                borderRadius: BorderRadius.circular(MARGIN_MEDIUM_2),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Visibility(
                    visible: ((messageVo?.message ?? "").isNotEmpty),
                    child: MessageTextView(messageVo: messageVo),
                  ),
                  Visibility(
                    visible: ((messageVo?.imageFile ?? "").isNotEmpty),
                    child: SizedBox(height: MARGIN_CARD_MEDIUM_2),
                  ),
                  Visibility(
                    visible: ((messageVo?.imageFile ?? "").isNotEmpty),
                    child: MessageImageView(messageVo: messageVo),
                  ),
                  Visibility(
                    visible: ((messageVo?.videoFile ?? "").isNotEmpty),
                    child: SizedBox(height: MARGIN_CARD_MEDIUM_2),
                  ),
                  Visibility(
                    visible: ((messageVo?.videoFile ?? "").isNotEmpty),
                    child: MessageVideoView(messageVo: messageVo),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MessageVideoView extends StatefulWidget {
  final MessageVO? messageVo;

  MessageVideoView({required this.messageVo});

  @override
  State<MessageVideoView> createState() => _MessageVideoViewState();
}

class _MessageVideoViewState extends State<MessageVideoView> {
  late FlickManager flickManager;

  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.network(widget.messageVo?.videoFile ?? ""),
    );
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM),
      child: FlickVideoPlayer(flickManager: flickManager),
    );
  }
}

class MessageImageView extends StatelessWidget {
  const MessageImageView({
    Key? key,
    required this.messageVo,
  }) : super(key: key);

  final MessageVO? messageVo;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(MARGIN_SMALL),
      child: FadeInImage(
        width: double.infinity,
        placeholder: NetworkImage(
          "https://t3.ftcdn.net/jpg/04/34/72/82/360_F_434728286_OWQQvAFoXZLdGHlObozsolNeuSxhpr84.jpg",
        ),
        image: NetworkImage(
          messageVo?.imageFile ?? "",
        ),
      ),
    );
  }
}

class MessageTextView extends StatelessWidget {
  const MessageTextView({
    Key? key,
    required this.messageVo,
  }) : super(key: key);

  final MessageVO? messageVo;

  @override
  Widget build(BuildContext context) {
    return Text(
      messageVo?.message ?? "",
      style: TextStyle(
        color: Color.fromRGBO(111, 111, 111, 1.0),
        fontSize: TEXT_REGULAR_2X,
      ),
    );
  }
}
