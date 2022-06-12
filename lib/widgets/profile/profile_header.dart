import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pet_integrated/screens/posts/generate_post_screen.dart';
import 'package:pet_integrated/screens/profile/profile_history_screen.dart';
import 'package:pet_integrated/screens/profile/profile_posts_screen.dart';
import 'package:pet_integrated/utils/theme.dart';
import 'package:pet_integrated/widgets/profile/profile_action_card.dart';

class ProfileHeader extends StatefulWidget {
  const ProfileHeader({Key? key}) : super(key: key);

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    child: Image.network(
                      AppTheme.src.profileImage,
                      fit: BoxFit.cover,
                      width: 128,
                      height: 128,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Firstname',
                      style: AppTheme.style.titleFontStyle,
                    ),
                    Text(
                      'Surename',
                      style: AppTheme.style.titleFontStyle,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 6),
                      child: Row(
                        children: [
                          Icon(
                            Icons.email,
                            color: AppTheme.colors.subInfoFontColor,
                            size: 18,
                          ),
                          Text(
                            'Email@mail.com',
                            style: AppTheme.style.secondaryFontStyle,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          Container(
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
                            builder: (context) => GeneratePostScreen()));
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
                ProfileActionCard(
                  title: 'History',
                  icon: Icons.history,
                  color: Color.fromARGB(255, 180, 199, 132),
                  action: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileHistoryScreen()));
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
