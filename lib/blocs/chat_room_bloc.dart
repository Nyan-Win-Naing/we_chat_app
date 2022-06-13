import 'dart:io';

import 'package:flutter/foundation.dart';

class ChatRoomBloc extends ChangeNotifier {
  /// Image And Video
  File? chosenImageFile;
  File? chosenVideoFile;
  String fileType = "";

  bool isDisposed = false;

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
}