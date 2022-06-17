import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:we_chat_app/blocs/chat_room_bloc.dart';
import 'package:we_chat_app/data/vos/user_vo.dart';
import 'package:we_chat_app/dummy/dummy_conversation_list.dart';
import 'package:we_chat_app/pages/home_page.dart';
import 'package:we_chat_app/pages/we_chat_app.dart';
import 'package:we_chat_app/resources/colors.dart';
import 'package:we_chat_app/resources/dimens.dart';
import 'package:we_chat_app/viewitems/chat_function_item_view.dart';
import 'package:we_chat_app/viewitems/message_item_view.dart';
import 'package:we_chat_app/widgets/loading_view.dart';

class ChatRoomPage extends StatefulWidget {
  final UserVO userVo;

  ChatRoomPage({required this.userVo});

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  bool isOpenFunctionView = false;

  @override
  Widget build(BuildContext context) {
    // print("User vo in chat room is.......... ${widget.userVo}");
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return ChangeNotifierProvider(
      create: (context) => ChatRoomBloc(widget.userVo),
      child: Selector<ChatRoomBloc, bool>(
        selector: (context, bloc) => bloc.isLoading,
        builder: (context, isLoading, child) => WillPopScope(
          onWillPop: () async {
            print("Pop works................");
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => WeChatApp(index: 0),
              ),
            );
            return false;
          },
          child: Stack(
            children: [
              Scaffold(
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
                  title: Text(
                    widget.userVo.userName ?? "",
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
                      child: Consumer<ChatRoomBloc>(
                        builder: (context, bloc, child) =>
                        (bloc.messages?.isNotEmpty ?? false)
                            ? ListView.separated(
                          reverse: true,
                          padding: EdgeInsets.only(
                            top: MARGIN_MEDIUM_2,
                            bottom: (!isOpenFunctionView)
                                ? MARGIN_3XLARGE
                                : 250,
                            left: MARGIN_MEDIUM_2,
                            right: MARGIN_MEDIUM_2,
                          ),
                          itemCount: bloc.messages?.length ?? 0,
                          itemBuilder: (context, index) {
                            return MessageItemView(
                              messageVo: bloc.messages?[index],
                              bloc: bloc,
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 10,
                            );
                          },
                        )
                            : Center(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: MARGIN_LARGE),
                            child: Text(
                              "No Messages with ${widget.userVo.userName}",
                              style: TextStyle(
                                color: Color.fromRGBO(0, 0, 0, 0.5),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
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
                        user: widget.userVo,
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: isLoading,
                child: Container(
                  color: Colors.black54,
                  child: const Center(
                    child: LoadingView(),
                  ),
                ),
              ),
            ],
          ),
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
    required this.user,
  }) : super(key: key);

  final double screenWidth;
  final Function onTap;
  final UserVO? user;

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
  FocusNode fNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    fNode.dispose();
  }

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
                ChatTextFieldView(
                  screenWidth: widget.screenWidth,
                  user: widget.user,
                  focusNode: fNode,
                  onTap: () {
                    widget.onTap();
                  },
                ),
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
                      if (index == 0) {
                        _chooseMediaFromDevice(bloc);
                        isShown = !isShown;
                        widget.onTap();
                        FocusScope.of(context).requestFocus(fNode);
                      } else if (index == 1) {
                        _takePhotoFromCamera(bloc);
                        widget.onTap();
                        FocusScope.of(context).requestFocus(fNode);
                        isShown = !isShown;
                      }
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
    if (image != null) {
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
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(230, 230, 230, 1.0),
        border: Border(
          top: BorderSide(color: Color.fromRGBO(213, 213, 213, 1.0), width: 2),
        ),
      ),
      padding: EdgeInsets.only(
          top: MARGIN_MEDIUM,
          bottom: MARGIN_MEDIUM,
          left: MARGIN_XXLARGE + MARGIN_MEDIUM,
          right: MARGIN_XXLARGE),
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
          padding: EdgeInsets.only(top: MARGIN_SMALL, left: MARGIN_SMALL),
          child: Icon(
            Icons.close,
            color: HOME_SCREEEN_BACKGROUND_COLOR,
            // color: Colors.redAccent,
            size: MARGIN_MEDIUM_3,
          ),
        ),
      ),
    );
  }
}

class ChatTextFieldView extends StatelessWidget {
  ChatTextFieldView({
    required this.screenWidth,
    required this.user,
    required this.focusNode,
    required this.onTap,
  });

  final double screenWidth;
  final UserVO? user;
  final FocusNode focusNode;
  final Function onTap;

  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatRoomBloc>(
      builder: (context, bloc, child) => Container(
        padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(MARGIN_SMALL),
          border:
          Border.all(color: Color.fromRGBO(225, 225, 225, 1.0), width: 2),
        ),
        child: Row(
          children: [
            Container(
              width: screenWidth * 1.6 / 3,
              child: TextFormField(
                controller: _controller..text = bloc.message ..selection = TextSelection.collapsed(offset: _controller.text.length),
                textInputAction: TextInputAction.send,
                focusNode: focusNode,
                autofocus: true,
                onFieldSubmitted: (value) {
                  bloc.onSendMessage(user ?? UserVO());
                  _controller.clear();

                },
                onChanged: (message) {
                  bloc.onMessageChanged(message);
                },
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
      ),
    );
  }
}