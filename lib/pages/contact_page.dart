import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_chat_app/blocs/contact_bloc.dart';
import 'package:we_chat_app/dummy/dummy_data_for_contact_page.dart';
import 'package:we_chat_app/pages/chat_room_page.dart';
import 'package:we_chat_app/resources/colors.dart';
import 'package:we_chat_app/resources/dimens.dart';
import 'package:we_chat_app/resources/strings.dart';
import 'package:we_chat_app/viewitems/contact_item_by_alphabet.dart';
import 'package:we_chat_app/viewitems/contact_item_view.dart';
import 'package:we_chat_app/widgets/divider_with_height_six.dart';

class ContactPage extends StatelessWidget {
  // List<dynamic> alphabetList = List.of(alphabetsStartByName);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ContactBloc(),
      child: Consumer<ContactBloc>(
        builder: (context, bloc, child) {
          List<dynamic> alphabetList = List.of(bloc.alphabetsStartByName ?? []);
          alphabetList.insert(0, (Icons.search));
          alphabetList.add("#");
          return Scaffold(
            appBar: AppBar(
              backgroundColor: PRIMARY_COLOR,
              automaticallyImplyLeading: false,
              elevation: 1,
              centerTitle: true,
              title: const Text(
                CONTACT_PAGE_APP_BAR_TITLE,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: TEXT_REGULAR_2X,
                ),
              ),
              actions: const [
                Padding(
                  padding: EdgeInsets.only(right: MARGIN_CARD_MEDIUM_2),
                  child: Icon(
                    Icons.person_add_alt,
                    color: APP_BAR_ACTION_ICON_COLOR,
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
                        const SizedBox(height: MARGIN_MEDIUM),
                        const SearchFieldSectionView(),
                        const SizedBox(height: MARGIN_MEDIUM),
                        Container(
                          color: DIVIDER_SMALL_COLOR,
                          height: 1,
                        ),
                        const SizedBox(height: MARGIN_MEDIUM_2),
                        const ContactFunctionsView(),
                        const SizedBox(height: MARGIN_MEDIUM_2),
                        const DividerWithHeightSix(),
                        (bloc.alphabetsStartByName?.isNotEmpty ?? false)
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount:
                                    bloc.alphabetsStartByName?.length ?? 0,
                                itemBuilder: (context, index) {
                                  return ContactItemByAlphabet(
                                    alphabet: bloc.alphabetsStartByName?[index],
                                    usersList: bloc.contactUsers ?? [],
                                  );
                                },
                              )
                            : Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: MARGIN_LARGE),
                                  child: Text(
                                    "No Contacts Found",
                                    style: TextStyle(
                                      color: Color.fromRGBO(0, 0, 0, 0.5),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
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
                                    color: CONTACT_ALPHABET_NAVIGATOR_COLOR,
                                    size: MARGIN_MEDIUM_2,
                                  )
                                : Container(
                                    margin: const EdgeInsets.only(bottom: 2),
                                    child: Text(
                                      e,
                                      style: const TextStyle(
                                          color:
                                              CONTACT_ALPHABET_NAVIGATOR_COLOR,
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
        },
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
            label: CONTACT_FUNCTION_NEW_FRIENDS,
          ),
          Container(
            color: CONTACT_FUNCTION_DIVIDER_COLOR,
            height: MARGIN_XXLARGE + 5,
            width: 1,
          ),
          ContactFunctionItem(
            iconData: Icons.group,
            label: CONTACT_FUNCTION_GROUP_CHATS,
          ),
          Container(
            color: CONTACT_FUNCTION_DIVIDER_COLOR,
            height: MARGIN_XXLARGE + 5,
            width: 1,
          ),
          ContactFunctionItem(
            iconData: Icons.link,
            label: CONTACT_FUNCTION_TAGS,
          ),
          Container(
            color: CONTACT_FUNCTION_DIVIDER_COLOR,
            height: MARGIN_XXLARGE + 5,
            width: 1,
          ),
          ContactFunctionItem(
            iconData: Icons.account_circle_outlined,
            label: CONTACT_FUNCTION_OFFICIAL_ACCOUNTS,
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
          color: CONTACT_FUNCTION_ITEM_ICON_COLOR,
          size: MARGIN_XLARGE,
        ),
        const SizedBox(height: MARGIN_SMALL),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: CONTACT_FUNCTION_ITEM_TEXT_COLOR,
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
            fillColor: CONTACT_PAGE_SEARCH_FIELD_COLOR,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
              borderSide: const BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            hintText: SEARCH_FIELD_HINT_TEXT,
            hintStyle: const TextStyle(
              color: CONTACT_PAGE_SEARCH_FIELD_HINT_TEXT_COLOR,
            ),
            contentPadding: const EdgeInsets.all(0),
          ),
        ),
      ),
    );
  }
}
