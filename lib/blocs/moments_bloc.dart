import 'package:flutter/foundation.dart';
import 'package:we_chat_app/data/models/wechat_model.dart';
import 'package:we_chat_app/data/models/wechat_model_impl.dart';
import 'package:we_chat_app/data/vos/moment_vo.dart';

class MomentsBloc extends ChangeNotifier {
  /// States
  List<MomentVO>? moments;

  /// Models
  final WechatModel _mWechatModel = WechatModelImpl();

  bool isDisposed = false;

  MomentsBloc() {
    _mWechatModel.getMoments().listen((momentList) {
      moments = momentList;
      _notifySafely();
    });
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
}