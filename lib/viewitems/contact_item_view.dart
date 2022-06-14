import 'package:flutter/material.dart';
import 'package:we_chat_app/data/vos/user_vo.dart';
import 'package:we_chat_app/resources/dimens.dart';

class ContactItemView extends StatelessWidget {
  const ContactItemView({
    Key? key,
    required this.avatarRadius,
    required this.user,
  }) : super(key: key);

  final double avatarRadius;
  final UserVO? user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            height: 80,
            child: Row(
              children: [
                CircleAvatar(
                  radius: avatarRadius,
                  backgroundImage: NetworkImage(
                    ((user?.profilePicture ?? "").isNotEmpty) ? user?.profilePicture ?? "" : "https://collegecore.com/wp-content/uploads/2018/05/facebook-no-profile-picture-icon-620x389.jpg",
                  ),
                ),
                SizedBox(width: MARGIN_MEDIUM_3),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user?.userName ?? "",
                      style: TextStyle(
                        fontSize: TEXT_REGULAR_3X,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: MARGIN_SMALL),
                    Text(
                      "No Organization",
                      style: TextStyle(
                        color: Color.fromRGBO(191,191,191, 1.0),
                        fontSize: TEXT_REGULAR,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            color: Color.fromRGBO(0, 0, 0, 0.1),
            width: MediaQuery.of(context).size.width * 2 / 3,
            height: 1,
          )
        ],
      ),
    );
  }
}