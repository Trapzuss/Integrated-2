import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:pet_integrated/utils/theme.dart';

class ProfilePostsScreen extends StatefulWidget {
  const ProfilePostsScreen({Key? key}) : super(key: key);

  @override
  State<ProfilePostsScreen> createState() => _ProfilePostScreesnState();
}

class _ProfilePostScreesnState extends State<ProfilePostsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.colors.notWhite,
        elevation: 0,
      ),
    );
  }
}
