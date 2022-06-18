import 'dart:io';

import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:we_chat_app/blocs/sign_up_by_phone_bloc.dart';
import 'package:we_chat_app/blocs/sign_up_with_email_bloc.dart';
import 'package:we_chat_app/pages/country_choose_page.dart';
import 'package:we_chat_app/pages/sign_up_privacy_policy_page.dart';
import 'package:we_chat_app/pages/we_chat_app.dart';
import 'package:we_chat_app/resources/colors.dart';
import 'package:we_chat_app/resources/dimens.dart';
import 'package:we_chat_app/resources/strings.dart';
import 'package:we_chat_app/widgets/authentication_button_view.dart';
import 'package:we_chat_app/widgets/form_field_view.dart';
import 'package:we_chat_app/widgets/modal_menu_item_view.dart';
import 'package:we_chat_app/widgets/title_section_for_authentication.dart';
import 'package:image_picker/image_picker.dart';

class SignUpByPhonePage extends StatefulWidget {
  String country;
  String phoneCode;
  String name;
  String phoneNumber;
  String password;
  File? uploadPhoto;

  SignUpByPhonePage({
    this.country = "Myanmar",
    this.phoneCode = "+95",
    this.name = "",
    this.phoneNumber = "",
    this.password = "",
    this.uploadPhoto,
  });

  @override
  State<SignUpByPhonePage> createState() => _SignUpByPhonePageState();
}

class _SignUpByPhonePageState extends State<SignUpByPhonePage> {
  bool isCheck = false;

  @override
  Widget build(BuildContext context) {

    print("Country: ${widget.country}, CountryCode: ${widget.country}, name: ${widget.name}, phoneNumber: ${widget.phoneNumber}, password: ${widget.password}, Upload Photo: ${widget.uploadPhoto}");

    final screenWidth = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider(
      create: (context) => SignUpByPhoneBloc(
        countryName: widget.country,
        countryCode: widget.phoneCode,
        name: widget.name,
        phoneNumber: widget.phoneNumber,
        password: widget.password,
        uploadPhoto: widget.uploadPhoto,
      ),
      child: Scaffold(
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
                RegistrationFormsSectionView(
                  screenWidth: screenWidth,
                  country: widget.country,
                  phoneCode: widget.phoneCode,
                ),
                const SizedBox(height: MARGIN_3XLARGE),
                TermsAndConditionsSectionView(
                  onCheck: (isCheck) {
                    setState(() {
                      this.isCheck = isCheck;
                    });
                  },
                  isChecked: isCheck,
                ),
                const SignUpPageLabelView(),
                const SizedBox(height: MARGIN_MEDIUM_2),
                Consumer<SignUpByPhoneBloc>(
                  builder: (context, bloc, child) => AuthenticationButtonView(
                    isButtonEnabled: isCheck,
                    onTapNavigate: () {
                      bloc
                          .onTapAcceptAndContinue()
                          .then((value) =>
                              _navigateToPrivacyAndPolicyPage(context, bloc))
                          .catchError(
                        (error) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  "You must fill all of the fields to sign up."),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToPrivacyAndPolicyPage(
      BuildContext context, SignUpByPhoneBloc bloc) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SignUpPrivacyPolicyPage(
          name: bloc.name,
          phone: bloc.phoneNumber,
          password: bloc.password,
          imageFile: bloc.uploadPhoto,
        ),
      ),
    );
  }
}

class LoadingView extends StatelessWidget {
  const LoadingView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black12,
      child: const Center(
        child: SizedBox(
          width: MARGIN_XXLARGE,
          height: MARGIN_XXLARGE,
          child: LoadingIndicator(
            indicatorType: Indicator.audioEqualizer,
            colors: [Colors.white],
            strokeWidth: 2,
            backgroundColor: Colors.transparent,
            pathBackgroundColor: Colors.black,
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
  final Function(bool) onCheck;
  final bool isChecked;

  TermsAndConditionsSectionView(
      {required this.onCheck, required this.isChecked});

  @override
  State<TermsAndConditionsSectionView> createState() =>
      _TermsAndConditionsSectionViewState();
}

class _TermsAndConditionsSectionViewState
    extends State<TermsAndConditionsSectionView> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
          checkColor: Colors.white,
          activeColor: PRIMARY_COLOR,
          value: widget.isChecked,
          shape: CircleBorder(),
          onChanged: (isCheck) {
            // setState(() {
            //   isChecked = isCheck ?? false;
            // });
            widget.onCheck(isCheck ?? false);
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
    required this.country,
    required this.phoneCode,
  }) : super(key: key);

  final double screenWidth;
  final String country;
  final String phoneCode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: MARGIN_CARD_MEDIUM_2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Consumer<SignUpByPhoneBloc>(
            builder: (context, bloc, child) => FormFieldView(
              screenWidth: screenWidth,
              label: NAME_FIELD_LABEL,
              hintText: NAME_FIELD_HINT_TEXT,
              onChanged: (userName) {
                bloc.onNameChanged(userName);
              },
              currentText: bloc.name,
            ),
          ),
          const SizedBox(height: MARGIN_CARD_MEDIUM_2),
          Consumer<SignUpByPhoneBloc>(
            builder: (context, bloc, child) => GestureDetector(
              onTap: () {
                _navigateToCountryChoosePage(context, bloc);
              },
              child: FormFieldView(
                screenWidth: screenWidth,
                label: COUNTRY_REGION_FIELD_LABEL,
                hintText: bloc.countryName,
                isTextField: false,
                onChanged: (country) {},
              ),
            ),
          ),
          const SizedBox(height: MARGIN_MEDIUM),
          Consumer<SignUpByPhoneBloc>(
            builder: (context, bloc, child) => FormFieldView(
              screenWidth: screenWidth,
              label: PHONE_FIELD_LABEL_TEXT,
              hintText: PHONE_FIELD_HINT_TEXT,
              isPhoneField: true,
              phoneCode: bloc.countryCode,
              onChanged: (phoneNumber) {
                bloc.onPhoneNumberChanged(phoneNumber);
              },
              currentText: bloc.phoneNumber,
            ),
          ),
          const SizedBox(height: MARGIN_MEDIUM),
          Consumer<SignUpByPhoneBloc>(
            builder: (context, bloc, child) => FormFieldView(
              screenWidth: screenWidth,
              label: PASSWORD_FIELD_LABEL_TEXT,
              hintText: PASSWORD_FIELD_HINT_TEXT,
              onChanged: (password) {
                bloc.onPasswordChanged(password);
              },
              isPasswordField: true,
              currentText: bloc.password,
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToCountryChoosePage(
      BuildContext context, SignUpByPhoneBloc bloc) {
    String name = bloc.name;
    String phoneNumber = bloc.phoneNumber;
    String password = bloc.password;
    File? uploadPhoto = bloc.uploadPhoto;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CountryChoosePage(
          name: name,
          phoneNumber: phoneNumber,
          password: password,
          uploadPhoto: uploadPhoto,
        ),
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
    return Consumer<SignUpByPhoneBloc>(
      builder: (context, bloc, child) => GestureDetector(
        onTap: () {
          showBottomSheet(context, bloc);
        },
        child: Container(
          width: 70,
          height: 70,
          color: SIGN_UP_PAGE_IMAGE_PICKER_BACKGROUND,
          child: (bloc.uploadPhoto == null)
              ? const Center(
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                    size: MARGIN_MEDIUM_3,
                  ),
                )
              : Stack(
                  children: [
                    Positioned.fill(
                      child: Image.file(
                        bloc.uploadPhoto ?? File(""),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () {
                          bloc.onTapDeleteImage();
                        },
                        child: Icon(
                          Icons.close,
                          color: Color.fromRGBO(0, 0, 0, 0.5),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  void showBottomSheet(BuildContext context, SignUpByPhoneBloc bloc) {
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
                onTap: () async {
                  final ImagePicker _picker = ImagePicker();
                  final XFile? image =
                      await _picker.pickImage(source: ImageSource.camera);
                  if (image != null) {
                    bloc.onImageChosen(File(image.path));
                  }
                },
                child: ModalMenuItemView(text: "Take Photo"),
              ),
              Container(
                height: 1,
                color: BOTTOM_SHEET_SMALL_DIVIDER_COLOR,
              ),
              GestureDetector(
                onTap: () async {
                  final ImagePicker _picker = ImagePicker();
                  final XFile? image =
                      await _picker.pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    bloc.onImageChosen(File(image.path));
                  }
                },
                child: ModalMenuItemView(text: "Choose from Album"),
              ),
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
