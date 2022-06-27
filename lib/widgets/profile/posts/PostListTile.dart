import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pet_integrated/screens/posts/post_screen.dart';
import 'package:pet_integrated/services/posts.dart';
import 'package:pet_integrated/utils/theme.dart';
import 'package:pet_integrated/utils/utils.dart';

class PostListTile extends StatefulWidget {
  int index;
  var post;
  String username;
  PostListTile(
      {Key? key,
      required this.index,
      required this.post,
      required this.username})
      : super(key: key);

  @override
  State<PostListTile> createState() => _PostListTileState();
}

class _PostListTileState extends State<PostListTile> {
  @override
  Widget build(BuildContext context) {
    // print(widget.post);
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(top: 4),
        child: ListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            tileColor: Colors.white,
            leading: ClipRRect(
              child: Image.network(
                widget.post?['images']?[0] == null
                    ? 'https://via.placeholder.com/80'
                    : widget.post['images'][0].toString(),
                fit: BoxFit.cover,
                width: 80,
                height: 120,
              ),
              borderRadius: BorderRadius.circular(6),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 4),
                  child: Text(
                    "${widget.post['petName']}",
                    style: AppTheme.style.primaryFontStyle
                        .copyWith(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 4),
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.red[300],
                        size: 16,
                      ),
                      Flexible(
                        child: Text(
                          getAddressComputed(),
                          overflow: TextOverflow.ellipsis,
                          style: AppTheme.style.secondaryFontStyle,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 4),
                  child: Text(
                    widget.post?['adoptedAt'] == null
                        ? 'No Adopter yet'
                        : 'Confirm',
                    style: AppTheme.style.secondaryFontStyle,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 4),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 5),
                        child: CircleAvatar(
                          backgroundColor: AppTheme.colors.primary,
                          foregroundColor: Colors.white,
                          radius: 10,
                          child: Icon(
                            Icons.person,
                            size: 14,
                          ),
                        ),
                      ),
                      Text(
                        "${widget.username}",
                        style: AppTheme.style.primaryFontStyle,
                      ),
                    ],
                  ),
                )
              ],
            ),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 4),
                  child: Text(
                    getPriceComputed(),
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.colors.primary),
                  ),
                ),
                Text(
                  ExtensionServices.convertTimestampToDate(
                      widget.post['createdAt']),
                  // widget.post['createdAt'],
                  // 'asdsad',
                  style: AppTheme.style.secondaryFontStyle,
                ),
              ],
            )),
      ),
      onTap: () async {
        var post = await PostServices.getPostByPostId(widget.post['_id']);
        // Navigator.pop(context);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => PostScreen(post: post)));
      },
    );
  }

  getPriceComputed() {
    if (widget.post['price'] == 0) {
      return 'Free';
    }
    return "${widget.post['price']} Baht";
  }

  getAddressComputed() {
    if (widget.post['address'] != null) {
      return "${widget.post['address']['district']} ${widget.post['address']['province']}, ${widget.post['address']['country']}";
    }
    return "";
  }
}
