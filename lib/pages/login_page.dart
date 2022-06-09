import 'package:flutter/material.dart';
import 'package:we_chat_app/resources/dimens.dart';
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TitleSectionForAuthentication(title: "Log In Via Mobile Number"),
            SizedBox(height: MARGIN_XXLARGE),
            LoginFieldsSectionView(
                screenWidth: screenWidth, isLoginWithMail: isLoginWithMail),
            SizedBox(height: MARGIN_MEDIUM_3),
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
              child: OtherLoginOptionsLabelView(label: (!isLoginWithMail) ? "Other Login Options" : "Log in via mobile number"),
            ),
            Spacer(),
            LoginBottomSectionView(),
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
          decoration: BoxDecoration(
            color: Color.fromRGBO(44, 44, 44, 1.0),
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
                    ModalMenuItemView(text: "Log in via WeChat ID/Email/QQ ID"),
              ),
              Container(
                height: 1,
                color: Color.fromRGBO(255, 255, 255, 0.05),
              ),
              ModalMenuItemView(text: "Log in via Facebook"),
              Container(
                height: 6,
                color: Color.fromRGBO(30, 30, 30, 1.0),
              ),
              ModalMenuItemView(text: "Cancel"),
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
        LogInDescriptionView(),
        SizedBox(height: MARGIN_MEDIUM_2),
        AuthenticationButtonView(),
        SizedBox(height: MARGIN_XLARGE + 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "Unable to Log In?",
              style: TextStyle(
                color: Color.fromRGBO(127, 144, 160, 1.0),
              ),
            ),
            SizedBox(width: MARGIN_XLARGE),
            Text(
              "More Options",
              style: TextStyle(
                color: Color.fromRGBO(127, 144, 160, 1.0),
              ),
            ),
          ],
        ),
        SizedBox(height: MARGIN_XLARGE),
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
      "The above mobile number is used only for login verification.",
      style: TextStyle(
        color: Color.fromRGBO(94, 94, 94, 1.0),
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
          padding: EdgeInsets.symmetric(horizontal: MARGIN_CARD_MEDIUM_2),
          child: Text(
            label,
            style: TextStyle(
              color: Color.fromRGBO(127, 144, 160, 1.0),
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
                  label: "Country/\nRegion",
                  hintText: "United State (+1)",
                  isTextField: false,
                )
              : FormFieldView(
                  screenWidth: screenWidth,
                  label: "Account",
                  hintText: "WeChat ID/Email/QQ ID",
                ),
          SizedBox(height: MARGIN_MEDIUM),
          FormFieldView(
            screenWidth: screenWidth,
            label: (!isLoginWithMail) ? "Phone" : "Password",
            hintText: (!isLoginWithMail) ? "Enter mobile number" : "Enter password",
          ),
        ],
      ),
    );
  }
}
