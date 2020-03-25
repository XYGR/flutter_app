import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cnncq/utils/HttpUtils.dart';

class LoginPage extends StatelessWidget {

    LoginPage({Key key}):super(key:key);
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text("登 录"),
                centerTitle: true,
            ),
            body: _Body(),
        );
    }
}

class _Body extends StatefulWidget {
    _Body({Key key}):super(key:key);
    @override
    State<StatefulWidget> createState() {

        return _BodyState();
    }

}


class _BodyState extends State<_Body>{

    final _formKey = GlobalKey<FormState>();
    bool _isLoading = false;
    String _userNameVal = "";
    String _passwordVal = "";

    void _submit() async{
        if(_formKey.currentState.validate()){
            _formKey.currentState.save();
            print(_userNameVal);
            print(_passwordVal);
            this.setState((){
                _isLoading = true;
            });
            var res = await HttpUtils.post('/user/login',{"username": _userNameVal, "password": _passwordVal});
            print('res$res');
            this.setState((){
                _isLoading = false;
            });
            if(!res['error']){
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setString('sessionID', res["data"]);
                print("登录成功");
                Navigator.of(context).pushReplacementNamed('/home');
            }
        }
    }

    @override
    Widget build(BuildContext context) {

        return Stack(
            children: <Widget>[
                ListView(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    children: <Widget>[
                        Form(
                            key: _formKey,
                            child: Column(
                                children: <Widget>[
                                    TextFormField(
                                        decoration: InputDecoration(
                                            icon: Icon(Icons.account_circle),
                                            labelText: "用户名",
                                            hintText: "用户名"
                                        ),
                                        onSaved: (val){
                                            _userNameVal = val;
                                        },
                                    ),
                                    TextFormField(
                                        decoration: InputDecoration(
                                            icon: Icon(Icons.vpn_key),
                                            labelText: "密码",
                                            hintText: "密码"
                                        ),
                                        obscureText: true,
                                        onSaved: (val){
                                            _passwordVal = val;
                                        },
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(top:20),
                                        child: Row(
                                            children: <Widget>[
                                                Expanded(
                                                    child: RaisedButton(
                                                        padding: EdgeInsets.all(5),
                                                        child: Text("登录",style: TextStyle(color: Colors.white,letterSpacing: 10),),
                                                        color: Colors.blue,
                                                        onPressed: _submit,
                                                    ),
                                                )
                                            ],
                                        ),
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(top: 10),
                                        child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: <Widget>[
                                                Text("还没有账号?"),
                                                InkWell(
                                                    onTap: (){
                                                        Navigator.of(context).pushReplacementNamed('/register');
                                                    },
                                                    child: Container(
                                                        child: Text("去注册",style: TextStyle(color: Colors.blue,letterSpacing: 2),),
                                                        margin:EdgeInsets.only(left: 20)
                                                    ),
                                                )
                                            ],
                                        ),
                                    )
                                ],
                            ),
                        )
                    ],
                )
            ],
        );
    }
}
