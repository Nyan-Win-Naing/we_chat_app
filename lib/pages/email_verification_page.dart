import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_chat_app/blocs/sign_up_with_email_bloc.dart';
import 'package:we_chat_app/pages/sign_up_by_phone_page.dart';
import 'package:we_chat_app/pages/we_chat_app.dart';
import 'package:we_chat_app/resources/dimens.dart';
import 'package:we_chat_app/widgets/authentication_button_view.dart';
import 'package:we_chat_app/widgets/form_field_view.dart';

class EmailVerificationPage extends StatelessWidget {
  final String name;
  final String phone;
  final String password;
  final File? imageFile;

  EmailVerificationPage({
    required this.name,
    required this.phone,
    required this.password,
    required this.imageFile,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SignUpWithEmailBloc(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(0, 0, 0, 0.88),
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
        body: Selector<SignUpWithEmailBloc, bool>(
          selector: (context, bloc) => bloc.isLoading,
          builder: (context, isLoading, child) => Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: const Color.fromRGBO(0, 0, 0, 0.88),
                padding: const EdgeInsets.symmetric(
                    vertical: MARGIN_XXLARGE, horizontal: MARGIN_MEDIUM_3),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      EmailVerificationTitleText(),
                      SizedBox(height: MARGIN_XXLARGE),
                      const Text(
                        "Enter verification information",
                        style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 0.5),
                          fontSize: TEXT_REGULAR - 2,
                        ),
                      ),
                      SizedBox(height: MARGIN_MEDIUM_2),
                      Consumer<SignUpWithEmailBloc>(
                        builder: (context, bloc, child) => FormFieldView(
                          screenWidth: MediaQuery.of(context).size.width,
                          label: "Email",
                          hintText: "Enter email",
                          onChanged: (email) {
                            bloc.onEmailChanged(email);
                          },
                        ),
                      ),
                      SizedBox(height: MARGIN_3XLARGE * 5),
                      Consumer<SignUpWithEmailBloc>(
                        builder: (context, bloc, child) => Center(
                          child: AuthenticationButtonView(
                            isButtonEnabled:
                                (bloc.email.isNotEmpty) ? true : false,
                            onTapNavigate: () {
                              bloc
                                  .onTapRegister(
                                      name, password, phone, imageFile)
                                  .then((value) {
                                _navigateToWeChatApp(context);
                              }).catchError((error) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        "Sign Up Failed."),
                                  ),
                                );
                              });
                            },
                            buttonLabel: "OK",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: isLoading,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  color: Colors.black54,
                  child: Center(
                    child: LoadingView(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToWeChatApp(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WeChatApp(),
      ),
    );
  }
}

class EmailVerificationTitleText extends StatelessWidget {
  const EmailVerificationTitleText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Email Verification",
        style: TextStyle(
          color: Colors.white,
          fontSize: TEXT_REGULAR_3X,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
