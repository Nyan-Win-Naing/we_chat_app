import 'package:flutter/material.dart';
import 'package:we_chat_app/resources/colors.dart';
import 'package:we_chat_app/resources/dimens.dart';
import 'package:we_chat_app/resources/strings.dart';
import 'package:we_chat_app/widgets/authentication_button_view.dart';
import 'package:we_chat_app/widgets/form_field_view.dart';
import 'package:we_chat_app/widgets/modal_menu_item_view.dart';
import 'package:we_chat_app/widgets/title_section_for_authentication.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoginWithMail = false;

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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TitleSectionForAuthentication(title: LOG_IN_VIA_MOBILE_NUMBER),
            const SizedBox(height: MARGIN_XXLARGE),
            LoginFieldsSectionView(
                screenWidth: screenWidth, isLoginWithMail: isLoginWithMail),
            const SizedBox(height: MARGIN_MEDIUM_3),
            GestureDetector(
              onTap: () {
                if(!isLoginWithMail) {
                  showBottomSheet(context);
                } else {
                  setState(() {
                    isLoginWithMail = !isLoginWithMail;
                  });
                }
              },
              child: OtherLoginOptionsLabelView(label: (!isLoginWithMail) ? OTHER_LOGIN_OPTIONS : LOG_IN_VIA_MOBILE_NUMBER_WITH_SMALL_CAP),
            ),
            const Spacer(),
            const LoginBottomSectionView(),
          ],
        ),
      ),
    );
  }

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: BOTTOM_SHEET_BACKGROUND_COLOR,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(MARGIN_MEDIUM_2),
              topRight: Radius.circular(MARGIN_MEDIUM_2),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    isLoginWithMail = !isLoginWithMail;
                    Navigator.pop(context);
                  });
                },
                child:
                    ModalMenuItemView(text: LOG_IN_VIA_WECHAT_EMAIL_QQ),
              ),
              Container(
                height: 1,
                color: BOTTOM_SHEET_SMALL_DIVIDER_COLOR,
              ),
              ModalMenuItemView(text: LOG_IN_VIA_FACEBOOK),
              Container(
                height: 6,
                color: BOTTOM_SHEET_LARGE_DIVIDER_COLOR,
              ),
              ModalMenuItemView(text: CANCEL_TEXT),
            ],
          ),
        );
      },
    );
  }
}

class LoginBottomSectionView extends StatelessWidget {
  const LoginBottomSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const LogInDescriptionView(),
        const SizedBox(height: MARGIN_MEDIUM_2),
        AuthenticationButtonView(),
        const SizedBox(height: MARGIN_XLARGE + 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              ENABLE_TO_LOGIN_TEXT,
              style: TextStyle(
                color: AUTHENTICATION_PAGE_LIGHT_BLUE_COLOR,
              ),
            ),
            SizedBox(width: MARGIN_XLARGE),
            Text(
              MORE_OPTIONS_TEXT,
              style: TextStyle(
                color: AUTHENTICATION_PAGE_LIGHT_BLUE_COLOR,
              ),
            ),
          ],
        ),
        const SizedBox(height: MARGIN_XLARGE),
      ],
    );
  }
}

class LogInDescriptionView extends StatelessWidget {
  const LogInDescriptionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      LOG_IN_DESCRIPTION_TEXT,
      style: TextStyle(
        color: LOG_IN_DESCRIPTION_COLOR,
        fontSize: TEXT_REGULAR - 2,
      ),
    );
  }
}

class OtherLoginOptionsLabelView extends StatelessWidget {

  final String label;

  OtherLoginOptionsLabelView({required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: MARGIN_CARD_MEDIUM_2),
          child: Text(
            label,
            style: const TextStyle(
              color: AUTHENTICATION_PAGE_LIGHT_BLUE_COLOR,
            ),
          ),
        ),
      ],
    );
  }
}

class LoginFieldsSectionView extends StatelessWidget {
  const LoginFieldsSectionView({
    Key? key,
    required this.screenWidth,
    required this.isLoginWithMail,
  }) : super(key: key);

  final double screenWidth;
  final bool isLoginWithMail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: MARGIN_CARD_MEDIUM_2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          (!isLoginWithMail)
              ? FormFieldView(
                  screenWidth: screenWidth,
                  label: COUNTRY_REGION_FIELD_LABEL,
                  hintText: "United State (+1)",
                  isTextField: false,
                )
              : FormFieldView(
                  screenWidth: screenWidth,
                  label: ACCOUNT_FIELD_LABEL,
                  hintText: ACCOUNT_FIELD_HINT_TEXT,
                ),
          const SizedBox(height: MARGIN_MEDIUM),
          FormFieldView(
            screenWidth: screenWidth,
            label: (!isLoginWithMail) ? PHONE_FIELD_LABEL_TEXT : PASSWORD_FIELD_LABEL_TEXT,
            hintText: (!isLoginWithMail) ? PHONE_FIELD_HINT_TEXT : PASSWORD_FIELD_HINT_TEXT,
          ),
        ],
      ),
    );
  }
}
