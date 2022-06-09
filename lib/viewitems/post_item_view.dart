import 'dart:ui';

import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:we_chat_app/data/vos/moment_vo.dart';
import 'package:we_chat_app/explicit_animations/explicit_animation_favourite_button.dart';
import 'package:we_chat_app/resources/dimens.dart';
import 'package:we_chat_app/widgets/divider_with_height_six.dart';
import 'package:we_chat_app/widgets/overlay_for_comment_section_view.dart';
import 'package:we_chat_app/widgets/overlay_for_post_detail_section_view.dart';

class PostItemView extends StatelessWidget {
  const PostItemView({
    Key? key,
    required this.avatarRadius,
    required this.momentVo,
    required this.onTapDelete,
    required this.onTapEdit,
  }) : super(key: key);

  final double avatarRadius;
  final MomentVO? momentVo;
  final Function(int) onTapDelete;
  final Function(int) onTapEdit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 80,
          child: PostHeaderSectionView(
            avatarRadius: avatarRadius,
            profileImage: momentVo?.profilePicture ?? "",
            username: momentVo?.userName ?? "",
          ),
        ),
        GestureDetector(
          onTap: () {
            insertOverlayForPostDetail(context, momentVo ?? MomentVO());
          },
          child: PostDescriptionView(description: momentVo?.description ?? ""),
        ),
        const SizedBox(height: MARGIN_MEDIUM_2),
        Visibility(
          visible: (momentVo?.postImage ?? "").isNotEmpty,
          child: GestureDetector(
            onTap: () {
              insertOverlayForPostDetail(context, momentVo ?? MomentVO());
            },
            child: PostImageView(postImage: momentVo?.postImage ?? ""),
          ),
        ),
        Visibility(
          visible: (momentVo?.postVideo ?? "").isNotEmpty,
          child: PostVideoView(postVideo: momentVo?.postVideo ?? ""),
        ),
        SizedBox(height: MARGIN_MEDIUM_2),
        PostReactionsSectionView(
          onTapDelete: () {
            onTapDelete(momentVo?.id ?? 0);
          },
          onTapEdit: () {
            onTapEdit(momentVo?.id ?? 0);
          },
        ),
        SizedBox(height: MARGIN_MEDIUM),
        DividerWithHeightSix(),
        ReactorsAndCommentsView(),
      ],
    );
  }
}

class PostHeaderSectionView extends StatelessWidget {
  const PostHeaderSectionView({
    Key? key,
    required this.avatarRadius,
    required this.profileImage,
    required this.username,
  }) : super(key: key);

  final double avatarRadius;
  final String profileImage;
  final String username;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              height: 40,
              color: Color.fromRGBO(243, 243, 243, 1.0),
              // color: Colors.blue,
            ),
            Container(
              height: 2,
              color: Color.fromRGBO(203, 202, 199, 0.8),
            )
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(
                left: MARGIN_MEDIUM_3,
                right: MARGIN_MEDIUM_3,
                bottom: MARGIN_MEDIUM),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CircleAvatar(
                      radius: avatarRadius,
                      backgroundImage: NetworkImage(
                        profileImage,
                      ),
                    ),
                    SizedBox(width: MARGIN_CARD_MEDIUM_2),
                    Text(
                      username,
                      style: TextStyle(
                        fontSize: TEXT_REGULAR_2X,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Text(
                  "3 mins ago",
                  style: TextStyle(
                    color: Color.fromRGBO(203, 202, 199, 1.0),
                    fontWeight: FontWeight.w600,
                    fontSize: TEXT_REGULAR - 2,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class PostDescriptionView extends StatelessWidget {
  final String description;

  PostDescriptionView({required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: POST_DESCRIPTION_LEFT_MARGIN, right: MARGIN_CARD_MEDIUM_2),
      child: Text(
        description,
        style: TextStyle(
          color: Color.fromRGBO(0, 0, 0, 0.4),
        ),
      ),
    );
  }
}

class PostImageView extends StatelessWidget {
  final String postImage;

  PostImageView({required this.postImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: MARGIN_CARD_MEDIUM_2),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(MARGIN_CARD_MEDIUM_2),
        child: FadeInImage(
          height: 270,
          width: double.infinity,
          placeholder: NetworkImage(
            "https://t3.ftcdn.net/jpg/04/34/72/82/360_F_434728286_OWQQvAFoXZLdGHlObozsolNeuSxhpr84.jpg",
          ),
          image: NetworkImage(
            postImage,
          ),
          fit: BoxFit.fill,
        ),
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
      videoPlayerController:
      VideoPlayerController.network(widget.postVideo),
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
      margin: EdgeInsets.symmetric(horizontal: MARGIN_CARD_MEDIUM_2),
      child: FlickVideoPlayer(flickManager: flickManager),
    );
  }
}

class PostReactionsSectionView extends StatelessWidget {
  final Function onTapDelete;
  final Function onTapEdit;

  PostReactionsSectionView(
      {required this.onTapDelete, required this.onTapEdit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: MARGIN_CARD_MEDIUM_2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // PostReationIconView(iconData: Icons.favorite_border),
          ExplicitAnimationFavouriteButton(),
          const SizedBox(width: MARGIN_CARD_MEDIUM_2),
          GestureDetector(
            onTap: () {
              insertOverlayForComment(context);
            },
            child: PostReationIconView(iconData: Icons.comment_outlined),
          ),
          const SizedBox(width: MARGIN_CARD_MEDIUM_2),
          MoreButtonView(
            onTapDelete: () {
              onTapDelete();
            },
            onTapEdit: () {
              onTapEdit();
            },
          ),
        ],
      ),
    );
  }
}

class MoreButtonView extends StatelessWidget {
  final Function onTapDelete;
  final Function onTapEdit;

  MoreButtonView({required this.onTapDelete, required this.onTapEdit});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: PostReationIconView(iconData: Icons.more_horiz_outlined),
      itemBuilder: (context) => [
        PopupMenuItem(
          onTap: () {
            onTapEdit();
          },
          child: Text("Edit"),
          value: 1,
        ),
        PopupMenuItem(
          onTap: () {
            onTapDelete();
          },
          child: Text("Delete"),
          value: 2,
        ),
      ],
    );
  }
}

class ReactorsAndCommentsView extends StatelessWidget {
  const ReactorsAndCommentsView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(243, 243, 243, 1.0),
      child: Padding(
        padding: EdgeInsets.only(
            left: POST_DESCRIPTION_LEFT_MARGIN,
            right: POST_DESCRIPTION_LEFT_MARGIN,
            top: MARGIN_CARD_MEDIUM_2),
        child: Column(
          children: [
            ReactorsSectionView(),
            SizedBox(height: MARGIN_MEDIUM_2),
            LastCommentSectionView(),
            SizedBox(height: MARGIN_MEDIUM),
          ],
        ),
      ),
    );
  }
}

class ReactorsSectionView extends StatelessWidget {
  const ReactorsSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.favorite,
          size: MARGIN_LARGE,
          color: Color.fromRGBO(69, 69, 69, 1.0),
        ),
        SizedBox(width: MARGIN_MEDIUM),
        Flexible(
          flex: 1,
          child: Text(
            "Nuno Rocha, Amie Deane, Alan Lu, Sam Deane, Ale Munoz",
            style: TextStyle(
              color: Color.fromRGBO(69, 69, 69, 1.0),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
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
      color: Color.fromRGBO(0, 0, 0, 0.3),
    );
  }
}

class LastCommentSectionView extends StatelessWidget {
  const LastCommentSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.comment,
          size: MARGIN_LARGE,
          color: Color.fromRGBO(69, 69, 69, 1.0),
        ),
        SizedBox(width: MARGIN_MEDIUM),
        Flexible(
          flex: 1,
          child: RichText(
            text: const TextSpan(
              text: "Andy ",
              style: TextStyle(
                color: Color.fromRGBO(69, 69, 69, 1.0),
                fontWeight: FontWeight.w600,
              ),
              children: [
                TextSpan(
                  text:
                      "Dinosaurs are a group of reptiles that dominated the land for over 140 million years (more than 160 million years in some parts of the world).",
                  style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 0.4),
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
