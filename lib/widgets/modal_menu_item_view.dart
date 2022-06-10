import 'package:flutter/material.dart';
import 'package:we_chat_app/resources/dimens.dart';

class ModalMenuItemView extends StatelessWidget {
  final String text;

  ModalMenuItemView({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: MARGIN_MEDIUM_2),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
              color: Color.fromRGBO(198, 198, 198, 1.0),
              fontSize: TEXT_REGULAR_2X),
        ),
      ),
    );
  }
}
