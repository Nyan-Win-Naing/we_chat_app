import 'package:flutter/material.dart';
import 'package:we_chat_app/resources/colors.dart';
import 'package:we_chat_app/resources/dimens.dart';

class FormFieldView extends StatefulWidget {
  FormFieldView({
    required this.screenWidth,
    required this.label,
    required this.hintText,
    this.phoneCode = "",
    this.isTextField = true,
    this.isPhoneField = false,
    this.isPasswordField = false,
    this.currentText = "",
    required this.onChanged,
  });

  final double screenWidth;
  final String label;
  final String hintText;
  final String phoneCode;
  bool isTextField;
  bool isPhoneField;
  bool isPasswordField;
  final Function(String) onChanged;

  String currentText;

  @override
  State<FormFieldView> createState() => _FormFieldViewState();
}

class _FormFieldViewState extends State<FormFieldView> {
  bool isFocused = false;

  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(bottom: (!widget.isTextField) ? MARGIN_MEDIUM : 0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
              color: (!isFocused)
                  ? const Color.fromRGBO(255, 255, 255, 0.05)
                  : PRIMARY_COLOR,
              width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: TEXT_REGULAR_2X,
              fontWeight: FontWeight.w400,
            ),
          ),
          Container(
            width: widget.screenWidth * 1.8 / 3,
            child: (widget.isTextField)
                ? FocusScope(
                    child: Focus(
                      onFocusChange: (focus) {
                        setState(() {
                          isFocused = focus;
                        });
                      },
                      child: TextField(
                        onChanged: (text) {
                          widget.onChanged(text);
                        },
                        controller: (widget.currentText.isNotEmpty) ? (_controller..text = widget.currentText ..selection = TextSelection.collapsed(offset: _controller.text.length)) : _controller,
                        style: TextStyle(color: Colors.white),
                        keyboardType: widget.isPhoneField ? TextInputType.number : null,
                        obscureText: (widget.isPasswordField) ? true : false,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: widget.hintText,
                          hintStyle: const TextStyle(
                            color: Color.fromRGBO(94, 94, 94, 1.0),
                            fontSize: TEXT_REGULAR_2X,
                            fontWeight: FontWeight.w400,
                          ),
                          prefixIconConstraints:
                              BoxConstraints(minWidth: 0, minHeight: 0),
                          isDense: true,
                          prefixIcon: (widget.isPhoneField)
                              ? Text(
                                  "${widget.phoneCode} ",
                                  style: TextStyle(
                                    color: Color.fromRGBO(255, 255, 255, 0.7),
                                    fontSize: TEXT_REGULAR_2X,
                                  ),
                                )
                              : null,
                        ),
                      ),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.hintText,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: TEXT_REGULAR_2X,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: Color.fromRGBO(94, 94, 94, 1.0),
                        size: MARGIN_MEDIUM_3,
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
