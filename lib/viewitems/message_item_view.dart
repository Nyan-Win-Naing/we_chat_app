import 'package:flutter/material.dart';
import 'package:we_chat_app/dummy/chat_vo.dart';
import 'package:we_chat_app/resources/dimens.dart';

class MessageItemView extends StatelessWidget {

  ChatVO? chatVo;

  MessageItemView({required this.chatVo});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: (chatVo?.isMe ?? false) ? const EdgeInsets.only(left: 60) : const EdgeInsets.only(right: 60),
      child: Row(
        mainAxisAlignment: (chatVo?.isMe ?? false) ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          (chatVo?.isMe ?? false ) ? Container() : CircleAvatar(
            radius: screenHeight / 32,
            backgroundImage: NetworkImage(
              "https://cutewallpaper.org/21/boy-profile-pic/198+-Cute-Boy-Profile-Images-Pictures-Wallpaper-For-Whatsapp-DP.jpg",
            ),
          ),
          SizedBox(width: MARGIN_MEDIUM),
          Flexible(
            flex: 1,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: MARGIN_CARD_MEDIUM_2, vertical: 10),
              decoration: BoxDecoration(
                color: Color.fromRGBO(243, 243, 243, 1.0),
                borderRadius: BorderRadius.circular(MARGIN_LARGE),
              ),
              child: Text(
                chatVo?.message ?? "",
                style: TextStyle(
                  color: Color.fromRGBO(111,111,111, 1.0),
                  fontSize: TEXT_REGULAR_2X,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
