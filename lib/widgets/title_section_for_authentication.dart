import 'package:flutter/material.dart';
import 'package:we_chat_app/resources/dimens.dart';

class TitleSectionForAuthentication extends StatelessWidget {

  final String title;

  TitleSectionForAuthentication({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: MARGIN_XXLARGE - 8),
      child: Text(
        title,
        style: TextStyle(
          color: Color.fromRGBO(202, 202, 202, 1.0),
          fontSize: TEXT_REGULAR_3X,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
