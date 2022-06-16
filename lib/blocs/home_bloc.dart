import 'package:flutter/foundation.dart';
import 'package:we_chat_app/data/models/authentication_model.dart';
import 'package:we_chat_app/data/models/authentication_model_impl.dart';
import 'package:we_chat_app/data/models/wechat_model.dart';
import 'package:we_chat_app/data/models/wechat_model_impl.dart';
import 'package:we_chat_app/data/vos/conversation_vo_for_home_page.dart';

class HomeBloc extends ChangeNotifier {
  /// States
  List<ConversationVOForHomePage> conversationList = [];
  List<ConversationVOForHomePage> tempList = [];
  String loggedInUserId = "";


  bool isDisposed = false;

  /// Models
  AuthenticationModel authModel = AuthenticationModelImpl();
  WechatModel weChatModel = WechatModelImpl();

  HomeBloc() {
    loggedInUserId = authModel.getLoggedInUser().id ?? "";
    weChatModel.getConversations(loggedInUserId).listen((List<Future<ConversationVOForHomePage>> fConversationList) {
      conversationList = List.of(tempList);
      if(fConversationList.isEmpty) {
        conversationList = [];
        _notifySafely();
      }
      fConversationList.forEach((Future<ConversationVOForHomePage> futureConversation) async {
        // futureConversation.then((value) {
        //   conversationList?.add(value);
        //   conversationList = List.of(conversationList ?? []);
        //   _notifySafely();
        //   print("Conversation is $conversationList..........");
        // });
        print("Conversation from Future is ${await futureConversation} ..........................");
        conversationList.add(await futureConversation);
        conversationList = List.of(conversationList);
        _notifySafely();
      });
    });
  }

  void onTapDeleteConversation(String conversationId) async {
    await weChatModel.deleteConversation(loggedInUserId, conversationId);
  }

  void _notifySafely() {
    if(!isDisposed) {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
  }

}