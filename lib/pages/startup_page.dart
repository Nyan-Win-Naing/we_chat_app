import 'package:flutter/material.dart';
import 'package:we_chat_app/pages/login_page.dart';
import 'package:we_chat_app/pages/sign_up_by_phone_page.dart';
import 'package:we_chat_app/resources/dimens.dart';
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
            height: MediaQuery.of(context).size.height,
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: MARGIN_XXLARGE, right: MARGIN_MEDIUM_2),
              child: Text(
                "Language",
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
              ? Color.fromRGBO(7, 193, 96, 1.0)
              : Color.fromRGBO(25, 25, 25, 1.0)),
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
          (isLogIn) ? "Log In" : "Sign Up",
          style: TextStyle(
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
          decoration: BoxDecoration(
            color: Color.fromRGBO(44, 44, 44, 1.0),
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
                  _navigateToSignUpByPhonePage(context);
                },
                child: ModalMenuItemView(text: "Sign up via Mobile"),
              ),
              Container(
                height: 1,
                color: Color.fromRGBO(255, 255, 255, 0.05),
              ),
              ModalMenuItemView(text: "Sign up via Facebook"),
              Container(
                height: 6,
                color: Color.fromRGBO(30, 30, 30, 1.0),
              ),
              ModalMenuItemView(text: "Cancel"),
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