import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_integrated/layouts/default_layout.dart';

import 'package:pet_integrated/screens/chat/chat_screen.dart';
import 'package:pet_integrated/screens/auth/login_screen.dart';
import 'package:pet_integrated/screens/splash_screen.dart';
import 'package:pet_integrated/utils/theme.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:bot_toast/bot_toast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
        title: 'Pet Integrated',
        debugShowCheckedModeBanner: false,
        builder: BotToastInit(),
        navigatorObservers: [BotToastNavigatorObserver()],
        theme: ThemeData(
            primaryColor: AppTheme.colors.primary,
            textTheme: GoogleFonts.ubuntuTextTheme(Theme.of(context).textTheme),
            scaffoldBackgroundColor: Color.fromARGB(255, 235, 235, 235),
            colorScheme: ColorScheme.fromSwatch()
                .copyWith(primary: AppTheme.colors.primary),
            appBarTheme: AppBarTheme(foregroundColor: AppTheme.colors.primary)),
        home: SplashScreen());
  }
}
