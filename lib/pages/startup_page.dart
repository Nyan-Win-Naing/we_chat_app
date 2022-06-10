import 'package:flutter/material.dart';
import 'package:we_chat_app/pages/login_page.dart';
import 'package:we_chat_app/pages/sign_up_by_phone_page.dart';
import 'package:we_chat_app/resources/colors.dart';
import 'package:we_chat_app/resources/dimens.dart';
import 'package:we_chat_app/resources/strings.dart';
import 'package:we_chat_app/widgets/modal_menu_item_view.dart';

class StartupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/we_chat_background.jpg",
            fit: BoxFit.fill,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          const Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding:
                  EdgeInsets.only(top: MARGIN_XXLARGE, right: MARGIN_MEDIUM_2),
              child: Text(
                START_UP_PAGE_LANGUAGE_TEXT,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: MARGIN_MEDIUM_2, bottom: MARGIN_XLARGE),
              child: StartupPageButtonView(),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(
                  right: MARGIN_MEDIUM_2, bottom: MARGIN_XLARGE),
              child: StartupPageButtonView(
                isLogIn: false,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class StartupPageButtonView extends StatelessWidget {
  final bool isLogIn;

  StartupPageButtonView({this.isLogIn = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 45,
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all((isLogIn)
              ? START_UP_PAGE_LOG_IN_BUTTON_COLOR
              : START_UP_PAGE_SIGN_UP_BUTTON_COLOR),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
            ),
          ),
        ),
        onPressed: () {
          if (!isLogIn) {
            showBottomSheetWhenSignUp(context);
          } else {
            _navigateToLoginPage(context);
          }
        },
        child: Text(
          (isLogIn) ? START_UP_PAGE_LOGIN_TEXT : START_UP_PAGE_SIGN_UP_TEXT,
          style: const TextStyle(
            color: Colors.white,
            fontSize: TEXT_REGULAR_2X,
          ),
        ),
      ),
    );
  }

  void showBottomSheetWhenSignUp(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: BOTTOM_SHEET_BACKGROUND_COLOR,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(MARGIN_MEDIUM_2),
              topRight: Radius.circular(MARGIN_MEDIUM_2),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  _navigateToSignUpByPhonePage(context);
                },
                child: ModalMenuItemView(
                    text: START_UP_BOTTOM_SHEET_SIGN_UP_VIA_MOBILE),
              ),
              Container(
                height: 1,
                color: BOTTOM_SHEET_SMALL_DIVIDER_COLOR,
              ),
              ModalMenuItemView(
                  text: START_UP_BOTTOM_SHEET_SIGN_UP_VIA_FACEBOOK),
              Container(
                height: 6,
                color: BOTTOM_SHEET_LARGE_DIVIDER_COLOR,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: ModalMenuItemView(text: CANCEL_TEXT),
              ),
            ],
          ),
        );
      },
    );
  }

  void _navigateToSignUpByPhonePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SignUpByPhonePage(),
      ),
    );
  }

  void _navigateToLoginPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }
}
