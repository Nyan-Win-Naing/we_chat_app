import 'package:flutter/material.dart';
import 'package:we_chat_app/resources/dimens.dart';

const kAnimationDurationForFavourite = Duration(milliseconds: 500);

class ExplicitAnimationFavouriteButton extends StatefulWidget {
  const ExplicitAnimationFavouriteButton({Key? key}) : super(key: key);

  @override
  State<ExplicitAnimationFavouriteButton> createState() =>
      _ExplicitAnimationFavouriteButtonState();
}

class _ExplicitAnimationFavouriteButtonState
    extends State<ExplicitAnimationFavouriteButton>
    with TickerProviderStateMixin {
  /// State
  bool isAnimationComplete = false;

  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: kAnimationDurationForFavourite,
      vsync: this,
    );

    _colorAnimation =
        ColorTween(begin: Color.fromRGBO(0, 0, 0, 0.3), end: Colors.red)
            .animate(_controller.view);

    _controller.addStatusListener((status) {
      isAnimationComplete = (status == AnimationStatus.completed);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller.view,
      builder: (context, _) => IconButton(
        iconSize: MARGIN_LARGE + 4,
        onPressed: () {
          if(isAnimationComplete) {
            _controller.reverse();
          } else {
            _controller.forward();
          }
        },
        icon: Icon(
          (!isAnimationComplete) ? Icons.favorite_border : Icons.favorite,
          size: MARGIN_LARGE + 4,
          color: _colorAnimation.value,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
