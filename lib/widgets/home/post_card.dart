import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pet_integrated/common/empty_widget.dart';
import 'package:pet_integrated/screens/chat/chat_screen.dart';
import 'package:pet_integrated/services/authentication.dart';
import 'package:pet_integrated/utils/theme.dart';
import 'package:pet_integrated/utils/utils.dart';

class PostCard extends StatefulWidget {
  var post;
  PostCard({Key? key, required this.post}) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  var _user;
  bool loading = true;
  _initUserData() async {
    _user = await AuthenticationServices.getProfileFromState();
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initUserData();
    });
  }

  @override
  Widget build(BuildContext context) {
    var sexIcons = {
      'female': Icon(
        Icons.female,
        color: Colors.pink[200],
        size: 16,
      ),
      'male': Icon(
        Icons.male,
        color: Colors.blue[300],
        size: 16,
      ),
      'unknown': Icon(
        Icons.question_mark,
        color: AppTheme.colors.subInfoFontColor,
        size: 16,
      )
    };

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return loading
        ? LoadingWidget()
        : Stack(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: width / 2 - 20,
                    child: Card(
                      child: Container(
                        padding: EdgeInsets.all(6),
                        child: Column(
                          children: [
                            Container(
                                margin: EdgeInsets.only(bottom: 6),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: widget.post?['images']?[0] == null
                                      ? EmptyImage()
                                      : Image.network(
                                          widget.post['images'][0].toString(),
                                          fit: BoxFit.cover,
                                        ),
                                )),
                            Container(
                              margin: EdgeInsets.only(bottom: 3),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    flex: 3,
                                    child: Container(
                                      child: Text(
                                        widget.post['petName'],
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                AppTheme.colors.infoFontColor),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      widget.post['price'] == 0
                                          ? "Free"
                                          : "${widget.post['price'].toString()} Baht",
                                      maxLines: 2,
                                      style: AppTheme.style.primaryFontStyle,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: width / 2 - 20,
                              margin: EdgeInsets.only(bottom: 3),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.location_on_rounded,
                                    color: Colors.red[300],
                                    size: 16,
                                  ),
                                  Flexible(
                                    child: Text(
                                      "${widget.post['address']['district']} ${widget.post['address']['province']}, ${widget.post['address']['country']}",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                          color:
                                              AppTheme.colors.subInfoFontColor),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                    height: 28,
                                    margin: EdgeInsets.only(right: 4),
                                    child: Row(
                                      children: [
                                        sexIcons[
                                                '${widget.post['sex'].toString()}']
                                            as Widget,
                                        Text(
                                          ExtensionServices.capitalize(
                                              widget.post['sex'].toString()),
                                          style:
                                              AppTheme.style.secondaryFontStyle,
                                        ),
                                      ],
                                    )
                                    // Chip(
                                    //     backgroundColor: AppTheme.colors.primaryShade,
                                    //     label: Text(
                                    //       ExtensionServices.capitalize(
                                    //           post['sex'].toString()),
                                    //       style: AppTheme.style.secondaryFontStyle,
                                    //     )
                                    //     ),
                                    ),
                                Container(
                                    height: 28,
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.cake,
                                          color:
                                              AppTheme.colors.subInfoFontColor,
                                          size: 16,
                                        ),
                                        Text(
                                          getAgeComputed(),
                                          style:
                                              AppTheme.style.secondaryFontStyle,
                                        ),
                                      ],
                                    )
                                    // Chip(
                                    //     backgroundColor: AppTheme.colors.primaryShade,
                                    //     label: Text(
                                    //       getAgeComputed(),
                                    //       style: AppTheme.style.secondaryFontStyle,
                                    //     )),
                                    ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Row(
                                    children: [
                                      widget.post['user']?['imageUrl'] != null
                                          ? CircleAvatar(
                                              radius: 16,
                                              backgroundImage: NetworkImage(
                                                  "${widget.post['user']?['imageUrl']}"),
                                              backgroundColor: Colors.white,
                                            )
                                          : CircleAvatar(
                                              radius: 16,
                                              child: Icon(
                                                Icons.person,
                                                color: AppTheme
                                                    .colors.darkFontColor,
                                              ),
                                              backgroundColor:
                                                  AppTheme.colors.notWhite,
                                            ),
                                      Flexible(
                                        child: Container(
                                          margin: EdgeInsets.only(left: 4),
                                          child: Text(
                                            widget.post['user']['firstName']
                                                .toString(),
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: false,
                                            maxLines: 1,
                                            style:
                                                AppTheme.style.primaryFontStyle,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                // _user?['_id'] != widget.post?['userId']
                                //     ? Container(
                                //         width: 30,
                                //         child: ElevatedButton(
                                //             onPressed: () {
                                //               Navigator.push(
                                //                   context,
                                //                   MaterialPageRoute(
                                //                       builder: (context) =>
                                //                           ChatScreen(
                                //                               post: widget.post,
                                //                               user: _user,
                                //                               chatId:
                                //                                   widget.post?['chat']
                                //                                       ?['_id'])));
                                //             },
                                //             child: Icon(
                                //               Icons.chat,
                                //               size: 16,
                                //             ),
                                //             style: ElevatedButton.styleFrom(
                                //                 padding: EdgeInsets.all(0),
                                //                 elevation: 0,
                                //                 shape: CircleBorder())),
                                //       )
                                //     : Container()
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
              widget.post?['adoptedBy'] != null
                  ? Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        width: (width / 2) - 85,
                        height: 35,
                        decoration: BoxDecoration(
                            color: Colors.green[100],
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                margin: EdgeInsets.only(left: 6, right: 2),
                                child: Text(
                                  'Confirmed',
                                  style: AppTheme.style.primaryFontStyle,
                                )),
                            CircleAvatar(
                              // radius: 30,
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                              ),
                              backgroundColor: Colors.green[200],
                            ),
                          ],
                        ),
                      ))
                  : Container()
            ],
          );
  }

  getAgeComputed() {
    if ("${widget.post?['age']?['year']}" == null ||
        "${widget.post?['age']?['year']}" == "null") {
      return 'Unknown';
    }
    return "${widget.post?['age']?['year'].toString()} yrs,${widget.post?['age']?['month'].toString()} mo";
  }
}
