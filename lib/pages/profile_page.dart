import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:we_chat_app/resources/colors.dart';
import 'package:we_chat_app/resources/dimens.dart';
import 'package:we_chat_app/viewitems/each_profile_section_item_view.dart';
import 'package:we_chat_app/widgets/divider_with_height_six.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(243, 243, 243, 1.0),
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
        title: Column(
          children: [
            Text(
              "Alberto Calvo",
              style: TextStyle(
                color: Colors.white,
                fontSize: TEXT_REGULAR_2X,
              ),
            ),
            Text(
              "alberto203",
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.7),
                fontSize: TEXT_REGULAR,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: MARGIN_CARD_MEDIUM_2),
            child: Row(
              children: [
                Icon(
                  Icons.qr_code_2_outlined,
                  color: Color.fromRGBO(255, 255, 255, 0.7),
                  size: MARGIN_LARGE,
                ),
                SizedBox(width: MARGIN_SMALL),
                Icon(
                  Icons.chevron_right_outlined,
                  color: Color.fromRGBO(255, 255, 255, 0.7),
                  size: MARGIN_XLARGE,
                ),
              ],
            ),
          ),
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ProfileImageView(),
              ProfileBioTextSectionView(),
              Container(
                color: Color.fromRGBO(0, 0, 0, 0.1),
                height: 1,
              ),
              ProfileSettingsSectionView(),
              DividerWithHeightSix(),
              SizedBox(height: MARGIN_MEDIUM_2),
              LogoutButtonView(),
            ],
          ),
        ),
      ),
    );
  }
}

class LogoutButtonView extends StatelessWidget {
  const LogoutButtonView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      child: TextButton(
        onPressed: () {},
        child: Text(
          "Log Out",
          style: TextStyle(
            color: Color.fromRGBO(0, 0, 0, 0.6),
            fontSize: TEXT_REGULAR_2X,
          ),
        ),
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(Colors.white),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(
                color: Color.fromRGBO(0, 0, 0, 0.1),
                width: 1,
              ),
            ),
          ),
          padding: MaterialStateProperty.all<EdgeInsets>(
            EdgeInsets.all(MARGIN_SMALL),
          ),
        ),
      ),
    );
  }
}

class ProfileSettingsSectionView extends StatelessWidget {
  final Map<String, dynamic> settingsMap = {
    "Photos": Icons.insert_photo_outlined,
    "Favourites": Icons.favorite,
    "Wallet": Icons.account_balance_wallet_outlined,
    "Cards": Icons.credit_card,
    "Stickers": Icons.emoji_emotions_outlined,
    "Settings": Icons.settings_outlined,
  };

  @override
  Widget build(BuildContext context) {
    final settingsKey = settingsMap.keys.toList();
    final settingsValue = settingsMap.values.toList();
    return GridView.builder(
      itemCount: 6,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 3 / 3,
      ),
      itemBuilder: (context, index) {
        return EachProfileSectionItemView(
          label: settingsKey[index],
          iconData: settingsValue[index],
        );
      },
    );
  }
}

class ProfileBioTextSectionView extends StatelessWidget {
  const ProfileBioTextSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: MARGIN_XLARGE,
          right: MARGIN_XLARGE,
          bottom: MARGIN_MEDIUM_3,
          top: MARGIN_MEDIUM_2),
      color: Color.fromRGBO(243, 243, 243, 1.0),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text:
              "Keep smiling, because life is a beautiful thing and there's so much to smile about.",
          style: TextStyle(
            color: Color.fromRGBO(0, 0, 0, 0.5),
            fontSize: TEXT_REGULAR,
          ),
          children: [
            TextSpan(
                text: " EDIT",
                style: TextStyle(
                  color: PRIMARY_COLOR,
                  fontSize: TEXT_REGULAR,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => print('Tap Here onTap'))
          ],
        ),
      ),
    );
  }
}

class ProfileImageView extends StatelessWidget {
  const ProfileImageView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      color: Color.fromRGBO(243, 243, 243, 1.0),
      child: Stack(
        children: [
          Container(
            height: 65,
            color: PRIMARY_COLOR,
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: MARGIN_SMALL,
                ),
                boxShadow: [
                  BoxShadow(

                  ),
                ],
                image: DecorationImage(
                  image: NetworkImage(
                    "https://data.whicdn.com/images/339581930/original.jpg",
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
