import 'package:flutter/material.dart';
import 'package:we_chat_app/resources/dimens.dart';

class ChatFunctionItemView extends StatelessWidget {
  final IconData icon;
  final String label;

  ChatFunctionItemView({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: MARGIN_XLARGE,
              color: Color.fromRGBO(152, 152, 152, 1.0),
            ),
            SizedBox(height: MARGIN_MEDIUM),
            Text(
              label,
              style: TextStyle(
                color: Color.fromRGBO(0, 0, 0, 0.4),
                fontSize: TEXT_REGULAR - 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
