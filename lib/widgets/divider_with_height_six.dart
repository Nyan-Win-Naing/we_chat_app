import 'package:flutter/material.dart';
import 'package:we_chat_app/resources/colors.dart';

class DividerWithHeightSix extends StatelessWidget {
  const DividerWithHeightSix({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 6,
      color: DIVDER_COLOR,
    );
  }
}