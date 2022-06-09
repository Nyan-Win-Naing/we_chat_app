import 'package:flutter/material.dart';
import 'package:we_chat_app/pages/we_chat_app.dart';
import 'package:we_chat_app/resources/colors.dart';
import 'package:we_chat_app/resources/dimens.dart';
import 'package:we_chat_app/widgets/authentication_button_view.dart';
import 'package:we_chat_app/widgets/form_field_view.dart';
import 'package:we_chat_app/widgets/title_section_for_authentication.dart';

class SignUpByPhonePage extends StatefulWidget {
  @override
  State<SignUpByPhonePage> createState() => _SignUpByPhonePageState();
}

class _SignUpByPhonePageState extends State<SignUpByPhonePage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromRGBO(25, 25, 25, 1.0),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromRGBO(25, 25, 25, 1.0),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.close,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TitleSectionForAuthentication(title: "Sign up by phone number"),
              SizedBox(height: MARGIN_LARGE),
              ImagePickerView(),
              SizedBox(height: MARGIN_XXLARGE),
              RegistrationFormsSectionView(screenWidth: screenWidth),
              SizedBox(height: MARGIN_3XLARGE),
              TermsAndConditionsSectionView(),
              SignUpPageLabelView(),
              SizedBox(height: MARGIN_MEDIUM_2),
              AuthenticationButtonView(),
            ],
          ),
        ),
      ),
    );
  }
}


class SignUpPageLabelView extends StatelessWidget {
  const SignUpPageLabelView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "The information collected on this page is only used for account registration",
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Color.fromRGBO(94, 94, 94, 1.0),
        fontSize: TEXT_REGULAR - 2,
      ),
    );
  }
}

class TermsAndConditionsSectionView extends StatefulWidget {
  @override
  State<TermsAndConditionsSectionView> createState() =>
      _TermsAndConditionsSectionViewState();
}

class _TermsAndConditionsSectionViewState
    extends State<TermsAndConditionsSectionView> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
          checkColor: Colors.white,
          value: isChecked,
          shape: CircleBorder(),
          onChanged: (isCheck) {
            setState(() {
              isChecked = isCheck ?? false;
            });
          },
        ),
        SizedBox(width: MARGIN_SMALL),
        Text(
          "I have read and accept the <<WeChat-Terms\n of Service>>",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color.fromRGBO(94, 94, 94, 1.0),
            fontSize: TEXT_REGULAR - 2,
          ),
        ),
      ],
    );
  }
}

class RegistrationFormsSectionView extends StatelessWidget {
  const RegistrationFormsSectionView({
    Key? key,
    required this.screenWidth,
  }) : super(key: key);

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: MARGIN_CARD_MEDIUM_2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FormFieldView(
            screenWidth: screenWidth,
            label: "Name",
            hintText: "John Appleseed",
          ),
          SizedBox(height: MARGIN_CARD_MEDIUM_2),
          FormFieldView(
            screenWidth: screenWidth,
            label: "Country/\nRegion",
            hintText: "United State (+1)",
            isTextField: false,
          ),
          SizedBox(height: MARGIN_MEDIUM),
          FormFieldView(
            screenWidth: screenWidth,
            label: "Phone",
            hintText: "Enter mobile number",
          ),
          SizedBox(height: MARGIN_MEDIUM),
          FormFieldView(
            screenWidth: screenWidth,
            label: "Password",
            hintText: "Enter password",
          ),
        ],
      ),
    );
  }
}

class ImagePickerView extends StatelessWidget {
  const ImagePickerView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      color: Color.fromRGBO(221, 221, 221, 1.0),
      child: Center(
        child: Icon(
          Icons.camera_alt,
          color: Colors.white,
          size: MARGIN_MEDIUM_3,
        ),
      ),
    );
  }
}

