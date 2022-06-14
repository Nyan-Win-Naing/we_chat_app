import 'package:flutter/foundation.dart';
import 'package:we_chat_app/data/models/wechat_model.dart';
import 'package:we_chat_app/data/models/wechat_model_impl.dart';
import 'package:we_chat_app/data/vos/user_vo.dart';

class ContactBloc extends ChangeNotifier {
  /// States
  List<UserVO>? contactUsers;
  List<dynamic>? alphabetsStartByName;

  bool isDisposed = false;

  /// Model
  WechatModel model = WechatModelImpl();

  ContactBloc() {
     model.getContactsOfLoggedInUser().listen((users) {
        contactUsers = users;
        alphabetsStartByName = users.map((user) => user.userName?[0] ?? "").toSet().toList();
        _notifySafely();
     });
  }

  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
  }

  void _notifySafely() {
    if (!isDisposed) {
      notifyListeners();
    }
  }
}
