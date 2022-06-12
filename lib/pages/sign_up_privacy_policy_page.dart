import 'package:flutter/material.dart';
import 'package:we_chat_app/resources/colors.dart';
import 'package:we_chat_app/resources/dimens.dart';

class SignUpPrivacyPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(27, 25, 28, 1.0),
      appBar: AppBar(
          backgroundColor: AUTHENTICATION_PAGE_BACKGROUND_COLOR,
          elevation: 1,
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.close,
              color: Colors.white,
            ),
          ),
          title: Text(
            "Privacy Policy",
            style: TextStyle(
              color: Colors.white,
              fontSize: TEXT_REGULAR_2X,
            ),
          )),
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: MARGIN_CARD_MEDIUM_2),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                PrivacyPolicyTitleSectionView(),
                SizedBox(height: MARGIN_MEDIUM),
                EachPrivacyAndPolicyView(
                  title: "WHAT INFORMATION DO YOU NEED TO PROVIDE WECHAT?",
                  content:
                      "While using Our Service, We may ask You to provide Us with certain personally identifiable information that can be used to contact or identify You. Personally identifiable information may include, but is not limited to: \nEmail address \nFirst name and last name"
                      "\nPhone number"
                      "\nAddress, State, Province, ZIP/Postal code, City"
                      "\nUsage Data",
                ),
                SizedBox(height: MARGIN_MEDIUM_2),
                EachPrivacyAndPolicyView(
                  title: "HOW DO WE USE YOUR PERSONAL DATA?",
                  content:
                      "Usage Data is collected automatically when using the Service."
                      "Usage Data may include information such as Your Device's Internet Protocol address (e.g. IP address), browser type, browser version, the pages of our Service that You visit, the time and date of Your visit, the time spent on those pages, unique device identifiers and other diagnostic data."
                      "When You access the Service by or through a mobile device, We may collect certain information automatically, including, but not limited to, the type of mobile device You use, Your mobile device unique ID, the IP address of Your mobile device, Your mobile operating system, the type of mobile Internet browser You use, unique device identifiers and other diagnostic data."
                      "We may also collect information that Your browser sends whenever You visit our Service or when You access the Service by or through a mobile device.",
                ),
                SizedBox(height: MARGIN_MEDIUM_2),
                EachPrivacyAndPolicyView(
                  title: "OTHER LEGAL REQUIREMENTS",
                  content:
                      "The Company may disclose Your Personal Data in the good faith belief that such action is necessary to:"
                      "\n- Comply with a legal obligation"
                      "\n- Protect and defend the rights or property of the Company"
                      "\n- Prevent or investigate possible wrongdoing in connection with the Service"
                      "\n- Protect the personal safety of Users of the Service or the public"
                      "\n- Protect against legal liability",
                ),
                SizedBox(height: MARGIN_MEDIUM_2),
                EachPrivacyAndPolicyView(
                  title: "RETENTION OF YOUR PERSONAL DATA",
                  content:
                      "The Company will retain Your Personal Data only for as long as is necessary for the purposes set out in this Privacy Policy. We will retain and use Your Personal Data to the extent necessary to comply with our legal obligations (for example, if we are required to retain your data to comply with applicable laws), resolve disputes, and enforce our legal agreements and policies."
                      "The Company will also retain Usage Data for internal analysis purposes. Usage Data is generally retained for a shorter period of time, except when this data is used to strengthen the security or to improve the functionality of Our Service, or We are legally obligated to retain this data for longer time periods.",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EachPrivacyAndPolicyView extends StatelessWidget {
  final String title;
  final String content;

  EachPrivacyAndPolicyView({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Color.fromRGBO(255, 255, 255, 0.7),
            fontSize: TEXT_REGULAR + 1,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: MARGIN_CARD_MEDIUM_2),
        Text(
          content,
          style:
              TextStyle(color: Color.fromRGBO(255, 255, 255, 0.4), height: 1.3),
        ),
      ],
    );
  }
}

class PrivacyPolicyTitleSectionView extends StatelessWidget {
  const PrivacyPolicyTitleSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: MARGIN_MEDIUM_2),
      child: Text(
        "WECHAT PRIVACY POLICY",
        style: TextStyle(
          color: Colors.white,
          fontSize: TEXT_REGULAR_3X,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
