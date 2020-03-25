import 'package:flutter/material.dart';
import 'package:cnncq/utils/HttpUtils.dart';
import 'package:shared_preferences/shared_preferences.dart';
class HomePage extends StatelessWidget{
  HomePage({Key key}):super(key:key);


  @override
  Widget build(BuildContext context) {
    void _boot() async {
      var res = await HttpUtils.get('/user/logout');
      // 初始化SharedPreferences对象
      SharedPreferences prefs = await SharedPreferences.getInstance();
      print('接口返回:$res');
      prefs.remove('sessionID');
      Navigator.of(context).pushReplacementNamed('/login');
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("首页"),
        centerTitle: true,
      ),
      body: Center(
        child: InkWell(
          onTap: _boot,
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50.0)),
                color: Color.fromRGBO(2,138,126,1),
                image: DecorationImage(
                  image: AssetImage('assets/images/logo.png'),
                )
            ),
          ),
        ),
      ),
    );
  }
}