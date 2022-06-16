import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:we_chat_app/data/models/authentication_model_impl.dart';
import 'package:we_chat_app/data/vos/conversation_vo_for_home_page.dart';
import 'package:we_chat_app/fcm/fcm_service.dart';
import 'package:we_chat_app/network/real_time_data_agent_impl.dart';
import 'package:we_chat_app/pages/startup_page.dart';
import 'package:we_chat_app/pages/we_chat_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FCMService().getFcmToken();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _authenticationModel = AuthenticationModelImpl();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        unselectedWidgetColor: Color.fromRGBO(94, 94, 94, 1.0),
      ),
      home: (_authenticationModel.isLoggedIn()) ? WeChatApp() : StartupPage(),
    );
  }
}
