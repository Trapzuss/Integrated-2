import 'package:flutter/material.dart';
import 'package:pet_integrated/screens/chat/chat_list_screen.dart';
import 'package:pet_integrated/screens/chat/chat_screen.dart';
import 'package:pet_integrated/screens/home_screen.dart';
import 'package:pet_integrated/screens/profile/profile_edit_screen.dart';
import 'package:pet_integrated/utils/theme.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

import '../screens/profile/profile_screen.dart';

class DefaultLayout extends StatefulWidget {
  const DefaultLayout({Key? key}) : super(key: key);

  @override
  State<DefaultLayout> createState() => _DefaultLayoutState();
}

class _DefaultLayoutState extends State<DefaultLayout> {
  late PageController pageController;
  int _state = 0;
  String _appBarTitle = 'AdoptHome';
  bool _isSearching = false;
  String _searchValue = '';
  final _BtmNvgtItems = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.chat),
      label: 'Chat',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Profile',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _isSearching = false;
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
    // _controllerSearch.dispose();
  }

  _onNavigationTapped(int index) {
    setState(() {
      var title = {
        0: 'AdoptHome',
        1: 'Chat',
        2: 'Profile',
      } as dynamic;
      _appBarTitle = title[index];
      _state = index;
    });
    // print(_state);
    pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: AppTheme.colors.notWhite,
          elevation: 0,
          title: AppbarComputed(context),
        ),
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          children: [HomeScreen(), ChatListScreen(), ProfileScreen()],
          controller: pageController,
        ),
        bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              // boxShadow: [
              //   BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
              // ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              child: BottomNavigationBar(
                items: _BtmNvgtItems,
                currentIndex: _state,
                onTap: _onNavigationTapped,
              ),
            )));
  }

  Widget AppbarComputed(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    if (_state == 0) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          !_isSearching
              ? Text(_appBarTitle,
                  style: TextStyle(color: AppTheme.colors.primary))
              : Container(),
          _isSearching
              ? Container(
                  width: width - 80,
                  height: 35,
                  child: TextFormField(
                    maxLines: 1,
                    decoration: InputDecoration(
                        hintStyle: TextStyle(fontSize: 10, height: 2),
                        hintText: '"What your interesting?"',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        contentPadding: EdgeInsets.only(left: 10, right: 10),
                        suffixIcon: Icon(Icons.search),
                        filled: true,
                        fillColor: AppTheme.colors.primary),
                    onFieldSubmitted: (value) {
                      setState(() {
                        _searchValue = value;
                      });
                    },
                  ),
                )
              : Container(),
          Container(
              child: Ink(
            width: 30,
            height: 30,
            child: InkWell(
                customBorder: CircleBorder(),
                onTap: () {
                  setState(() {
                    // print(_isSearching);
                    _isSearching = !_isSearching;
                  });
                },
                child: Icon(
                  !_isSearching ? Icons.search : Icons.close,
                  color: AppTheme.colors.primary,
                )),
          ))
        ],
      );
    } else if (_state == 1) {
      return Row(
        children: [
          Text(_appBarTitle, style: TextStyle(color: AppTheme.colors.primary)),
          Container(
            margin: EdgeInsets.only(left: 4),
            child: Icon(
              Icons.chat,
              color: AppTheme.colors.primary,
            ),
          ),
        ],
      );
    } else if (_state == 2) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(_appBarTitle,
                  style: TextStyle(color: AppTheme.colors.primary)),
              Container(
                margin: EdgeInsets.only(left: 4),
                child: Icon(
                  Icons.person_pin,
                  color: AppTheme.colors.primary,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
            width: 30,
            child: IconButton(
              padding: EdgeInsets.all(0),
              splashRadius: 15,
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfileEditScreen()));
              },
            ),
          ),
        ],
      );
    }
    return Text(_appBarTitle, style: TextStyle(color: AppTheme.colors.primary));
  }
}
