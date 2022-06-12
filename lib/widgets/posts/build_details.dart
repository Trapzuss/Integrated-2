import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pet_integrated/utils/theme.dart';

class BuildDetails extends StatelessWidget {
  const BuildDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10, left: 10, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 4),
            child: Text(
              'Detail',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.colors.infoFontColor),
            ),
          ),
          Text(
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ',
            style: TextStyle(
                overflow: TextOverflow.fade,
                color: AppTheme.colors.subInfoFontColor,
                fontSize: 12),
          )
        ],
      ),
    );
  }
}
