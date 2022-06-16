import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pet_integrated/utils/theme.dart';

class BuildDetails extends StatelessWidget {
  var post;
  BuildDetails({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(right: 10, left: 10, top: 20, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: width - 20,
            margin: EdgeInsets.only(bottom: 4),
            child: Text(
              'Detail',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.colors.infoFontColor),
            ),
          ),
          Text(
            post['description'],
            textAlign: TextAlign.start,
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
