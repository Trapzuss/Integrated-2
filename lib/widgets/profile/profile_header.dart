import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pet_integrated/common/empty_widget.dart';
import 'package:pet_integrated/screens/auth/login_screen.dart';
import 'package:pet_integrated/screens/posts/generate_post_screen.dart';
import 'package:pet_integrated/screens/profile/profile_edit_screen.dart';
import 'package:pet_integrated/screens/profile/profile_history_screen.dart';
import 'package:pet_integrated/screens/profile/profile_posts_screen.dart';
import 'package:pet_integrated/services/authentication.dart';
import 'package:pet_integrated/utils/theme.dart';
import 'package:pet_integrated/widgets/profile/posts/PostListTile.dart';
import 'package:pet_integrated/widgets/profile/profile_action_card.dart';

class ProfileHeader extends StatefulWidget {
  var user;
  var action;
  bool? isGuest = false;
  ProfileHeader(
      {Key? key, required this.user, required this.action, this.isGuest})
      : super(key: key);

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  bool _isGuest = false;
  @override
  void initState() {
    if (widget.isGuest != null) {
      _isGuest = widget.isGuest!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderWidget(),
          !_isGuest ? Container() : TitleWidget(),
          !_isGuest ? ActionWidget() : PostListView()
        ],
      ),
    );
  }

  Widget HeaderWidget() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                child: _getComputedAvatar(),
              ),
            ),
          ),
          widget.user != null
              ? Flexible(
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        Flexible(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.user['firstName']
                                    .toString()
                                    .toUpperCase(),
                                style: AppTheme.style.titleFontStyle,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                              Text(
                                widget.user['lastName']
                                    .toString()
                                    .toUpperCase(),
                                style: AppTheme.style.titleFontStyle,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 6),
                                child: Row(
                                  children: [
                                    Container(
                                      margin:
                                          EdgeInsets.only(right: 2, bottom: 4),
                                      child: Icon(
                                        Icons.email,
                                        color: AppTheme.colors.subInfoFontColor,
                                        size: 16,
                                      ),
                                    ),
                                    Text(
                                      widget.user?['email'] == null
                                          ? ''
                                          : widget.user['email'],
                                      style: AppTheme.style.secondaryFontStyle,
                                    ),
                                  ],
                                ),
                              ),
                              getAddressComputed()
                            ],
                          ),
                        ),
                        !_isGuest
                            ? Container(
                                margin: EdgeInsets.only(right: 10),
                                child: GestureDetector(
                                  child: Icon(
                                    Icons.edit_note_rounded,
                                    color: Colors.grey,
                                    size: 18,
                                  ),
                                  onTap: () async {
                                    await widget.action();
                                  },
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                )
              : Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "You haven't login yet".toString().toUpperCase(),
                        style: AppTheme.style.titleFontStyle,
                      ),
                      Row(
                        children: [
                          // Container(
                          //   margin: EdgeInsets.only(right: 2),
                          //   child: Icon(
                          //     Icons.login,
                          //     size: 14,
                          //     color: AppTheme.colors.subInfoFontColor,
                          //   ),
                          // ),
                          Text(
                            'Please Log in to continue our features',
                            style: AppTheme.style.secondaryFontStyle,
                          )
                        ],
                      ),
                    ],
                  ),
                )
        ],
      ),
    );
  }

  Widget ActionWidget() {
    return widget.user != null
        ? Container(
            margin: EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ProfileActionCard(
                  title: 'Pass on Pets',
                  icon: Icons.add_box,
                  color: Color.fromARGB(255, 153, 181, 122),
                  action: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                GeneratePostScreen(action: 'create')));
                  },
                ),
                ProfileActionCard(
                  title: 'Posts',
                  icon: Icons.pets,
                  color: Color.fromARGB(255, 179, 191, 128),
                  action: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfilePostsScreen()));
                  },
                ),
                // ProfileActionCard(
                //   title: 'History',
                //   icon: Icons.history,
                //   color: Color.fromARGB(255, 180, 199, 132),
                //   action: () {
                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) =>
                //                 ProfileHistoryScreen()));
                //   },
                // )
              ],
            ),
          )
        : Container();
  }

  Widget TitleWidget() {
    return Container(
        margin: EdgeInsets.only(top: 14, bottom: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.handshake,
              size: 18,
              color: AppTheme.colors.primaryFontColor,
            ),
            Text(
              'Adoptation Posts',
              style: AppTheme.style.titleFontStyle.copyWith(
                  color: AppTheme.colors.primaryFontColor, fontSize: 16),
            ),
          ],
        ));
  }

  Widget PostListView() {
    print(widget.user?['posts']);
    return widget.user?['posts']?.length != 0
        ? Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) => PostListTile(
                  index: index,
                  post: widget.user?['posts'][index] ?? null,
                  username: widget.user['firstName']),
              itemCount: widget.user?['posts']?.length == 0
                  ? 0
                  : widget.user?['posts']?.length,
            ),
          )
        : EmptyPostsTypeEmpty();
  }

  getAddressComputed() {
    if (widget.user['address'] != null) {
      return Container(
        margin: EdgeInsets.only(top: 2),
        child: Row(
          children: [
            Flexible(
                child: Icon(
              Icons.location_on,
              size: 16,
              color: Colors.red[300],
            )),
            Flexible(
                child: Text(
              "${widget.user['address']['district']} ${widget.user['address']['province']}, ${widget.user['address']['country']}",
              style: AppTheme.style.secondaryFontStyle,
            ))
          ],
        ),
      );
    }
    return Container();
  }

  _getComputedAvatar() {
    if (widget.user?['imageUrl'] != null) {
      return Image.network(
        widget.user['imageUrl'],
        fit: BoxFit.cover,
        width: 96,
        height: 96,
      );
    }
    return ClipRRect(
      child: Container(
        width: 96,
        height: 96,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Icon(
          Icons.person,
          color: AppTheme.colors.darkFontColor,
          size: 52,
        ),
      ),
    );
  }
}
