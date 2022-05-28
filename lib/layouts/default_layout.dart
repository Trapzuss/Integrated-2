import 'package:flutter/material.dart';
import 'package:pet_integrated/screens/chat_screen.dart';
import 'package:pet_integrated/utils/theme.dart';

class DefaultLayout extends StatefulWidget {
  const DefaultLayout({Key? key}) : super(key: key);

  @override
  State<DefaultLayout> createState() => _DefaultLayoutState();
}

class _DefaultLayoutState extends State<DefaultLayout> {
  late PageController pageController;
  int _state = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
    // _controllerSearch.dispose();
  }

  void onPageChanged(int index) {
    setState(() {
      _state = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Integrated-2',
              style: TextStyle(color: AppTheme.colors.secondaryFontColor)),
        ),
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          children: [],
          controller: pageController,
          onPageChanged: onPageChanged,
        ));
  }
}
