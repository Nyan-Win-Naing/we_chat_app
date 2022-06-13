import 'package:flutter/foundation.dart';
import 'package:we_chat_app/data/models/authentication_model.dart';
import 'package:we_chat_app/data/models/authentication_model_impl.dart';
import 'package:we_chat_app/data/vos/user_vo.dart';

class QRCodeScanBloc extends ChangeNotifier {
  /// States
  String qrCode = "";
  bool isDisposed = false;

  UserVO? user;

  /// Model
  AuthenticationModel authModel = AuthenticationModelImpl();

  void onScanQR(String userId) {
    authModel.getUserById(userId).listen((user) {
      this.user = user;
    });
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