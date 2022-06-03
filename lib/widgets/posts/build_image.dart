import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pet_integrated/utils/theme.dart';

class BuildImage extends StatelessWidget {
  const BuildImage({Key? key}) : super(key: key);

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
            child: Image(image: AssetImage('assets/images/Dog-paw-rafiki.png')),
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
        )
      ],
    );
  }
}
