import 'package:flutter/material.dart';
import 'package:we_chat_app/resources/colors.dart';
import 'package:we_chat_app/resources/dimens.dart';

class TitleSectionForAuthentication extends StatelessWidget {

  final String title;

  TitleSectionForAuthentication({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: MARGIN_XXLARGE - 8),
      child: Text(
        "Log In via WeChat ID/Email/QQ ID",
        style: const TextStyle(
          color: AUTHENTICATION_PAGE_TITLE_TEXT_COLOR,
          fontSize: TEXT_REGULAR_3X,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
