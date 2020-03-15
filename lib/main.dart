import 'package:cnncq/pages/home.dart';
import 'package:flutter/material.dart';
import './pages/boot.dart';
import './pages/login.dart';
import './pages/home.dart';

void main(){
  runApp(
      new MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.blue
        ),
        routes: <String, WidgetBuilder> {
          '/': (BuildContext context) => new BootPage(),
          '/login' : (BuildContext context) => new LoginPage(),
          '/home' : (BuildContext context) => new HomePage(),
        },
      )
  );
}
