import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pet_integrated/common/empty_widget.dart';
import 'package:pet_integrated/utils/theme.dart';
import 'package:pet_integrated/utils/utils.dart';

class PostCard extends StatelessWidget {
  var post;
  PostCard({Key? key, required this.post}) : super(key: key);

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
    return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(20),
        // ),
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
                        child: post?['images']?[0] == null
                            ? EmptyImage()
                            : Image.network(
                                post['images'][0].toString(),
                                fit: BoxFit.cover,
                              ),
                      )),
                  Container(
                    margin: EdgeInsets.only(bottom: 3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 3,
                          child: Container(
                            child: Text(
                              post['petName'],
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.colors.infoFontColor),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            post['price'] == 0
                                ? "Free"
                                : "${post['price'].toString()} Baht",
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
                            "${post['address']['district']} ${post['address']['province']}, ${post['address']['country']}",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                color: AppTheme.colors.subInfoFontColor),
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
                              sexIcons['${post['sex'].toString()}'] as Widget,
                              Text(
                                ExtensionServices.capitalize(
                                    post['sex'].toString()),
                                style: AppTheme.style.secondaryFontStyle,
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
                                color: AppTheme.colors.subInfoFontColor,
                                size: 16,
                              ),
                              Text(
                                getAgeComputed(),
                                style: AppTheme.style.secondaryFontStyle,
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
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 18,
                            backgroundImage:
                                AssetImage('assets/images/Dogpaw-pana.png'),
                            backgroundColor: Colors.white,
                          ),
                          Text(
                            post['user'][0]['firstName'].toString(),
                            style: AppTheme.style.primaryFontStyle,
                          )
                        ],
                      ),
                      Container(
                        width: 30,
                        child: ElevatedButton(
                            onPressed: () {},
                            child: Icon(
                              Icons.chat,
                              size: 16,
                            ),
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.all(0),
                                elevation: 0,
                                shape: CircleBorder())),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  getAgeComputed() {
    if ("${post?['age']?['year']}" == null ||
        "${post?['age']?['year']}" == "null") {
      return 'Unknown';
    }
    return "${post?['age']?['year'].toString()} yrs,${post?['age']?['month'].toString()} mo";
  }
}
