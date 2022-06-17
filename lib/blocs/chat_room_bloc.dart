import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:we_chat_app/data/models/authentication_model.dart';
import 'package:we_chat_app/data/models/authentication_model_impl.dart';
import 'package:we_chat_app/data/models/wechat_model.dart';
import 'package:we_chat_app/data/models/wechat_model_impl.dart';
import 'package:we_chat_app/data/vos/message_vo.dart';
import 'package:we_chat_app/data/vos/user_vo.dart';

class ChatRoomBloc extends ChangeNotifier {
  /// Image And Video
  File? chosenImageFile;
  File? chosenVideoFile;
  String fileType = "";
  String message = "";
  List<MessageVO>? messages;

  bool isMessageError = false;

  bool isLoading = false;

  bool isDisposed = false;

  String loggedInUserId = "";
  String sentUserId = "";

  bool isShownFunctionBar = false;

  /// Model
  WechatModel weChatModel = WechatModelImpl();
  AuthenticationModel authModel = AuthenticationModelImpl();

  void onChangedShownFunctionBar() {
    isShownFunctionBar = !isShownFunctionBar;
    _notifySafely();
  }

  ChatRoomBloc(UserVO? userVo) {
    loggedInUserId = authModel.getLoggedInUser().id ?? "";
    sentUserId = userVo?.id ?? "";

    weChatModel.getMessages(loggedInUserId, sentUserId).listen((messages) {
      print("Messages in bloc is $messages...............");
      this.messages = messages;
      this.messages = List.of((this.messages ?? []).reversed.toList());
      _notifySafely();
    });
  }

  void onFileChosen(File file) {
    var fileType = file.path.split("/").last.split(".").last;
    this.fileType = fileType;
    if(fileType == "jpg" || fileType == "png" || fileType == "jpeg" || fileType == "gif") {
      chosenImageFile = file;
    } else {
      chosenVideoFile = file;
    }
    _notifySafely();
  }

  Future onSendMessage(UserVO userVo) {
    if(message.isEmpty && chosenImageFile == null && chosenVideoFile == null) {
      isMessageError = true;
      _notifySafely();
      return Future.error("Error");
    } else {
      isLoading = true;
      _notifySafely();
      isMessageError = false;
      return _sendNewMessage(userVo).then((value) {
        onTapDeleteImage();
        message = "";
        isLoading = false;
        _notifySafely();
      });
    }
  }

  void onMessageChanged(String message) {
    this.message = message;
  }

  void onTapDeleteImage() {
    chosenImageFile = null;
    chosenVideoFile = null;
    _notifySafely();
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

  Future<void> _sendNewMessage(UserVO userVo) {
    return weChatModel.sendNewMessage(userVo, message, chosenImageFile, chosenVideoFile);
  }

  void onChangeIsShownFunctionBar() {
    isShownFunctionBar = !isShownFunctionBar;
    _notifySafely();
  }
}