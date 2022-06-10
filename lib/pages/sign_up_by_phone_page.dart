import 'package:flutter/material.dart';
import 'package:we_chat_app/pages/we_chat_app.dart';
import 'package:we_chat_app/resources/colors.dart';
import 'package:we_chat_app/resources/dimens.dart';
import 'package:we_chat_app/resources/strings.dart';
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
      backgroundColor: AUTHENTICATION_PAGE_BACKGROUND_COLOR,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AUTHENTICATION_PAGE_BACKGROUND_COLOR,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
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
              TitleSectionForAuthentication(title: SIGN_UP_PAGE_TITLE),
              const SizedBox(height: MARGIN_LARGE),
              const ImagePickerView(),
              const SizedBox(height: MARGIN_XXLARGE),
              RegistrationFormsSectionView(screenWidth: screenWidth),
              const SizedBox(height: MARGIN_3XLARGE),
              TermsAndConditionsSectionView(),
              const SignUpPageLabelView(),
              const SizedBox(height: MARGIN_MEDIUM_2),
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
    return const Text(
      SIGN_UP_PAGE_DESCRIPTION,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: LOG_IN_DESCRIPTION_COLOR,
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
        const Text(
          SIGN_UP_PAGE_ACCEPT_TERMS_AND_POLICY,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: LOG_IN_DESCRIPTION_COLOR,
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
            label: NAME_FIELD_LABEL,
            hintText: NAME_FIELD_HINT_TEXT,
          ),
          const SizedBox(height: MARGIN_CARD_MEDIUM_2),
          FormFieldView(
            screenWidth: screenWidth,
            label: COUNTRY_REGION_FIELD_LABEL,
            hintText: "United State (+1)",
            isTextField: false,
          ),
          const SizedBox(height: MARGIN_MEDIUM),
          FormFieldView(
            screenWidth: screenWidth,
            label: PHONE_FIELD_LABEL_TEXT,
            hintText: PHONE_FIELD_HINT_TEXT,
          ),
          const SizedBox(height: MARGIN_MEDIUM),
          FormFieldView(
            screenWidth: screenWidth,
            label: PASSWORD_FIELD_LABEL_TEXT,
            hintText: PASSWORD_FIELD_HINT_TEXT,
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
      color: SIGN_UP_PAGE_IMAGE_PICKER_BACKGROUND,
      child: const Center(
        child: Icon(
          Icons.camera_alt,
          color: Colors.white,
          size: MARGIN_MEDIUM_3,
        ),
      ),
    );
  }
}

