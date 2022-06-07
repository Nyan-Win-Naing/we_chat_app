import 'package:flutter/material.dart';
import 'package:we_chat_app/resources/dimens.dart';

class EachProfileSectionItemView extends StatelessWidget {
  final String label;
  final IconData iconData;

  EachProfileSectionItemView({required this.label, required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Color.fromRGBO(243, 243, 243, 1.0),
          width: 0.5,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              iconData,
              size: MARGIN_XLARGE + 8,
              color: Color.fromRGBO(139, 139, 139, 1.0),
            ),
            SizedBox(height: MARGIN_MEDIUM),
            Text(
              label,
              style: TextStyle(
                color: Color.fromRGBO(139, 139, 139, 1.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
