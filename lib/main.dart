import 'package:dbtest/places.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'image_test.dart';
import 'models/login.dart';
void main()=>  runApp( const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: Login(),
    );
  }
}


