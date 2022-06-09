import 'package:flutter/material.dart';
import 'package:we_chat_app/resources/dimens.dart';

class ContactItemView extends StatelessWidget {
  const ContactItemView({
    Key? key,
    required this.avatarRadius,
    required this.name,
  }) : super(key: key);

  final double avatarRadius;
  final String name;

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
                    "https://1.bp.blogspot.com/-xkOa184EX9w/XVhTRa2WRQI/AAAAAAAAb1E/jPDX8jZ8mAIsqqNEDgb8lmfKbttdP1BDACLcBGAs/s1600/Profile-Picture-For-Boys%2B%252812%2529.jpg",
                  ),
                ),
                SizedBox(width: MARGIN_MEDIUM_3),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: TEXT_REGULAR_3X,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: MARGIN_SMALL),
                    Text(
                      "Fair Issac Corporation",
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