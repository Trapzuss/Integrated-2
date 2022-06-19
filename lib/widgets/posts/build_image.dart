import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pet_integrated/common/empty_widget.dart';
import 'package:pet_integrated/screens/posts/generate_post_screen.dart';
import 'package:pet_integrated/screens/posts/post_screen.dart';
import 'package:pet_integrated/services/posts.dart';
import 'package:pet_integrated/utils/theme.dart';

class BuildImage extends StatelessWidget {
  var post;
  var user;
  var IconList = {
    "Edit": {
      "icon": Icon(
        Icons.mode_edit_outline_outlined,
        color: Colors.white,
      )
    },
    "Delete": {
      "icon": Icon(
        Icons.delete_outline,
        color: Colors.white,
      )
    }
  };
  bool isOwner;
  BuildImage(
      {Key? key, required this.post, required this.user, required this.isOwner})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50)),
              color: Colors.white),
          width: MediaQuery.of(context).size.width,
          child: ClipRRect(
            child: post?['images']?[0].toString() != null
                ? Image.network(post['images'][0].toString(), fit: BoxFit.cover)
                : EmptyImage(),
            // child: Image(image: AssetImage('assets/images/Dog-paw-rafiki.png')),
          ),
        ),
        Positioned(
          top: 10,
          left: 10,
          child: Opacity(
            opacity: 0.8,
            child: CircleAvatar(
              backgroundColor: AppTheme.colors.darkFontColor,
              child: BackButton(
                color: AppTheme.colors.notWhite,
              ),
            ),
          ),
        ),
        isOwner
            ? Positioned(
                top: 10,
                right: 10,
                child: Opacity(
                  opacity: 0.8,
                  child: PopupMenuButton<String>(
                    onSelected: (String value) async {
                      if (value == 'Edit') {
                        bool? _refresh = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GeneratePostScreen(
                                    action: 'edit', post: post)));
                        // TODO refresh
                        // print('buildimage');
                        // print(_refresh);
                        if (_refresh != null && _refresh) {
                          Navigator.pop(context, true);
                        }
                      } else if (value == 'Delete') {
                        await PostServices.deletePost(context, post['_id']);
                      }
                    },
                    itemBuilder: (BuildContext context) {
                      return {'Edit', 'Delete'}.map((String choice) {
                        return PopupMenuItem<String>(
                          value: choice,
                          child: Row(
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: AppTheme.colors.primary),
                                  // color: Colors.black,
                                  child: IconList[choice]!['icon'] as Widget),
                              Container(
                                  margin: EdgeInsets.only(left: 4),
                                  child: Text(choice))
                            ],
                          ),
                        );
                      }).toList();
                    },
                  ),
                  // CircleAvatar(
                  //   backgroundColor: AppTheme.colors.darkFontColor,
                  //   child: IconButton(
                  //       onPressed: () {
                  //         Navigator.push(
                  //             context,
                  //             MaterialPageRoute(
                  //                 builder: (context) => GeneratePostScreen(
                  //                     action: 'edit', post: post)));
                  //       },
                  //       icon: Icon(
                  //         Icons.edit,
                  //         color: Colors.amber,
                  //       )),
                  // ),
                ),
              )
            : Container(),
      ],
    );
  }
}
