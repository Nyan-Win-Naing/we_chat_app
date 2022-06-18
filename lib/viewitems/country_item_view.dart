import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_chat_app/blocs/home_bloc.dart';
import 'package:we_chat_app/blocs/sign_up_by_phone_bloc.dart';
import 'package:we_chat_app/dummy/dummy_country_map.dart';
import 'package:we_chat_app/dummy/dummy_data_for_contact_page.dart';
import 'package:we_chat_app/resources/dimens.dart';

class CountryItemView extends StatelessWidget {

  final String countryKey;
  final Function(String, String) onTap;


  CountryItemView({required this.countryKey, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        this.onTap(countryKey, dummyCountryMap[countryKey] ?? "");
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: MARGIN_MEDIUM),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              countryKey,
              style: const TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.7),
                fontSize: TEXT_REGULAR_2X - 1,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              dummyCountryMap[countryKey] ?? "",
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.4),
                fontSize: TEXT_REGULAR - 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
