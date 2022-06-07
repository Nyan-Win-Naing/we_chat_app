import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:we_chat_app/resources/colors.dart';
import 'package:we_chat_app/resources/dimens.dart';
import 'package:we_chat_app/viewitems/contact_item_view.dart';
import 'package:we_chat_app/widgets/divider_with_height_six.dart';

class ContactPage extends StatelessWidget {
  List<dynamic> alphabetList = [
    Icons.search,
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "P",
    "Q",
    "R",
    "S",
    "T",
    "U",
    "V",
    "W",
    "X",
    "Y",
    "Z",
    "#"
  ];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final avatarRadius = screenHeight / 25;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        automaticallyImplyLeading: false,
        elevation: 1,
        centerTitle: true,
        title: Text(
          "Contacts",
          style: TextStyle(
            color: Colors.white,
            fontSize: TEXT_REGULAR_2X,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: MARGIN_CARD_MEDIUM_2),
            child: Icon(
              Icons.person_add_alt,
              color: Color.fromRGBO(255, 255, 255, 0.7),
              size: MARGIN_XLARGE,
            ),
          ),
        ],
      ),
      body: Container(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: MARGIN_MEDIUM),
                  SearchFieldSectionView(),
                  SizedBox(height: MARGIN_MEDIUM),
                  Container(
                    color: Color.fromRGBO(0, 0, 0, 0.1),
                    height: 1,
                  ),
                  SizedBox(height: MARGIN_MEDIUM_2),
                  ContactFunctionsView(),
                  SizedBox(height: MARGIN_MEDIUM_2),
                  DividerWithHeightSix(),
                  AlphatbetAndTotalFriendsSectionView(),
                  Container(
                    color: Color.fromRGBO(0, 0, 0, 0.05),
                    height: 1.5,
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return ContactItemView(avatarRadius: avatarRadius);
                    },
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: MARGIN_XXLARGE,
              right: 0,
              child: Column(
                children: alphabetList
                    .map(
                      (e) => (e.runtimeType == IconData)
                          ? Icon(
                              e,
                              color: Color.fromRGBO(91, 91, 91, 1.0),
                              size: MARGIN_MEDIUM_2,
                            )
                          : Container(
                        margin: EdgeInsets.only(bottom: 2),
                            child: Text(
                                e, style: TextStyle(
                        color: Color.fromRGBO(91, 91, 91, 1.0),
                        fontSize: TEXT_REGULAR - 2,
                        fontWeight: FontWeight.w700
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
}

class AlphatbetAndTotalFriendsSectionView extends StatelessWidget {
  const AlphatbetAndTotalFriendsSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: Color.fromRGBO(242, 242, 242, 1.0),
      child: Padding(
        padding: const EdgeInsets.only(
          left: MARGIN_XXLARGE + 20,
          right: MARGIN_XLARGE,
          bottom: MARGIN_SMALL,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "A",
              style: TextStyle(
                color: Color.fromRGBO(155, 155, 155, 1.0),
                fontSize: TEXT_BIG,
                fontWeight: FontWeight.w700,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: MARGIN_SMALL),
              child: Text(
                "15 FRIENDS",
                style: TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 0.15),
                  fontSize: TEXT_REGULAR_2X,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ContactFunctionsView extends StatelessWidget {
  const ContactFunctionsView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: MARGIN_CARD_MEDIUM_2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ContactFunctionItem(
            iconData: Icons.person_add_alt,
            label: "New\nFriends",
          ),
          Container(
            color: Color.fromRGBO(0, 0, 0, 0.08),
            height: MARGIN_XXLARGE + 5,
            width: 1,
          ),
          ContactFunctionItem(
            iconData: Icons.group,
            label: "Group\nChats",
          ),
          Container(
            color: Color.fromRGBO(0, 0, 0, 0.08),
            height: MARGIN_XXLARGE + 5,
            width: 1,
          ),
          ContactFunctionItem(
            iconData: Icons.link,
            label: "Tags",
          ),
          Container(
            color: Color.fromRGBO(0, 0, 0, 0.08),
            height: MARGIN_XXLARGE + 5,
            width: 1,
          ),
          ContactFunctionItem(
            iconData: Icons.account_circle_outlined,
            label: "Official\nAccounts",
          ),
        ],
      ),
    );
  }
}

class ContactFunctionItem extends StatelessWidget {
  final IconData iconData;
  final String label;

  ContactFunctionItem({required this.iconData, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          iconData,
          color: Color.fromRGBO(192, 192, 192, 1.0),
          size: MARGIN_XLARGE,
        ),
        SizedBox(height: MARGIN_SMALL),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color.fromRGBO(145, 145, 145, 1.0),
            fontSize: TEXT_REGULAR - 2,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class SearchFieldSectionView extends StatelessWidget {
  const SearchFieldSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: MARGIN_CARD_MEDIUM_2),
      child: SizedBox(
        height: 30,
        child: TextField(
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            filled: true,
            fillColor: Color.fromRGBO(227, 228, 231, 1.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            hintText: "Search",
            hintStyle: TextStyle(
              color: Color.fromRGBO(165, 163, 169, 1.0),
            ),
            contentPadding: EdgeInsets.all(0),
          ),
        ),
      ),
    );
  }
}
