import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_chat_app/blocs/sign_up_by_phone_bloc.dart';
import 'package:we_chat_app/dummy/dummy_country_map.dart';
import 'package:we_chat_app/pages/sign_up_by_phone_page.dart';
import 'package:we_chat_app/resources/colors.dart';
import 'package:we_chat_app/resources/dimens.dart';
import 'package:we_chat_app/resources/strings.dart';
import 'package:we_chat_app/viewitems/alphbet_and_countries_list_view.dart';
import 'package:we_chat_app/viewitems/country_item_view.dart';

class CountryChoosePage extends StatelessWidget {
  String name;
  String phoneNumber;
  String password;
  File? uploadPhoto;

  CountryChoosePage({required this.name, required this.phoneNumber, required this.password, required this.uploadPhoto});

  List<String> beginAlphabetList =
      dummyCountryMap.keys.toList().map((e) => e[0]).toSet().toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AUTHENTICATION_PAGE_BACKGROUND_COLOR,
      appBar: AppBar(
          backgroundColor: AUTHENTICATION_PAGE_BACKGROUND_COLOR,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Region",
            style: TextStyle(
              color: Colors.white,
              fontSize: TEXT_REGULAR_2X,
            ),
          ),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.close,
              color: APP_BAR_LEADING_COLOR,
            ),
          )),
      body: Container(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CountryChoosePageSearchFieldView(),
                  ListView.builder(
                    itemCount: beginAlphabetList.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return AlphabetAndCountriesListView(
                        alphabet: beginAlphabetList[index],
                        onTap: (String country, String phoneCode) {
                          _navigateToSignUpPageByPhone(
                              context, country, phoneCode, name, phoneNumber, password, uploadPhoto);
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: beginAlphabetList
                    .map(
                      (e) => Container(
                        margin: EdgeInsets.only(bottom: 2, right: 2),
                        child: Text(
                          e,
                          style: TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 0.3),
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToSignUpPageByPhone(BuildContext context, String country,
      String phoneCode, String name, String phoneNumber, String password, File? uploadPhoto) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SignUpByPhonePage(
          country: country,
          phoneCode: phoneCode,
          name: name,
          phoneNumber: phoneNumber,
          password: password,
          uploadPhoto: uploadPhoto,
        ),
      ),
    );
  }
}

class CountryChoosePageSearchFieldView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MARGIN_CARD_MEDIUM_2, vertical: MARGIN_MEDIUM),
      child: SizedBox(
        height: 30,
        child: TextField(
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            filled: true,
            fillColor: Color.fromRGBO(255, 255, 255, 0.05),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            hintText: SEARCH_FIELD_HINT_TEXT,
            hintStyle: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 0.2),
            ),
            contentPadding: EdgeInsets.all(0),
          ),
        ),
      ),
    );
  }
}
