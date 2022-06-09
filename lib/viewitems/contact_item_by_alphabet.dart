import 'package:flutter/material.dart';
import 'package:we_chat_app/dummy/dummy_data_for_contact_page.dart';
import 'package:we_chat_app/pages/chat_room_page.dart';
import 'package:we_chat_app/resources/dimens.dart';
import 'package:we_chat_app/viewitems/contact_item_view.dart';

class ContactItemByAlphabet extends StatelessWidget {

  final String alphabet;


  ContactItemByAlphabet({required this.alphabet});

  @override
  Widget build(BuildContext context) {
    List<String> contactsByAlphabet = dummyContactList.where((element) => element[0] == alphabet).toList();
    final screenHeight = MediaQuery.of(context).size.height;
    final avatarRadius = screenHeight / 25;
    return Column(
      children: [
        AlphatbetAndTotalFriendsSectionView(alphabet: alphabet, count: contactsByAlphabet.length),
        Container(
          color: Color.fromRGBO(0, 0, 0, 0.05),
          height: 1.5,
        ),
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: contactsByAlphabet.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                _navigateToChatRoomPage(context);
              },
              child: ContactItemView(avatarRadius: avatarRadius, name: contactsByAlphabet[index]),
            );
          },
        ),
      ],
    );
  }


  void _navigateToChatRoomPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatRoomPage(),
      ),
    );
  }
}

class AlphatbetAndTotalFriendsSectionView extends StatelessWidget {

  final String alphabet;
  final int count;


  AlphatbetAndTotalFriendsSectionView({required this.alphabet, required this.count});

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
              alphabet,
              style: TextStyle(
                color: Color.fromRGBO(155, 155, 155, 1.0),
                fontSize: TEXT_BIG,
                fontWeight: FontWeight.w700,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: MARGIN_SMALL),
              child: Text(
                "$count FRIENDS",
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
