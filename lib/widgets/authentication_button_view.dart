import 'package:flutter/material.dart';
import 'package:we_chat_app/pages/sign_up_privacy_policy_page.dart';
import 'package:we_chat_app/pages/we_chat_app.dart';
import 'package:we_chat_app/resources/colors.dart';
import 'package:we_chat_app/resources/dimens.dart';

class AuthenticationButtonView extends StatelessWidget {

  final bool isCheckTermsAndPolicy;


  AuthenticationButtonView({required this.isCheckTermsAndPolicy});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 50,
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all((isCheckTermsAndPolicy) ? PRIMARY_COLOR : Color.fromRGBO(255, 255, 255, 0.1)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
            ),
          ),
        ),
        onPressed: (isCheckTermsAndPolicy) ? () {
          _navigateToPrivacyPolicyPage(context);
        } : null,
        child: Text(
          "Accept and Continue",
          style: TextStyle(
            color: (isCheckTermsAndPolicy) ? Colors.white : Color.fromRGBO(255, 255, 255, 0.2),
          ),
        ),
      ),
    );
  }

  void _navigateToPrivacyPolicyPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SignUpPrivacyPolicyPage(),
      ),
    );
  }
}
