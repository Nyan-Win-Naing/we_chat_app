import 'package:flutter/material.dart';
import 'package:we_chat_app/pages/sign_up_privacy_policy_page.dart';
import 'package:we_chat_app/pages/we_chat_app.dart';
import 'package:we_chat_app/resources/colors.dart';
import 'package:we_chat_app/resources/dimens.dart';

class AuthenticationButtonView extends StatelessWidget {
  final bool isButtonEnabled;
  String buttonLabel;
  final Function onTapNavigate;

  AuthenticationButtonView({
    required this.isButtonEnabled,
    required this.onTapNavigate,
    this.buttonLabel = "Accept and Continue",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 50,
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all((isButtonEnabled)
              ? PRIMARY_COLOR
              : Color.fromRGBO(255, 255, 255, 0.1)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
            ),
          ),
        ),
        onPressed: (isButtonEnabled)
            ? () {
                onTapNavigate();
              }
            : null,
        child: Text(
          buttonLabel,
          style: TextStyle(
            color: (isButtonEnabled)
                ? Colors.white
                : Color.fromRGBO(255, 255, 255, 0.2),
          ),
        ),
      ),
    );
  }
}
