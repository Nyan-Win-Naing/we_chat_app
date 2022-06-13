import 'package:flutter/material.dart';
import 'package:we_chat_app/data/vos/user_vo.dart';
import 'package:we_chat_app/pages/qr_code_scan_page.dart';
import 'package:we_chat_app/resources/colors.dart';
import 'package:we_chat_app/resources/dimens.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodePage extends StatelessWidget {

  final UserVO? userVo;


  QRCodePage({required this.userVo});

  @override
  Widget build(BuildContext context) {
    print("User in qr code page: $userVo......");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 1,
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
          "Scan My QR",
          style: TextStyle(
            color: Colors.white,
            fontSize: TEXT_REGULAR_2X,
          ),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_3),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: MARGIN_XXLARGE),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Invite More Friends",
                      style: TextStyle(
                        color: LOG_IN_DESCRIPTION_COLOR,
                        fontSize: TEXT_REGULAR_3X,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: MARGIN_XLARGE),
                Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: MARGIN_MEDIUM_2, vertical: MARGIN_MEDIUM_2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(MARGIN_MEDIUM_2),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.1),
                          spreadRadius: 3,
                          blurRadius: 3,
                          offset: Offset(0, 3),
                        )
                      ],
                    ),
                    child: QrImage(
                      data: userVo?.qrCode ?? "",
                      version: QrVersions.auto,
                      size: 250,
                      gapless: false,
                    )),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QRCodeScanPage(),
            ),
          );
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.qr_code_scanner_outlined),
      ),
    );
  }
}
