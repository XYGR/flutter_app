import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cnncq/utils/HttpUtils.dart';

class BootPage extends StatelessWidget {
    BootPage({Key key}):super(key:key);
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: _Body(),
        );
    }
}

class _Body extends StatefulWidget{
    _Body({Key key}):super(key:key);

    @override
    _BodyState createState() => _BodyState();

}

class _BodyState extends State<_Body>{
    bool isFailed = false;
    @override
    void initState() {
        super.initState();
        print('initState');
        _boot();
    }

    void _boot() async {
        // 初始化SharedPreferences对象
        SharedPreferences prefs = await SharedPreferences.getInstance();
        // 从本地持久化中获取session数据
        String sessionID = prefs.getString('sessionID')??'';
        // 判断是否存在session
        if(sessionID.length < 1){
            Navigator.of(context).pushReplacementNamed('/login');
            return;
        }else{
            var res = await HttpUtils.get('/user/boot');
            print(res['error']?'login':'/home');
            Navigator.of(context).pushReplacementNamed(res['error']?'/login':'/home');
        }
//    var res = await HttpUtils.post('/user/check',{});
//    print('接口返回:$res');
//    if(res == null){
//      setState(() {
//        this.isFailed = true;
//      });
//    }else{
//      Navigator.of(context).pushReplacementNamed(res['status'] == 0?'/index':'/login');
//    }

    }



    @override
    Widget build(BuildContext context) {
        return Container(
            width: double.infinity,
            color: Colors.white,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                    InkWell(
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
                    Container(
                        margin: EdgeInsets.only(top: 80),
                        child: Text(isFailed?'连接服务器失败请重试!':'连接服务器...',style: TextStyle(color: isFailed?Colors.red:Color.fromRGBO(100, 100, 100,1)),),
                    )
                ],
            ),
        );
    }

}