import 'package:flutter/material.dart';
import 'package:pet_integrated/models/message.dart';
import 'package:pet_integrated/utils/theme.dart';

class DetailContactInfo extends StatelessWidget {
  const DetailContactInfo({Key? key}) : super(key: key);
  // const DetailContactInfo({Key? key, required this.message}) : super(key: key);
  // final MessageModel message;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
              onPressed: () {},
              child: Text(
                'Rukia',
                style: TextStyle(
                    fontSize: 24, color: AppTheme.colors.secondaryFontColor),
              ))
        ],
        // children: [Text('${message.name}')],
      ),
    );
  }
}
