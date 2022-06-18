import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_chat_app/blocs/home_bloc.dart';
import 'package:we_chat_app/data/vos/conversation_vo_for_home_page.dart';
import 'package:we_chat_app/data/vos/user_vo.dart';
import 'package:we_chat_app/dummy/chat_vo.dart';
import 'package:we_chat_app/dummy/dummy_chat_list.dart';
import 'package:we_chat_app/pages/chat_room_page.dart';
import 'package:we_chat_app/resources/colors.dart';
import 'package:we_chat_app/resources/dimens.dart';
import 'package:we_chat_app/resources/strings.dart';
import 'package:we_chat_app/viewitems/conversation_item_view.dart';
import 'package:we_chat_app/widgets/divider_with_height_six.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final avatarRadius = screenHeight / 22;

    return ChangeNotifierProvider(
      create: (context) => HomeBloc(),
      child: Scaffold(
        backgroundColor: HOME_SCREEEN_BACKGROUND_COLOR,
        appBar: AppBar(
          backgroundColor: PRIMARY_COLOR,
          elevation: 1,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: const Text(
            HOME_PAEG_TITLE,
            style: TextStyle(
              color: Colors.white,
              fontSize: TEXT_REGULAR_2X,
            ),
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: MARGIN_CARD_MEDIUM_2),
              child: Icon(
                Icons.add,
                color: APP_BAR_ACTION_ICON_COLOR,
                size: MARGIN_XLARGE,
              ),
            ),
          ],
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ChatListView(
                  avatarRadius: avatarRadius,
                  onTapDeleteChat: (chatVo) {
                    setState(() {
                      dummyChatList.remove(chatVo);
                    });
                  },
                ),
                Consumer<HomeBloc>(
                  builder: (context, bloc, child) =>
                      (bloc.conversationList.isNotEmpty)
                          ? Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const DividerWithHeightSix(),
                                SizedBox(height: MARGIN_LARGE),
                                const SubscriptionSectionView(),
                                const DividerWithHeightSix(),
                              ],
                            )
                          : Container(),
                ),
                // SizedBox(height: MARGIN_LARGE),
                // ChatListView(
                //   avatarRadius: avatarRadius,
                //   onTapDeleteChat: (chatVo) {
                //     setState(() {
                //       dummyChatList.remove(chatVo);
                //     });
                //   },
                // ),
              ],
            ),
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
      padding: const EdgeInsets.symmetric(
          horizontal: MARGIN_MEDIUM_2, vertical: MARGIN_MEDIUM),
      decoration: const BoxDecoration(
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
                  children: const [
                    Text(
                      CHAT_PAEG_TENCENT_OFFICIAL,
                      style: TextStyle(
                        fontSize: TEXT_REGULAR_2X,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: MARGIN_MEDIUM),
                    Text(
                      CHAT_PAGE_TENCENT_SUBSCRIPTION_DESCRIPTION_ONE,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(0, 0, 0, 0.7),
                      ),
                    ),
                    SizedBox(height: MARGIN_SMALL),
                    Text(
                      CHAT_PAGE_TENCENT_SUBSCRIPTION_DESCRIPTION_TWO,
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
              decoration: const BoxDecoration(
                color: PRIMARY_COLOR,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: MARGIN_MEDIUM),
            const Text(
              CHAT_PAGE_TENCENT_SUBSCRIPTION_TITLE,
              style: TextStyle(
                color: Color.fromRGBO(139, 139, 139, 1.0),
                fontWeight: FontWeight.w600,
                fontSize: TEXT_REGULAR_2X + 2,
              ),
            ),
          ],
        ),
        const Icon(
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
    required this.onTapDeleteChat,
  }) : super(key: key);

  final double avatarRadius;
  final Function(ChatVO) onTapDeleteChat;

  @override
  State<ChatListView> createState() => _ChatListViewState();
}

class _ChatListViewState extends State<ChatListView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeBloc>(builder: (context, bloc, child) {
      if (bloc.conversationList.isNotEmpty) {
        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: bloc.conversationList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                _navigateToConversationPage(
                    context, bloc.conversationList[index].userVo);
              },
              child: Slidable(
                  key: const ValueKey(0),
                  endActionPane: ActionPane(
                    motion: ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (_) {
                          print("Click Clicksss");
                          bloc.onTapDeleteConversation(
                              bloc.conversationList[index].conversationId ??
                                  "");
                        },
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: CHAT_DELETE_LABEL,
                      ),
                    ],
                  ),
                  child: ConversationItemView(
                    avatarRadius: widget.avatarRadius,
                    conversation: bloc.conversationList[index],
                  )),
            );
          },
        );
      } else {
        return Container(
          height: 600,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "No conversation history. Send new messages.",
                  style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 0.3),
                    fontSize: TEXT_REGULAR,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: MARGIN_MEDIUM),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.create_outlined,
                      size: MARGIN_XLARGE,
                      color: Color.fromRGBO(0, 0, 0, 0.3),
                    ),
                    SizedBox(width: MARGIN_SMALL),
                    Icon(
                      Icons.message,
                      size: MARGIN_XLARGE,
                      color: Color.fromRGBO(0, 0, 0, 0.3),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }
    });
  }

  void _navigateToConversationPage(BuildContext context, UserVO? userVo) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatRoomPage(userVo: userVo ?? UserVO()),
      ),
    );
  }
}
