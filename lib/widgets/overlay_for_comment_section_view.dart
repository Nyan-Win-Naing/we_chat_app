import 'package:flutter/material.dart';
import 'package:we_chat_app/resources/dimens.dart';


late OverlayEntry overlayEntryForComment;

void insertOverlayForComment(BuildContext context) {
  overlayEntryForComment = OverlayEntry(
    builder: (context) {
      final size = MediaQuery.of(context).size;
      print(size.width);
      return GestureDetector(
        onTap: () {
          overlayEntryForComment.remove();
        },
        child: Scaffold(
          backgroundColor: const Color.fromRGBO(0, 0, 0, 0.85),
          body: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.only(bottom: MARGIN_MEDIUM),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Color.fromRGBO(66, 177, 98, 1.0),
                            size: MARGIN_MEDIUM_3,
                          ),
                          const SizedBox(width: MARGIN_SMALL),
                          Container(
                            height: 2,
                            width:
                            MediaQuery.of(context).size.width * 2.3 / 3,
                            color: Color.fromRGBO(45, 81, 53, 1.0),
                          )
                        ],
                      ),
                      const CommentTextFieldView(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );

  return Overlay.of(context)?.insert(overlayEntryForComment);
}

class CommentTextFieldView extends StatelessWidget {
  const CommentTextFieldView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 2.3 / 3,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Alan Lu",
            style: TextStyle(
              color: Colors.white,
              fontSize: TEXT_REGULAR_2X,
              fontWeight: FontWeight.w600,
            ),
          ),
          Container(
            width:
            MediaQuery.of(context).size.width * 1.4 / 3,
            child: const TextField(
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.5),
                fontSize: TEXT_REGULAR,
              ),
              autofocus: true,
              minLines: 1,
              maxLines: 3,
              decoration: InputDecoration(
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.only(
                  left: 0,
                  right: 0,
                  top: 0,
                  bottom: MARGIN_SMALL,
                ),
                hintText: "Write a comment.....",
                hintStyle: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 0.5),
                  fontSize: TEXT_REGULAR,
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: MARGIN_MEDIUM),
            child: Icon(
              Icons.emoji_emotions,
              color: Color.fromRGBO(99, 99, 99, 1.0),
              size: MARGIN_XLARGE,
            ),
          ),
        ],
      ),
    );
  }
}