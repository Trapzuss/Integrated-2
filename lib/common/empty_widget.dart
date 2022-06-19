import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:pet_integrated/utils/theme.dart';

class EmptyImage extends StatelessWidget {
  const EmptyImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.network(
        AppTheme.src.empty,
        alignment: Alignment.center,
        height: 200,
      ),
    );
  }
}

class EmptyPostsTypeError extends StatelessWidget {
  String error;
  EmptyPostsTypeError({Key? key, required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Something went wrong! ${error}'),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              'assets/images/Catastronaut-cuate.png',
              alignment: Alignment.center,
              height: 200,
            ),
          )
        ],
      ),
    );
  }
}

class EmptyPostsTypeSomethingWrong extends StatelessWidget {
  String? text = '';
  EmptyPostsTypeSomethingWrong({Key? key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var rng = Random();
    String path;
    if (rng.nextInt(100) > 49) {
      path = 'assets/images/Fishbowl.png';
    } else {
      path = 'assets/images/Catastronaut-cuate.png';
    }
    // print('$path');
    String msg = '';
    if (text != '') {
      msg = text!;
    } else {
      msg = "No post found. come back later.";
    }
    print(msg);
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        // Text('No data found here.'),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            path,
            alignment: Alignment.center,
            height: 200,
          ),
        ),
        Text('Oops!',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.colors.secondaryFontColor)),
        Container(
          margin: EdgeInsets.symmetric(vertical: 4),
          child: Text(msg,
              style: TextStyle(color: AppTheme.colors.secondaryFontColor)),
        ),
      ]),
    );
  }
}

class EmptyPostsTypeEmpty extends StatelessWidget {
  const EmptyPostsTypeEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var rng = Random();
    String path;
    if (rng.nextInt(100) > 49) {
      path = 'assets/images/Fishbowl.png';
    } else {
      path = 'assets/images/Catastronaut-cuate.png';
    }

    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        // Text('No data found here.'),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            path,
            alignment: Alignment.center,
            height: 200,
          ),
        ),
        Text('Oops!',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.colors.darkFontColor)),
        Container(
          margin: EdgeInsets.symmetric(vertical: 4),
          child: Text("No post found. Let's add a new post",
              style: TextStyle(color: AppTheme.colors.darkFontColor)),
        ),
        // gradientButton(
        //   text: 'New post',
        // )
      ]),
    );
  }
}

class EmptyCollection extends StatelessWidget {
  const EmptyCollection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var rng = Random();
    String path;
    if (rng.nextInt(100) > 49) {
      path = 'assets/images/Fishbowl.png';
    } else {
      path = 'assets/images/Catastronaut-cuate.png';
    }
    // print('$path');

    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        // Text('No data found here.'),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            path,
            alignment: Alignment.center,
            height: 200,
          ),
        ),
        Text('Oops!',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.colors.secondaryFontColor)),
        Container(
          margin: EdgeInsets.symmetric(vertical: 4),
          child: Center(
            child: Text(
                "Your don't have any collection.\n Create some then try it later.",
                style: TextStyle(color: AppTheme.colors.secondaryFontColor)),
          ),
        ),
        // gradientButton(
        //   text: 'Create Collection',
        // )
      ]),
    );
  }
}

class EmptyImageTypeCreatePost extends StatelessWidget {
  const EmptyImageTypeCreatePost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var rng = Random();
    String path;
    if (rng.nextInt(100) > 49) {
      path = 'assets/images/Fishbowl.png';
    } else {
      path = 'assets/images/Catastronaut-cuate.png';
    }

    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        // Text('No data found here.'),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            path,
            alignment: Alignment.center,
            height: 200,
          ),
        ),
      ]),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: AppTheme.colors.primary,
      ),
    );
  }
}
