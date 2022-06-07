import 'package:flutter/material.dart';
import 'package:we_chat_app/resources/colors.dart';
import 'package:we_chat_app/resources/dimens.dart';
import 'package:we_chat_app/viewitems/conversation_item_view.dart';
import 'package:we_chat_app/widgets/DividerWithHeightSix.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final avatarRadius = screenHeight / 22;

    return Scaffold(
      backgroundColor: Color.fromRGBO(242, 243, 242, 1.0),
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        elevation: 1,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          "WeChat",
          style: TextStyle(
            color: Colors.white,
            fontSize: TEXT_REGULAR_2X,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: MARGIN_CARD_MEDIUM_2),
            child: Icon(
              Icons.add,
              color: Color.fromRGBO(255, 255, 255, 0.7),
              size: MARGIN_XLARGE,
            ),
          ),
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ChatListView(avatarRadius: avatarRadius),
              DividerWithHeightSix(),
              SizedBox(height: MARGIN_LARGE),
              SubscriptionSectionView(),
              DividerWithHeightSix(),
              SizedBox(height: MARGIN_LARGE),
              ChatListView(avatarRadius: avatarRadius),
            ],
          ),
        ),
      ),
    );
  }
}

class SubscriptionSectionView extends StatelessWidget {
  const SubscriptionSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      padding: EdgeInsets.symmetric(
          horizontal: MARGIN_MEDIUM_2, vertical: MARGIN_MEDIUM),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(width: 2.0, color: Color.fromRGBO(0, 0, 0, 0.1)),
        ),
      ),
      child: Column(
        children: [
          SubscriptionTitleView(),
          SizedBox(height: MARGIN_MEDIUM),
          Row(
            children: [
              Image.network(
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkyEnxzQ1tmT5hJsFpHglT-VkGRWtxP30jBuK4f6Jf5APPOrWiDAkFrId3yeGmv40lIX8&usqp=CAU",
                height: 60,
              ),
              SizedBox(width: MARGIN_MEDIUM_3),
              Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tencent Official",
                      style: TextStyle(
                        fontSize: TEXT_REGULAR_2X,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: MARGIN_MEDIUM),
                    Text(
                      "WeChat Now is Available in India And ..",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(0, 0, 0, 0.7),
                      ),
                    ),
                    SizedBox(height: MARGIN_SMALL),
                    Text(
                      "Our app is being promoted in India via gaming site Ibibo. The 'moments', and ...",
                      style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 0.4),
                        fontSize: TEXT_REGULAR - 1,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SubscriptionTitleView extends StatelessWidget {
  const SubscriptionTitleView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: PRIMARY_COLOR,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: MARGIN_MEDIUM),
            Text(
              "SUBSCRIPTIONS",
              style: TextStyle(
                color: Color.fromRGBO(139, 139, 139, 1.0),
                fontWeight: FontWeight.w600,
                fontSize: TEXT_REGULAR_2X + 2,
              ),
            ),
          ],
        ),
        Icon(
          Icons.chevron_right,
          color: Color.fromRGBO(0, 0, 0, 0.6),
          size: MARGIN_XLARGE,
        ),
      ],
    );
  }
}

class ChatListView extends StatefulWidget {
  const ChatListView({
    Key? key,
    required this.avatarRadius,
  }) : super(key: key);

  final double avatarRadius;

  @override
  State<ChatListView> createState() => _ChatListViewState();
}

class _ChatListViewState extends State<ChatListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 4,
      itemBuilder: (context, index) {
        return ConversationItemView(avatarRadius: widget.avatarRadius);
      },
    );
  }
}
