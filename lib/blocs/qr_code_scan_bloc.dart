import 'package:flutter/foundation.dart';
import 'package:we_chat_app/data/models/authentication_model.dart';
import 'package:we_chat_app/data/models/authentication_model_impl.dart';
import 'package:we_chat_app/data/models/wechat_model.dart';
import 'package:we_chat_app/data/models/wechat_model_impl.dart';
import 'package:we_chat_app/data/vos/user_vo.dart';

class QRCodeScanBloc extends ChangeNotifier {
  /// States
  String qrCode = "";
  bool isDisposed = false;
  bool isLoading = false;

  UserVO? user;

  /// Model
  AuthenticationModel authModel = AuthenticationModelImpl();
  WechatModel weChatModel = WechatModelImpl();

  Future onScanQR(String userId) {
    _showLoading();
    return authModel.getUserById(userId).then((user) {
      this.user = user;
      return weChatModel.addNewContactToScanner(user).then((value) {
        return weChatModel.addNewContactToScannedUser(user);
      });
    }).whenComplete(() => _hideLoading());
  }

  void _showLoading() {
    isLoading = true;
    _notifySafely();
  }

  void _hideLoading() {
    isLoading = false;
    _notifySafely();
  }


  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
  }

  void _notifySafely() {
    if(!isDisposed) {
      notifyListeners();
    }
  }
}