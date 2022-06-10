import 'package:flutter/material.dart';
import 'package:we_chat_app/pages/add_new_post_page.dart';
import 'package:we_chat_app/pages/chat_room_page.dart';
import 'package:we_chat_app/pages/contact_page.dart';
import 'package:we_chat_app/pages/home_page.dart';
import 'package:we_chat_app/pages/moment_page.dart';
import 'package:we_chat_app/pages/profile_page.dart';
import 'package:we_chat_app/resources/colors.dart';
import 'package:we_chat_app/resources/dimens.dart';
import 'package:we_chat_app/resources/strings.dart';

class WeChatApp extends StatefulWidget {
  const WeChatApp({Key? key}) : super(key: key);

  @override
  State<WeChatApp> createState() => _WeChatAppState();
}

class _WeChatAppState extends State<WeChatApp> {

  int bottomNavIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      bottomNavIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: getScreen(bottomNavIndex),
      // body: AddNewPost(),
      // body: ChatRoomPage(),

      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.wechat_outlined, size: MARGIN_XLARGE + 5),
            label: BOTTOM_NAVIGATION_WE_CHAT_TEXT,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contact_mail_outlined, size: MARGIN_XLARGE + 5),
            label: BOTTOM_NAVIGATION_CONTACTS_TEXT,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.compass_calibration_rounded, size: MARGIN_XLARGE + 5),
            label: BOTTOM_NAVIGATION_DISCOVER_TEXT,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: MARGIN_XLARGE + 5),
            label: BOTTOM_NAVIGATION_ME_TEXT,
          ),
        ],
        currentIndex: bottomNavIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: PRIMARY_COLOR,
        onTap: _onItemTapped,
        selectedFontSize: 12.0,
        unselectedItemColor: WE_CHAT_APP_BOTTOM_NAVIGATION_UNSELECTED_COLOR,
      ),
    );
  }
}

Widget getScreen(int bottomNavIndex) {
  if(bottomNavIndex == 0) {
    return HomePage();
  } else if(bottomNavIndex == 1) {
    return ContactPage();
  } else if(bottomNavIndex == 2) {
    return MomentPage();
  } else {
    return ProfilePage();
  }
}
