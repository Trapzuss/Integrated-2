import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pet_integrated/utils/theme.dart';

class PostCard extends StatelessWidget {
  const PostCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Container(
          width: width / 2 - 20,
          child: Card(
            child: Container(
              padding: EdgeInsets.all(6),
              child: Column(
                children: [
                  Container(
                      margin: EdgeInsets.only(bottom: 6),
                      child: Image.network(
                        AppTheme.src.profileImage,
                        fit: BoxFit.cover,
                      )),
                  Container(
                    margin: EdgeInsets.only(bottom: 3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Doge',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.colors.infoFontColor),
                        ),
                        Text(
                          '134 Baht',
                          style: AppTheme.style.primaryFontStyle,
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
                            '4517 Klongthom, Bangkok',
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
                        height: 30,
                        margin: EdgeInsets.only(right: 4),
                        child: Chip(
                            label: Text(
                          'Male',
                          style: AppTheme.style.secondaryFontStyle,
                        )),
                      ),
                      Container(
                        height: 30,
                        child: Chip(
                            label: Text(
                          '1 Year',
                          style: AppTheme.style.secondaryFontStyle,
                        )),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/Dogpaw-pana.png'),
                            backgroundColor: Colors.white,
                          ),
                          Text(
                            "Pet's owner",
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
}
