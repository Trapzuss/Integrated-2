import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pet_integrated/common/empty_widget.dart';
import 'package:pet_integrated/screens/auth/login_screen.dart';
import 'package:pet_integrated/screens/chat/chat_list_screen.dart';
import 'package:pet_integrated/screens/chat/chat_screen.dart';
import 'package:pet_integrated/screens/chat/clone_chat_list_screen.dart';
import 'package:pet_integrated/screens/home_screen.dart';
import 'package:pet_integrated/screens/profile/profile_edit_screen.dart';
import 'package:pet_integrated/screens/search_screen.dart';
import 'package:pet_integrated/services/authentication.dart';
import 'package:pet_integrated/services/posts.dart';
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
  bool _refresh = false;
  bool _login = false;
  String _searchValue = '';
  final _BtmNvgtItems = <BottomNavigationBarItem>[
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: const Icon(Icons.chat),
      label: 'Chat',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Profile',
    ),
  ];

  @override
  void initState() {
    _checkAuthenState();
    _isSearching = false;
    pageController = PageController();

    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    // _controllerSearch.dispose();
    super.dispose();
  }

  _checkAuthenState() async {
    var auth = await AuthenticationServices.checkAuthenState();
    // print(auth);
    setState(() {
      _login = auth;
    });
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

  Future _refreshProfile() async {
    await AuthenticationServices.getProfile();
    setState(() {
      _refresh = true;
      Future.delayed(const Duration(milliseconds: 3000));
      _refresh = false;
    });
    // print('refresh profile');
  }

  _searchKeyword(context, value) async {
    setState(() {
      _searchValue = value;
    });
    // var response = await PostServices.getPostsByKeyword(_searchValue);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SearchScreen(keyword: _searchValue)));
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
          physics: const NeverScrollableScrollPhysics(),
          children: [
            const HomeScreen(),
            const ChatListScreen(),
            !_refresh ? ProfileScreen() : const LoadingWidget()
          ],
          controller: pageController,
        ),
        bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              // color: Colors.white,
              color: Color(0xFF9FBC60),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: const Radius.circular(30.0),
              ),
              // boxShadow: [
              //   BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
              // ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              child: BottomNavigationBar(
                unselectedItemColor: AppTheme.colors.notWhite.withOpacity(0.6),
                selectedItemColor: Colors.white,
                elevation: 0,
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
                        hintStyle: const TextStyle(fontSize: 10, height: 2),
                        hintText: '"What your interesting?"',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        contentPadding:
                            const EdgeInsets.only(left: 10, right: 10),
                        suffixIcon: const Icon(Icons.search),
                        filled: true,
                        fillColor: AppTheme.colors.primary),
                    onFieldSubmitted: (value) {
                      _searchKeyword(context, value);
                    },
                  ),
                )
              : Container(),
          Container(
              child: Ink(
            width: 30,
            height: 30,
            child: InkWell(
                customBorder: const CircleBorder(),
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
            margin: const EdgeInsets.only(left: 4),
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
                  margin: const EdgeInsets.only(left: 4),
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: AppTheme.colors.primary,
                    child: const Icon(
                      Icons.person,
                      size: 18,
                      color: Colors.white,
                    ),
                  )),
            ],
          ),
          _login
              ? SizedBox(
                  height: 30,
                  width: 30,
                  child: IconButton(
                    color: Colors.white,
                    splashRadius: 15,
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.red,
                    ),
                    onPressed: () async {
                      AuthenticationServices.logout(context);
                    },
                  ),
                )
              : SizedBox(
                  height: 30,
                  width: 30,
                  child: IconButton(
                    color: Colors.white,
                    splashRadius: 15,
                    icon: Icon(
                      Icons.login,
                      color: AppTheme.colors.primary,
                    ),
                    onPressed: () async {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                    },
                  ),
                ),
        ],
      );
    }
    return Text(_appBarTitle, style: TextStyle(color: AppTheme.colors.primary));
  }
}
