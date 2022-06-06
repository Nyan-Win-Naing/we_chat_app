import 'package:flutter/material.dart';

class DividerWithHeightSix extends StatelessWidget {
  const DividerWithHeightSix({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 6,
      color: Color.fromRGBO(214, 214, 214, 1.0),
    );
  }
}