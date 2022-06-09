import 'package:flutter/material.dart';
import 'package:we_chat_app/pages/we_chat_app.dart';
import 'package:we_chat_app/resources/colors.dart';
import 'package:we_chat_app/resources/dimens.dart';

class AuthenticationButtonView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 50,
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(PRIMARY_COLOR),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
            ),
          ),
        ),
        onPressed: () {
          _navigateToWeChatApp(context);
        },
        child: Text(
          "Accept and Continue",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void _navigateToWeChatApp(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WeChatApp(),
      ),
    );
  }
}
