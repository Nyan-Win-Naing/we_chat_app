import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:we_chat_app/data/models/wechat_model.dart';
import 'package:we_chat_app/data/models/wechat_model_impl.dart';
import 'package:we_chat_app/data/vos/moment_vo.dart';

class AddNewPostBloc extends ChangeNotifier {
  /// States
  String newPostDescription = "";
  bool isAddNewPostError = false;
  bool isDisposed = false;
  bool isLoading = false;

  /// Models
  final WechatModel _model = WechatModelImpl();

  String username = "";
  String profilePicture = "";

  /// Image
  File? chosenImageFile;
  File? chosenVideoFile;
  String fileType = "";

  /// For Edit Mode
  bool isInEditMode = false;
  MomentVO? mMoment;

  AddNewPostBloc({int? momentId}) {
    if (momentId != null) {
      isInEditMode = true;
      _prepopulateDataForEditMode(momentId);
    } else {
      _prepopulateDataForAddNewPost();
    }
  }

  void onNewPostTextChanged(String newPostDescription) {
    this.newPostDescription = newPostDescription;
  }

  void _prepopulateDataForAddNewPost() {
    username = "Nyan Win Naing";
    profilePicture =
        "https://static.wikia.nocookie.net/parody/images/8/8f/Profile_-_Jerry_Mouse_%28Tom_and_Jerry_%282021%29%29.png/revision/latest?cb=20210430032212";
    _notifySafely();
  }

  Future onTapAddNewPost() {
    if (newPostDescription.isEmpty) {
      isAddNewPostError = true;
      _notifySafely();
      return Future.error("Error");
    } else {
      isLoading = true;
      _notifySafely();
      isAddNewPostError = false;
      // return _model.addNewMoment(newPostDescription);
      if(isInEditMode) {
        return _editMoment().then((value) {
          isLoading = false;
          _notifySafely();
        });
      } else {
        return _createNewMoment().then((value) {
          isLoading = false;
          _notifySafely();
        });
      }
    }
  }

  void _notifySafely() {
    if (!isDisposed) {
      notifyListeners();
    }
  }

  void _prepopulateDataForEditMode(int momentId) {
    _model.getMomentById(momentId).listen((moment) {
      username = moment.userName ?? "";
      profilePicture = moment.profilePicture ?? "";
      newPostDescription = moment.description ?? "";
      mMoment = moment;
      _notifySafely();
    });
  }

  Future<void> _createNewMoment() {
    return _model.addNewMoment(newPostDescription, chosenImageFile, chosenVideoFile);
  }

  Future<dynamic> _editMoment() {
    mMoment?.description = newPostDescription;
    if(mMoment != null) {
      return _model.editPost(mMoment!, chosenImageFile, chosenVideoFile);
    } else {
      return Future.error("Error");
    }
  }

  void onFileChosen(File file) {
    var fileType = (file.path.split('/').last.split('.').last);
    this.fileType = fileType;
    if(fileType == "jpg" || fileType == "png" || fileType == "jpeg" || fileType == "gif") {
      chosenImageFile = file;
    } else {
      chosenVideoFile = file;
    }
    _notifySafely();
  }

  void onTapDeleteFile() {
    chosenImageFile = null;
    chosenVideoFile = null;
    _notifySafely();
  }
}
