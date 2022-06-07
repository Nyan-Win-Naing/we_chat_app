import 'package:flutter/material.dart';
import 'package:we_chat_app/resources/colors.dart';
import 'package:we_chat_app/resources/dimens.dart';

class AddNewPostPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sHeight = MediaQuery.of(context).size.height;
    final avatarRadius = sHeight / 30;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        // backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: Text(
          "Create Post",
          style: TextStyle(
            color: Colors.white,
            fontSize: TEXT_REGULAR_2X,
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.clear_outlined,
            color: Color.fromRGBO(255, 255, 255, 0.6),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: MARGIN_MEDIUM_2, vertical: MARGIN_CARD_MEDIUM_2),
            child: TextButton(
              onPressed: () {},
              child: Text(
                "Post",
                style: TextStyle(
                  color: PRIMARY_COLOR,
                  fontWeight: FontWeight.w600,
                  fontSize: TEXT_REGULAR_2X,
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: MARGIN_CARD_MEDIUM_2),
                  ProfileAndPostMethodsSectionView(avatarRadius: avatarRadius),
                  SizedBox(height: MARGIN_MEDIUM),
                  PostDescriptionAndImageSectionView(),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: BottomSectionView(),
            )
          ],
        ),
      ),
    );
  }
}

class BottomSectionView extends StatefulWidget {
  const BottomSectionView({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomSectionView> createState() => _BottomSectionViewState();
}

class _BottomSectionViewState extends State<BottomSectionView> {
  bool openBottomSheet = true;

  @override
  Widget build(BuildContext context) {
    // return (openBottomSheet)
    //     ? Container(
    //         decoration: BoxDecoration(
    //           color: Colors.white,
    //           borderRadius: BorderRadius.only(
    //             topLeft: Radius.circular(MARGIN_MEDIUM_3),
    //             topRight: Radius.circular(MARGIN_MEDIUM_3),
    //           ),
    //           boxShadow: [
    //             BoxShadow(
    //               color: Color.fromRGBO(0, 0, 0, 0.1),
    //               spreadRadius: 1,
    //               blurRadius: 1,
    //               offset: Offset(0, -1),
    //             )
    //           ],
    //         ),
    //         child: Column(
    //           mainAxisSize: MainAxisSize.min,
    //           children: [
    //             GestureDetector(
    //               onTap: () {
    //                 setState(() {
    //                   openBottomSheet = !openBottomSheet;
    //                 });
    //               },
    //               child: Icon(
    //                 Icons.keyboard_arrow_down_outlined,
    //                 color: Color.fromRGBO(0, 0, 0, 0.2),
    //                 size: MARGIN_XLARGE,
    //               ),
    //             ),
    //             Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               mainAxisSize: MainAxisSize.min,
    //               children: [
    //                 PostOptionItemView(
    //                     icon: Icons.insert_photo_outlined,
    //                     label: "Photo/video",
    //                     color: Colors.green),
    //                 PostOptionItemView(
    //                     icon: Icons.person_pin_outlined,
    //                     label: "Tag people",
    //                     color: Colors.blue),
    //                 PostOptionItemView(
    //                     icon: Icons.emoji_emotions_outlined,
    //                     label: "Feeling/activity",
    //                     color: Colors.yellow),
    //                 PostOptionItemView(
    //                     icon: Icons.location_on_outlined,
    //                     label: "Check in",
    //                     color: Colors.red),
    //                 PostOptionItemView(
    //                     icon: Icons.video_camera_back,
    //                     label: "Live video",
    //                     color: Colors.redAccent),
    //                 PostOptionItemView(
    //                     icon: Icons.color_lens_rounded,
    //                     label: "Background color",
    //                     color: Colors.orangeAccent),
    //               ],
    //             )
    //           ],
    //         ),
    //       )
    //     : Container(
    //         width: double.infinity,
    //         decoration: BoxDecoration(
    //           color: Colors.white,
    //           borderRadius: BorderRadius.only(
    //             topLeft: Radius.circular(MARGIN_MEDIUM_3),
    //             topRight: Radius.circular(MARGIN_MEDIUM_3),
    //           ),
    //           boxShadow: [
    //             BoxShadow(
    //               color: Color.fromRGBO(0, 0, 0, 0.1),
    //               spreadRadius: 1,
    //               blurRadius: 1,
    //               offset: Offset(0, -1),
    //             )
    //           ],
    //         ),
    //         child: GestureDetector(
    //           onTap: () {
    //             setState(() {
    //               openBottomSheet = !openBottomSheet;
    //             });
    //           },
    //           child: Icon(
    //             Icons.keyboard_arrow_up_outlined,
    //             color: Color.fromRGBO(33, 230, 88, 1.0),
    //             size: MARGIN_XLARGE,
    //           ),
    //         ),
    //       );
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(MARGIN_MEDIUM_3),
          topRight: Radius.circular(MARGIN_MEDIUM_3),
        ),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.1),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, -1),
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                openBottomSheet = !openBottomSheet;
              });
            },
            child: Icon(
              (openBottomSheet) ? Icons.keyboard_arrow_down_outlined : Icons.keyboard_arrow_up_outlined,
              color: (openBottomSheet) ? Color.fromRGBO(0, 0, 0, 0.2) : PRIMARY_COLOR,
              size: MARGIN_XLARGE,
            ),
          ),
          AnimatedSize(
            duration: Duration(milliseconds: 500),
            child: Container(
              height: (openBottomSheet) ? null : 0.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  PostOptionItemView(
                      icon: Icons.insert_photo_outlined,
                      label: "Photo/video",
                      color: Colors.green),
                  PostOptionItemView(
                      icon: Icons.person_pin_outlined,
                      label: "Tag people",
                      color: Colors.blue),
                  PostOptionItemView(
                      icon: Icons.emoji_emotions_outlined,
                      label: "Feeling/activity",
                      color: Colors.yellow),
                  PostOptionItemView(
                      icon: Icons.location_on_outlined,
                      label: "Check in",
                      color: Colors.red),
                  PostOptionItemView(
                      icon: Icons.video_camera_back,
                      label: "Live video",
                      color: Colors.redAccent),
                  PostOptionItemView(
                      icon: Icons.color_lens_rounded,
                      label: "Background color",
                      color: Colors.orangeAccent),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class PostOptionItemView extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  PostOptionItemView(
      {required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: color,
        size: MARGIN_LARGE + 4,
      ),
      title: Transform.translate(
        offset: Offset(-10, 0),
        child: Text(
          label,
          style: TextStyle(
            fontSize: TEXT_REGULAR,
            fontWeight: FontWeight.w500,
            color: Color.fromRGBO(0, 0, 0, 0.7),
          ),
        ),
      ),
      contentPadding: EdgeInsets.only(left: MARGIN_MEDIUM_2),
      visualDensity: VisualDensity(horizontal: 0, vertical: -2),
    );
  }
}

class PostDescriptionAndImageSectionView extends StatelessWidget {
  const PostDescriptionAndImageSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
      // color: Colors.blue,
      child: Column(
        children: [
          TextField(
            minLines: 1,
            maxLines: 10,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "What's on your mind?",
                hintStyle: TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 0.3),
                  fontWeight: FontWeight.w400,
                )),
          ),
          Stack(
            children: [
              Image.network(
                // "https://www.remotelands.com/travelogues/app/uploads/2019/04/Pyin-Oo-Lwin-header.jpg",
                "https://i.stack.imgur.com/5MSZ1.jpg",
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: MARGIN_MEDIUM, top: MARGIN_MEDIUM),
                  child: Icon(
                    Icons.close,
                    color: Color.fromRGBO(255, 255, 255, 0.5),
                    size: MARGIN_MEDIUM_3,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class ProfileAndPostMethodsSectionView extends StatelessWidget {
  const ProfileAndPostMethodsSectionView({
    Key? key,
    required this.avatarRadius,
  }) : super(key: key);

  final double avatarRadius;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
      child: Row(
        children: [
          CircleAvatar(
            radius: avatarRadius,
            backgroundImage: NetworkImage(
              "https://data.whicdn.com/images/339581930/original.jpg",
            ),
          ),
          SizedBox(width: MARGIN_MEDIUM),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Alberto Calvo",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: MARGIN_MEDIUM),
              Row(
                children: [
                  PostMethodItemView(iconData: Icons.public, label: "Public"),
                  SizedBox(width: MARGIN_SMALL),
                  PostMethodItemView(iconData: Icons.add, label: "Album"),
                  SizedBox(width: MARGIN_SMALL),
                  PostMethodItemView(iconData: Icons.facebook, label: "Off"),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class PostMethodItemView extends StatelessWidget {
  final IconData iconData;
  final String label;

  PostMethodItemView({required this.iconData, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: MARGIN_SMALL, vertical: 2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(MARGIN_SMALL),
          border: Border.all(
            color: Color.fromRGBO(0, 0, 0, 0.3),
            width: 1,
          )),
      child: Row(
        children: [
          Icon(
            iconData,
            color: Color.fromRGBO(109, 109, 109, 1.0),
            size: MARGIN_MEDIUM_2,
          ),
          SizedBox(width: 2),
          Text(
            label,
            style: TextStyle(
              color: Color.fromRGBO(109, 109, 109, 1.0),
              fontSize: 12,
            ),
          ),
          SizedBox(width: 2),
          Icon(
            Icons.arrow_drop_down,
            color: Color.fromRGBO(109, 109, 109, 1.0),
            size: MARGIN_MEDIUM_2,
          )
        ],
      ),
    );
  }
}
