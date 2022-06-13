import 'dart:io';

import 'package:flutter/material.dart';
import 'package:we_chat_app/pages/email_verification_page.dart';
import 'package:we_chat_app/resources/colors.dart';
import 'package:we_chat_app/resources/dimens.dart';
import 'package:we_chat_app/widgets/authentication_button_view.dart';

class SecurityVerificationPage extends StatelessWidget {

  final String name;
  final String phone;
  final String password;
  final File? imageFile;

  SecurityVerificationPage({
    required this.name,
    required this.phone,
    required this.password,
    required this.imageFile,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AUTHENTICATION_PAGE_BACKGROUND_COLOR,
        elevation: 0,
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
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Color.fromRGBO(0, 0, 0, 0.88),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: MARGIN_LARGE, vertical: MARGIN_XXLARGE),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SecurityVerificationTitleView(),
              Spacer(),
              AuthenticationButtonView(
                isButtonEnabled: true,
                onTapNavigate: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EmailVerificationPage(
                        name: name,
                        phone: phone,
                        password: password,
                        imageFile: imageFile,
                      ),
                    ),
                  );
                },
                buttonLabel: "Start",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SecurityVerificationTitleView extends StatelessWidget {
  const SecurityVerificationTitleView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          Icons.info,
          color: Color.fromRGBO(0, 171, 255, 1.0),
          size: MARGIN_XXLARGE + 5,
        ),
        SizedBox(height: MARGIN_XLARGE),
        Text(
          "Security Verification",
          style: TextStyle(
            color: Colors.white,
            fontSize: TEXT_REGULAR_3X,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: MARGIN_MEDIUM_3),
        Text(
          "For the security of your account, verify security verification code before registration.",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color.fromRGBO(255, 255, 255, 0.7),
            fontSize: TEXT_REGULAR,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
