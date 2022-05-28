import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_integrated/layouts/default_layout.dart';
import 'package:pet_integrated/screens/chat_screen.dart';
import 'package:pet_integrated/screens/login_screen.dart';
import 'package:pet_integrated/utils/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            textTheme: GoogleFonts.ubuntuTextTheme(Theme.of(context).textTheme),
            scaffoldBackgroundColor: Color.fromARGB(255, 235, 235, 235),
            colorScheme: ColorScheme.fromSwatch()
                .copyWith(primary: AppTheme.colors.primary),
            appBarTheme:
                AppBarTheme(foregroundColor: AppTheme.colors.primaryFontColor)),
        home: Center(
          // child: DefaultLayout(),
          child: ChatScreen(),
        ));
  }
}
