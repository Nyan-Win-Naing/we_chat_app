import 'dart:ui';

import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:we_chat_app/data/vos/moment_vo.dart';
import 'package:we_chat_app/resources/dimens.dart';

late OverlayEntry overlayEntryForPostDetail;

void insertOverlayForPostDetail(BuildContext context, MomentVO moment) {
  overlayEntryForPostDetail = OverlayEntry(
    builder: (context) {
      return BackdropFilter(
        filter: new ImageFilter.blur(sigmaX: 5.0, sigmaY: 10.0),
        child: Scaffold(
          backgroundColor: Color.fromRGBO(0, 0, 0, 0.8),
          body: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PosterNameView(userName: moment.userName ?? ""),
                    const SizedBox(height: MARGIN_MEDIUM_2),
                    PostDescriptionView(description: moment.description ?? ""),
                    const SizedBox(height: MARGIN_MEDIUM_2),
                    Visibility(
                      visible: (moment.postImage ?? "").isNotEmpty,
                      child: PostImageView(postImage: moment.postImage ?? ""),
                    ),
                    Visibility(
                      visible: (moment.postVideo ?? "").isNotEmpty,
                      child: PostVideoView(postVideo: moment.postVideo ?? ""),
                    ),
                    SizedBox(height: MARGIN_CARD_MEDIUM_2),
                    PostReactionIconListSectionView(),
                  ],
                ),
              ),
              Positioned(
                bottom: 60,
                left: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    overlayEntryForPostDetail.remove();
                  },
                  child: Icon(
                    Icons.keyboard_arrow_down_outlined,
                    color: Color.fromRGBO(255, 255, 255, 0.6),
                    size: MARGIN_XXLARGE,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );

  return Overlay.of(context)?.insert(overlayEntryForPostDetail);
}

class PostReactionIconListSectionView extends StatelessWidget {
  const PostReactionIconListSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: MARGIN_MEDIUM_2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          PostReationIconView(iconData: Icons.favorite_border),
          SizedBox(width: MARGIN_CARD_MEDIUM_2),
          PostReationIconView(iconData: Icons.comment_outlined),
          SizedBox(width: MARGIN_CARD_MEDIUM_2),
          PostReationIconView(iconData: Icons.more_horiz_outlined),
        ],
      ),
    );
  }
}

class PostReationIconView extends StatelessWidget {
  final IconData iconData;

  PostReationIconView({required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Icon(
      iconData,
      size: MARGIN_LARGE + 4,
      color: Color.fromRGBO(255, 255, 255, 0.6),
    );
  }
}

class PostImageView extends StatelessWidget {
  final String postImage;

  PostImageView({required this.postImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
      height: 270,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
        // color: Colors.blue,
        image: DecorationImage(
          image: NetworkImage(
            postImage,
          ),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.8),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 3),
          )
        ],
      ),
    );
  }
}

class PostVideoView extends StatefulWidget {
  final String postVideo;

  PostVideoView({required this.postVideo});

  @override
  State<PostVideoView> createState() => _PostVideoViewState();
}

class _PostVideoViewState extends State<PostVideoView> {
  late FlickManager flickManager;

  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.network(widget.postVideo),
    );
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
      // height: 270,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.8),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: FlickVideoPlayer(
        flickManager: flickManager,
      ),
    );
  }
}

class PostDescriptionView extends StatelessWidget {
  final String description;

  PostDescriptionView({required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: MARGIN_XLARGE),
      child: Text(
        description,
        style: const TextStyle(
          color: Color.fromRGBO(114, 114, 114, 1.0),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class PosterNameView extends StatelessWidget {
  final String userName;

  PosterNameView({required this.userName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: MARGIN_XLARGE),
      child: Text(
        userName,
        style: const TextStyle(
          color: Colors.white,
          fontSize: TEXT_REGULAR_2X,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
