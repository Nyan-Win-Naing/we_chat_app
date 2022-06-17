import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:we_chat_app/data/models/authentication_model.dart';
import 'package:we_chat_app/data/models/authentication_model_impl.dart';
import 'package:we_chat_app/data/models/wechat_model.dart';
import 'package:we_chat_app/data/models/wechat_model_impl.dart';
import 'package:we_chat_app/data/vos/moment_vo.dart';

class AddNewPostBloc extends ChangeNotifier {
  /// States
  String newPostDescription = "";
  bool isAddNewPostError = false;
  bool isDisposed = false;
  bool isLoading = false;

  String loggedInUser = "";

  /// Models
  final WechatModel _model = WechatModelImpl();
  final AuthenticationModel _authModel = AuthenticationModelImpl();

  String username = "";
  String profilePicture = "";

  /// Image
  File? chosenImageFile;
  File? chosenVideoFile;
  String fileType = "";

  /// For Edit Mode
  bool isInEditMode = false;
  MomentVO? mMoment;
  String networkImage = "";
  String networkVideo = "";


  AddNewPostBloc({int? momentId}) {
    loggedInUser = _authModel.getLoggedInUser().id ?? "";

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
    _authModel.getUserById(loggedInUser).then((user) {
      username = user.userName ?? "";
      profilePicture = user.profilePicture ?? "";
      _notifySafely();
    });
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

  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
  }

  void _prepopulateDataForEditMode(int momentId) {
    _model.getMomentById(momentId).listen((moment) {
      username = moment.userName ?? "";
      profilePicture = moment.profilePicture ?? "";
      newPostDescription = moment.description ?? "";
      networkImage = moment.postImage ?? "";
      networkVideo = moment.postVideo ?? "";
      mMoment = moment;
      _notifySafely();
    });
  }

  Future<void> _createNewMoment() {
    return _model.addNewMoment(newPostDescription, chosenImageFile, chosenVideoFile, username, profilePicture);
  }

  Future<dynamic> _editMoment() {
    mMoment?.description = newPostDescription;
    if(mMoment != null) {
      return _model.editPost(mMoment!, chosenImageFile, chosenVideoFile, networkImage, networkVideo);
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
    networkImage = "";
    networkVideo = "";
    _notifySafely();
  }
}
