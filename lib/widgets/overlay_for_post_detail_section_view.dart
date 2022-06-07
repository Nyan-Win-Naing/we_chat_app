import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:we_chat_app/resources/dimens.dart';

late OverlayEntry overlayEntryForPostDetail;

void insertOverlayForPostDetail(BuildContext context) {
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
                    PosterNameView(),
                    SizedBox(height: MARGIN_MEDIUM_2),
                    PostDescriptionView(),
                    SizedBox(height: MARGIN_MEDIUM_2),
                    PostImageView(),
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
  const PostImageView({
    Key? key,
  }) : super(key: key);

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
            "https://c2.staticflickr.com/4/3612/3320152658_f7a7c527c1_z.jpg",
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

class PostDescriptionView extends StatelessWidget {
  const PostDescriptionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: MARGIN_XLARGE),
      child: Text(
        "Dinosaurs are a diverse group of reptiles of the clade Dinosauria. They first appeared during the Triassic period, between 243 and 233.23 million years ago, although the exact origin and timing of the evolution of dinosaurs is the subject of active research.",
        style: TextStyle(
          color: Color.fromRGBO(98, 98, 98, 1.0),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class PosterNameView extends StatelessWidget {
  const PosterNameView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: MARGIN_XLARGE),
      child: Text(
        "Lieven Deprez",
        style: TextStyle(
          color: Colors.white,
          fontSize: TEXT_REGULAR_2X,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
