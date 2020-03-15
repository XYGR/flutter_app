import 'package:flutter/material.dart';

class HomePage extends StatelessWidget{
  HomePage({Key key}):super(key:key);
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("首页"),
        centerTitle: true,
      ),
      body: Center(
        child: Text("首页"),
      ),
    );
  }
}