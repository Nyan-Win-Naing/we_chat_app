import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:we_chat_app/blocs/chat_room_bloc.dart';
import 'package:we_chat_app/dummy/dummy_conversation_list.dart';
import 'package:we_chat_app/resources/colors.dart';
import 'package:we_chat_app/resources/dimens.dart';
import 'package:we_chat_app/viewitems/chat_function_item_view.dart';
import 'package:we_chat_app/viewitems/message_item_view.dart';

class ChatRoomPage extends StatefulWidget {
  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  bool isOpenFunctionView = false;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return ChangeNotifierProvider(
      create: (context) => ChatRoomBloc(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: PRIMARY_COLOR,
          centerTitle: true,
          leadingWidth: 260,
          elevation: 1,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Row(
              children: const [
                Icon(
                  Icons.chevron_left,
                  color: Color.fromRGBO(255, 255, 255, 0.7),
                  size: MARGIN_XLARGE + 8,
                ),
                Text(
                  "WeChat",
                  style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 0.5),
                    fontSize: TEXT_REGULAR_2X,
                  ),
                ),
              ],
            ),
          ),
          title: const Text(
            "Amie Deane",
            style: TextStyle(
              color: Colors.white,
              fontSize: TEXT_REGULAR_2X,
            ),
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: MARGIN_CARD_MEDIUM_2),
              child: Icon(
                Icons.person_outline_outlined,
                color: Color.fromRGBO(255, 255, 255, 0.7),
                size: MARGIN_LARGE + 6,
              ),
            ),
          ],
        ),
        body: Stack(
          children: [
            Positioned.fill(
              child: ListView.separated(
                // reverse: true,
                padding: EdgeInsets.only(
                  top: MARGIN_MEDIUM_2,
                  bottom: (!isOpenFunctionView) ? MARGIN_3XLARGE : 250,
                  left: MARGIN_MEDIUM_2,
                  right: MARGIN_MEDIUM_2,
                ),
                itemCount: dummyConversationList.length,
                itemBuilder: (context, index) {
                  return MessageItemView(chatVo: dummyConversationList[index]);
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 10,
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ChatTextFieldSectionView(
                screenWidth: screenWidth,
                onTap: () {
                  setState(() {
                    isOpenFunctionView = !isOpenFunctionView;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatTextFieldSectionView extends StatefulWidget {
  ChatTextFieldSectionView({
    Key? key,
    required this.screenWidth,
    required this.onTap,
  }) : super(key: key);

  final double screenWidth;
  final Function onTap;

  @override
  State<ChatTextFieldSectionView> createState() =>
      _ChatTextFieldSectionViewState();
}

class _ChatTextFieldSectionViewState extends State<ChatTextFieldSectionView> {
  final Map<String, dynamic> chatFunctionsMap = {
    "Media": Icons.insert_photo_outlined,
    "Camera": Icons.camera_alt_outlined,
    "Sight": Icons.pageview_outlined,
    "Video Call": Icons.video_camera_back_outlined,
    "Luck Money": Icons.account_balance_wallet_outlined,
    "Transfer": Icons.connect_without_contact_outlined,
    "Favourites": Icons.favorite_border,
    "Location": Icons.location_on_outlined,
  };

  bool isShown = false;

  @override
  Widget build(BuildContext context) {
    final fKeys = chatFunctionsMap.keys.toList();
    final fValues = chatFunctionsMap.values.toList();

    return Consumer<ChatRoomBloc>(
      builder: (context, bloc, child) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          (bloc.chosenImageFile != null || bloc.chosenVideoFile != null)
              ? ChosenFileView(
                  bloc: bloc,
                )
              : Container(),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: MARGIN_MEDIUM_2, vertical: MARGIN_SMALL),
            width: widget.screenWidth,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(230, 230, 230, 1.0),
              border: Border(
                top: BorderSide(
                  color: Color.fromRGBO(213, 213, 213, 1.0),
                  width: 2,
                ),
                bottom: BorderSide(
                  color: Color.fromRGBO(213, 213, 213, 1.0),
                  width: 2,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  Icons.mic_none_outlined,
                  color: Color.fromRGBO(108, 108, 108, 1.0),
                  size: MARGIN_XLARGE,
                ),
                ChatTextFieldView(screenWidth: widget.screenWidth),
                GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    isShown = !isShown;
                    widget.onTap();
                  },
                  child: (!isShown)
                      ? const Icon(
                          Icons.add,
                          color: Color.fromRGBO(108, 108, 108, 1.0),
                          size: MARGIN_XLARGE,
                        )
                      : const Icon(
                          Icons.close,
                          color: Color.fromRGBO(108, 108, 108, 1.0),
                          size: MARGIN_XLARGE,
                        ),
                ),
              ],
            ),
          ),
          AnimatedSize(
            duration: Duration(milliseconds: 500),
            child: Container(
              color: Color.fromRGBO(250, 250, 250, 1.0),
              height: isShown ? null : 0.0,
              child: GridView.builder(
                itemCount: 8,
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      if (index == 0) _chooseMediaFromDevice(bloc);
                      else if(index == 1) _takePhotoFromCamera(bloc);
                    },
                    child: ChatFunctionItemView(
                      icon: fValues[index],
                      label: fKeys[index],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _chooseMediaFromDevice(ChatRoomBloc bloc) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path ?? "");
      bloc.onFileChosen(file);
    }
  }

  void _takePhotoFromCamera(ChatRoomBloc bloc) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if(image != null) {
      bloc.onFileChosen(File(image.path));
    }
  }
}

class ChosenFileView extends StatefulWidget {
  final ChatRoomBloc bloc;

  ChosenFileView({required this.bloc});

  @override
  State<ChosenFileView> createState() => _ChosenFileViewState();
}

class _ChosenFileViewState extends State<ChosenFileView> {
  FlickManager? flickManager;

  @override
  void dispose() {
    flickManager?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 100,
      decoration: BoxDecoration(
          color: Color.fromRGBO(230, 230, 230, 1.0),
          borderRadius: BorderRadius.circular(2),
          border:
              Border.all(color: Color.fromRGBO(213, 213, 213, 1.0), width: 2)),
      child: Stack(
        children: [
          (widget.bloc.chosenImageFile != null)
              ? Image.file(
                  widget.bloc.chosenImageFile ?? File(""),
                  fit: BoxFit.cover,
            width: 200,
                )
              : FlickVideoPlayer(
                  flickManager: FlickManager(
                    videoPlayerController: VideoPlayerController.file(
                        widget.bloc.chosenVideoFile ?? File("")),
                  ),
                ),
          ChosenFileRemover(bloc: widget.bloc),
        ],
      ),
    );
  }
}

class ChosenFileRemover extends StatelessWidget {
  const ChosenFileRemover({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  final ChatRoomBloc bloc;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        bloc.onTapDeleteImage();
      },
      child: const Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: EdgeInsets.only(left: MARGIN_SMALL, top: MARGIN_SMALL),
          child: Icon(
            Icons.close,
            color: PRIMARY_COLOR,
            // color: Colors.redAccent,
            size: MARGIN_MEDIUM_3,
          ),
        ),
      ),
    );
  }
}

class ChatTextFieldView extends StatelessWidget {
  const ChatTextFieldView({
    Key? key,
    required this.screenWidth,
  }) : super(key: key);

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(MARGIN_SMALL),
        border: Border.all(color: Color.fromRGBO(225, 225, 225, 1.0), width: 2),
      ),
      child: Row(
        children: [
          Container(
            width: screenWidth * 1.6 / 3,
            child: TextField(
              minLines: 1,
              maxLines: 3,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Message...",
                hintStyle: TextStyle(
                  color: Color.fromRGBO(218, 218, 218, 1.0),
                ),
                isDense: true,
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 0, vertical: MARGIN_MEDIUM),
              ),
            ),
          ),
          SizedBox(width: MARGIN_SMALL),
          Icon(
            Icons.emoji_emotions,
            color: Color.fromRGBO(108, 108, 108, 1.0),
            size: MARGIN_XLARGE,
          ),
        ],
      ),
    );
  }
}
