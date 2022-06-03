import 'package:flutter/material.dart';
import 'package:pet_integrated/layouts/default_layout.dart';
import 'package:pet_integrated/utils/theme.dart';

import 'home_screen.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _show = false;
  void _navigateToHome() async {
    await Future.delayed(Duration(milliseconds: 5000), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DefaultLayout()),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _show = true;
      });
    });
    Future.delayed(Duration(milliseconds: 4000), () {
      setState(() {
        _show = false;
      });
    });
    _navigateToHome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: AnimatedOpacity(
        opacity: _show ? 1 : 0,
        duration: Duration(milliseconds: 500),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.network(
                'https://assets7.lottiefiles.com/packages/lf20_syqnfe7c.json'),
            Text(
              'Pethome',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.colors.darkFontColor),
            ),
          ],
        ),
      )),
    );
  }
}
