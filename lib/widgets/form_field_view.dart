import 'package:flutter/material.dart';
import 'package:we_chat_app/resources/colors.dart';
import 'package:we_chat_app/resources/dimens.dart';

class FormFieldView extends StatefulWidget {

  FormFieldView({
    required this.screenWidth,
    required this.label,
    required this.hintText,
    this.isTextField = true,
  });

  final double screenWidth;
  final String label;
  final String hintText;
  bool isTextField;

  @override
  State<FormFieldView> createState() => _FormFieldViewState();
}

class _FormFieldViewState extends State<FormFieldView> {

  bool isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
      EdgeInsets.only(bottom: (!widget.isTextField) ? MARGIN_MEDIUM : 0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
              color: (!isFocused)
                  ? Color.fromRGBO(255, 255, 255, 0.05)
                  : PRIMARY_COLOR,
              width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.label,
            style: TextStyle(
              color: Colors.white,
              fontSize: TEXT_REGULAR_2X,
              fontWeight: FontWeight.w400,
            ),
          ),
          Container(
            width: widget.screenWidth * 2 / 3,
            child: (widget.isTextField)
                ? FocusScope(
              child: Focus(
                onFocusChange: (focus) {
                  setState(() {
                    isFocused = focus;
                  });
                },
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: widget.hintText,
                    hintStyle: TextStyle(
                      color: Color.fromRGBO(94, 94, 94, 1.0),
                      fontSize: TEXT_REGULAR_2X,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            )
                : Text(
              widget.hintText,
              style: TextStyle(
                color: Colors.white,
                fontSize: TEXT_REGULAR_2X,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
