import 'package:flutter/foundation.dart';
import 'package:we_chat_app/data/models/authentication_model.dart';
import 'package:we_chat_app/data/models/authentication_model_impl.dart';
import 'package:we_chat_app/data/models/wechat_model.dart';
import 'package:we_chat_app/data/models/wechat_model_impl.dart';
import 'package:we_chat_app/data/vos/moment_vo.dart';
import 'package:we_chat_app/data/vos/user_vo.dart';

class MomentsBloc extends ChangeNotifier {
  /// States
  List<MomentVO>? moments;
  UserVO? userVo;

  /// Models
  final WechatModel _mWechatModel = WechatModelImpl();
  final AuthenticationModel _mAuthModel = AuthenticationModelImpl();

  bool isDisposed = false;

  MomentsBloc() {
    _mWechatModel.getMoments().listen((momentList) {
      moments = momentList;
      _notifySafely();
    });

    String loggedInUserId = _mAuthModel.getLoggedInUser().id ?? "";
    _prepopulateForMomentProfile(loggedInUserId);
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

  void onTapDeletePost(int postId) async {
    await _mWechatModel.deletePost(postId);
  }

  void _prepopulateForMomentProfile(String loggedInUserId) {
    _mAuthModel.getUserById(loggedInUserId).then((user) {
      userVo = user;
      _notifySafely();
    });
  }
}