import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pet_integrated/utils/theme.dart';

class ProfileActionCard extends StatelessWidget {
  const ProfileActionCard(
      {Key? key,
      required this.title,
      required this.icon,
      required this.color,
      required this.action})
      : super(key: key);
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback action;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.46,
      height: height * 0.15,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: action,
        child: Card(
          color: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Icon(
                  icon,
                  color: AppTheme.colors.notWhite,
                  size: 42,
                ),
              ),
              Text(
                title,
                style: TextStyle(
                    overflow: TextOverflow.fade,
                    color: Colors.white,
                    fontSize: 12),
              )
            ],
          ),
        ),
      ),
    );
  }
}
