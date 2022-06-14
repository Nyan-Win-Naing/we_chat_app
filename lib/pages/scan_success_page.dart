import 'package:flutter/material.dart';
import 'package:we_chat_app/pages/profile_page.dart';
import 'package:we_chat_app/resources/colors.dart';
import 'package:we_chat_app/resources/dimens.dart';

class ScanSuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        elevation: 1,
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfilePage(),
              ),
            );
          },
          child: const Icon(
            Icons.close,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.cloud_done,
                color: PRIMARY_COLOR,
                size: MARGIN_XLARGE + 5,
              ),
              SizedBox(height: MARGIN_MEDIUM_2),
              Text(
                "Invitation Success!",
                style: TextStyle(
                  color: AUTHENTICATION_PAGE_BACKGROUND_COLOR,
                  fontSize: TEXT_REGULAR_2X,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
