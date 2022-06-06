import 'package:flutter/material.dart';
import 'package:we_chat_app/resources/dimens.dart';
import 'package:we_chat_app/widgets/DividerWithHeightSix.dart';

class PostItemView extends StatelessWidget {
  const PostItemView({
    Key? key,
    required this.avatarRadius,
  }) : super(key: key);

  final double avatarRadius;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 80,
          child: PostHeaderSectionView(avatarRadius: avatarRadius),
        ),
        PostDescriptionView(),
        SizedBox(height: MARGIN_MEDIUM_2),
        PostImageView(),
        SizedBox(height: MARGIN_MEDIUM_2),
        PostReactionsSectionView(),
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
  }) : super(key: key);

  final double avatarRadius;

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
                        "http://www.asianjunkie.com/wp-content/uploads/2017/03/GirlsDayIllBeYoursYura.jpg",
                      ),
                    ),
                    SizedBox(width: MARGIN_CARD_MEDIUM_2),
                    Text(
                      "Lieven Deprez",
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
  const PostDescriptionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: POST_DESCRIPTION_LEFT_MARGIN, right: MARGIN_CARD_MEDIUM_2),
      child: Text(
        "Dinosaurs are a diverse group of reptiles of the clade Dinosauria. They first appeared during the Triassic period, between 243 and 233.23 million years ago, although the exact origin and timing of the evolution of dinosaurs is the subject of active research.",
        style: TextStyle(
          color: Color.fromRGBO(0, 0, 0, 0.4),
        ),
      ),
    );
  }
}

class PostImageView extends StatelessWidget {
  const PostImageView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: MARGIN_CARD_MEDIUM_2),
      height: 270,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
        // color: Colors.blue,
        image: DecorationImage(
          image: NetworkImage(
            "https://assets.londonist.com/uploads/2016/09/i875/dinos.jpg",
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class PostReactionsSectionView extends StatelessWidget {
  const PostReactionsSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: MARGIN_CARD_MEDIUM_2),
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