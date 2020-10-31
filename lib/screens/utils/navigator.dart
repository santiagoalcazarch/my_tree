
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future navigateTo( Widget nextScreen, BuildContext context ){
  return Navigator.of(context).push(
    CupertinoPageRoute(
      builder: (context) => nextScreen
    )
  );
}