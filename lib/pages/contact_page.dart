import 'package:flutter/material.dart';
import 'package:we_chat_app/dummy/dummy_data_for_contact_page.dart';
import 'package:we_chat_app/pages/chat_room_page.dart';
import 'package:we_chat_app/resources/colors.dart';
import 'package:we_chat_app/resources/dimens.dart';
import 'package:we_chat_app/viewitems/contact_item_by_alphabet.dart';
import 'package:we_chat_app/viewitems/contact_item_view.dart';
import 'package:we_chat_app/widgets/divider_with_height_six.dart';

class ContactPage extends StatelessWidget {
  List<dynamic> alphabetList = List.of(alphabetsStartByName);

  @override
  Widget build(BuildContext context) {
    alphabetList.insert(0, (Icons.search));
    alphabetList.add("#");
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
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: alphabetsStartByName.length,
                    itemBuilder: (context, index) {
                      return ContactItemByAlphabet(alphabet: alphabetsStartByName[index]);
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
                                e,
                                style: TextStyle(
                                    color: Color.fromRGBO(91, 91, 91, 1.0),
                                    fontSize: TEXT_REGULAR - 2,
                                    fontWeight: FontWeight.w700),
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
