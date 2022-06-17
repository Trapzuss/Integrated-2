import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_integrated/layouts/default_layout.dart';
import 'package:pet_integrated/services/authentication.dart';

import 'package:pet_integrated/screens/chat/chat_screen.dart';
import 'package:pet_integrated/screens/auth/register_screen.dart';
import 'package:pet_integrated/screens/splash_screen.dart';
import 'package:pet_integrated/utils/theme.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
<<<<<<< Updated upstream

=======
  // await Firebase.initializeApp();
>>>>>>> Stashed changes
  var dio = Dio();
  var cookieJar = CookieJar();
  dio.interceptors.add(CookieManager(cookieJar));
  await dotenv.load(fileName: ".env");
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var access_token = prefs.get('access_token');
  if (access_token != null) {
    await AuthenticationServices.getProfile();
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Future _initFirebase() async {
    try {
      await Firebase.initializeApp();
    } catch (e) {
      print(e);
      return e;
    }
  }

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
            canvasColor: Colors.transparent,
            primaryColor: AppTheme.colors.primary,
            textTheme: GoogleFonts.ubuntuTextTheme(Theme.of(context).textTheme),
            scaffoldBackgroundColor: Color.fromARGB(255, 235, 235, 235),
            colorScheme: ColorScheme.fromSwatch()
                .copyWith(primary: AppTheme.colors.primary),
            appBarTheme: AppBarTheme(foregroundColor: AppTheme.colors.primary)),
<<<<<<< Updated upstream
        home: FutureBuilder(
            future: _initFirebase(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              if (snapshot.connectionState == ConnectionState.done) {
                return SplashScreen();
              }
              return Center(
                  child: CircularProgressIndicator(
                color: AppTheme.colors.primary,
              ));
            }));
=======
        // home: SplashScreen()
         home: DefaultLayout()
        );
>>>>>>> Stashed changes
  }
}
