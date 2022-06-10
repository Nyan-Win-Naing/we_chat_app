import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_chat_app/blocs/moments_bloc.dart';
import 'package:we_chat_app/data/vos/moment_vo.dart';
import 'package:we_chat_app/pages/add_new_post_page.dart';
import 'package:we_chat_app/resources/colors.dart';
import 'package:we_chat_app/resources/dimens.dart';
import 'package:we_chat_app/resources/strings.dart';
import 'package:we_chat_app/viewitems/post_item_view.dart';
import 'package:we_chat_app/widgets/divider_with_height_six.dart';

class MomentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final avatarRadius = screenHeight / 30;

    return ChangeNotifierProvider(
      create: (context) => MomentsBloc(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: PRIMARY_COLOR,
          automaticallyImplyLeading: false,
          leadingWidth: 260,
          centerTitle: true,
          elevation: 1,
          title: const Text(
            MOMENT_APP_BAR_TITLE,
            style: TextStyle(
              color: Colors.white,
              fontSize: TEXT_REGULAR_2X,
            ),
          ),
          leading: Padding(
            padding: const EdgeInsets.only(left: 0),
            child: Row(
              children: const [
                Icon(
                  Icons.chevron_left,
                  color: MOMENT_APP_BAR_LEADING_ICON_COLOR,
                  size: MARGIN_XLARGE + 8,
                ),
                Text(
                  MOMENT_APP_BAR_LEADING_TEXT,
                  style: TextStyle(
                    color: MOMENT_APP_BAR_LEADING_TEXT_COLOR,
                    fontSize: TEXT_REGULAR_2X,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: MARGIN_CARD_MEDIUM_2),
              child: GestureDetector(
                onTap: () {
                  _navigateToAddNewPostPage(context);
                },
                child: const Icon(
                  Icons.add_a_photo_outlined,
                  color: MOMENT_APP_BAR_LEADING_ICON_COLOR,
                  size: MARGIN_LARGE,
                ),
              ),
            ),
          ],
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const MomentPageProfileSectionView(),
                Selector<MomentsBloc, List<MomentVO>>(
                  selector: (context, bloc) => bloc.moments ?? [],
                  builder: (context, moments, child) => ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: moments.length,
                    itemBuilder: (context, index) {
                      MomentsBloc bloc = Provider.of(context, listen: false);
                      return PostItemView(
                        avatarRadius: avatarRadius,
                        momentVo: moments[index],
                        onTapDelete: (momentId) {
                          bloc.onTapDeletePost(momentId);
                        },
                        onTapEdit: (momentId) {
                          Future.delayed(const Duration(milliseconds: 1000))
                              .then((value) {
                            _navigateToEditPostPage(context, momentId);
                          });
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToAddNewPostPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddNewPostPage(),
      ),
    );
  }

  void _navigateToEditPostPage(BuildContext context, int momentId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddNewPostPage(
          momentId: momentId,
        ),
      ),
    );
  }
}

class MomentPageProfileSectionView extends StatelessWidget {
  const MomentPageProfileSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight * 1.12 / 3,
      color: MOMENT_PAGE_BACKGROUND_COLOR,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child:
                ProfileBackgroundImageSectionView(screenHeight: screenHeight),
          ),
          const Positioned(
            bottom: MARGIN_MEDIUM_2,
            left: 100,
            child: ProfilePhotoView(),
          ),
          const Align(
            alignment: Alignment.bottomRight,
            child: DateAndMomentsCountView(),
          )
        ],
      ),
    );
  }
}

class DateAndMomentsCountView extends StatelessWidget {
  const DateAndMomentsCountView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          bottom: MARGIN_CARD_MEDIUM_2, right: MARGIN_CARD_MEDIUM_2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text(
            "Sunday, Sept 14, 2015",
            style: TextStyle(
              fontSize: TEXT_REGULAR - 2,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            "23 new moments",
            style: TextStyle(
              fontSize: TEXT_REGULAR - 2,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class ProfilePhotoView extends StatelessWidget {
  const ProfilePhotoView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.grey,
        shape: BoxShape.circle,
        border: Border.all(color: MOMENT_PAGE_PROFILE_PHOTO_BORDER_COLOR, width: 2),
        image: const DecorationImage(
          image: NetworkImage(
            "https://i.pinimg.com/236x/4e/9f/03/4e9f035d05faeb0561835197a51a51f5.jpg",
          ),
        ),
      ),
    );
  }
}

class ProfileBackgroundImageSectionView extends StatelessWidget {
  const ProfileBackgroundImageSectionView({
    Key? key,
    required this.screenHeight,
  }) : super(key: key);

  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: screenHeight * 0.9 / 3,
          color: Colors.pink,
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.network(
                  "https://ak.picdn.net/shutterstock/videos/11526233/thumb/1.jpg?ip=x480",
                  fit: BoxFit.cover,
                ),
              ),
              const Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: EdgeInsets.only(
                      right: MARGIN_CARD_MEDIUM_2,
                      bottom: MARGIN_CARD_MEDIUM_2),
                  child: Text(
                    "Nina Rocha",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: TEXT_REGULAR_2X,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        DividerWithHeightSix(),
      ],
    );
  }
}
