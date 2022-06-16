import 'package:flutter/material.dart';
import 'package:we_chat_app/data/vos/conversation_vo_for_home_page.dart';
import 'package:we_chat_app/dummy/chat_vo.dart';
import 'package:we_chat_app/resources/dimens.dart';

class ConversationItemView extends StatelessWidget {
  const ConversationItemView({
    Key? key,
    required this.avatarRadius,
    required this.conversation,
  }) : super(key: key);

  final double avatarRadius;
  final ConversationVOForHomePage conversation;

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
                    ((conversation.profileImage ?? "").isNotEmpty) ? conversation.profileImage ?? "" : "https://collegecore.com/wp-content/uploads/2018/05/facebook-no-profile-picture-icon-620x389.jpg",
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
                            conversation.name ?? "",
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
                        conversation.lastMessage ?? "",
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
