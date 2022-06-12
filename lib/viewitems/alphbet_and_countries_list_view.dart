import 'package:flutter/material.dart';
import 'package:we_chat_app/dummy/dummy_country_map.dart';
import 'package:we_chat_app/resources/dimens.dart';
import 'package:we_chat_app/viewitems/country_item_view.dart';

class AlphabetAndCountriesListView extends StatelessWidget {
  final String alphabet;
  final Function(String, String) onTap;

  AlphabetAndCountriesListView({required this.alphabet, required this.onTap});

  @override
  Widget build(BuildContext context) {
    List<String> countryListByFilter = dummyCountryMap.keys
        .toList()
        .where((element) => element[0] == alphabet)
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: MARGIN_MEDIUM_2, vertical: MARGIN_MEDIUM),
          child: Text(
            alphabet,
            style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 0.2),
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Container(
          color: Color.fromRGBO(255, 255, 255, 0.05),
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: countryListByFilter.length,
            itemBuilder: (context, index) {
              return CountryItemView(
                countryKey: countryListByFilter[index],
                onTap: (country, phoneCode) {
                  this.onTap(country, phoneCode);
                },
              );
            },
            separatorBuilder: (context, index) {
              return Container(
                color: Color.fromRGBO(255, 255, 255, 0.05),
                height: 1,
              );
            },
          ),
        ),
      ],
    );
  }
}
