import 'package:flutter/material.dart';
import 'package:we_chat_app/dummy/chat_vo.dart';
import 'package:we_chat_app/resources/dimens.dart';

class ConversationItemView extends StatelessWidget {
  const ConversationItemView({
    Key? key,
    required this.avatarRadius,
    required this.chatVo,
  }) : super(key: key);

  final double avatarRadius;
  final ChatVO chatVo;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Color.fromRGBO(0, 0, 0, 0.1),
          height: 1,
        ),
        Container(
          height: 85,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_3),
            child: Row(
              children: [
                CircleAvatar(
                  radius: avatarRadius,
                  backgroundImage: NetworkImage(
                    chatVo.profile ?? "",
                  ),
                ),
                SizedBox(width: MARGIN_MEDIUM),
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            chatVo.name ?? "",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: TEXT_REGULAR_2X,
                            ),
                          ),
                          Text(
                            "3:21 PM",
                            style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 0.2),
                              fontSize: TEXT_REGULAR,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: MARGIN_MEDIUM),
                      Text(
                        chatVo.lastConversationText ?? "",
                        maxLines: 2,
                        style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 0.4),

                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
