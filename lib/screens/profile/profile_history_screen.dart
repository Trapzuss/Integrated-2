import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pet_integrated/utils/theme.dart';

class ProfileHistoryScreen extends StatefulWidget {
  const ProfileHistoryScreen({Key? key}) : super(key: key);

  @override
  State<ProfileHistoryScreen> createState() => _ProfileHistoryScreenState();
}

class _ProfileHistoryScreenState extends State<ProfileHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.colors.notWhite,
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
            margin: EdgeInsets.only(right: 10, left: 10),
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) => ListTile(
                  // tileColor: Colors.white,
                  contentPadding: EdgeInsets.only(left: 0, right: 0),
                  minLeadingWidth: 60,
                  leading: ClipRRect(
                    child: Image.network(
                      'https://picsum.photos/200/300?random=${index}',
                      fit: BoxFit.cover,
                      width: 60,
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 4),
                        child: Text(
                          'Pet ${index}',
                          style: AppTheme.style.titleFontStyle,
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
                            Text(
                              '10600 Bangkok',
                              style: AppTheme.style.secondaryFontStyle,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 4),
                        child: Text(
                          'Confirm Adopt',
                          style: AppTheme.style.primaryFontStyle,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 4),
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 5),
                              child: CircleAvatar(
                                radius: 10,
                                child: Icon(
                                  Icons.person,
                                  size: 14,
                                ),
                              ),
                            ),
                            Text(
                              'hello ${index}',
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
                          '3000 Baht',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.colors.primary),
                        ),
                      ),
                      Text(
                        '6/10/2022',
                        style: AppTheme.style.secondaryFontStyle,
                      ),
                    ],
                  )),
            )),
      ),
    );
  }
}
