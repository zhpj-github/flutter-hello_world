import 'package:flutter/material.dart';

class DemoOneRoute extends StatefulWidget {
  @override
  _DemoOneRouteState createState() => new _DemoOneRouteState();
}

class _DemoOneRouteState extends State<DemoOneRoute> {
  TextEditingController _unameController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: new Text('新页面'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        child: Form(
          autovalidate: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                autofocus: true,
                controller: _unameController,
                decoration: InputDecoration(
                  labelText: '用户名',
                  hintText: '用户名或邮箱',
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (v) {
                  return v.trim().length > 0 ? null : '用户名不能为空';
                },
              ),
              TextFormField(
                controller: _pwdController,
                decoration: InputDecoration(
                  labelText: '密码',
                  hintText: '请输入密码',
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
                validator: (v) {
                  return v.trim().length > 5 ? null : '密码不能少于6位';
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 28.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Builder(builder: (context) {
                        return RaisedButton(
                          padding: EdgeInsets.all(15.0),
                          child: Text('登录'),
                          color: Theme.of(context).primaryColor,
                          textColor: Colors.white,
                          onPressed: () {
                            if (Form.of(context).validate()) {}
                          },
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DemoOneTipRoute extends StatelessWidget {
  DemoOneTipRoute({Key key, this.text}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: new Text('提示'),
      ),
      body: Padding(
        padding: EdgeInsets.all(18.0),
        child: Center(
          child: new Column(
            children: [
              new Text(text),
              new RaisedButton(
                onPressed: () => {
                  Navigator.pop(context, '我是返回值'),
                },
                child: Text('返回'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DemoOne extends StatefulWidget {
  DemoOne({Key key, this.title: 'page title'}) : super(key: key);
  final String title;
  @override
  _DemoOneState createState() => new _DemoOneState();
}

class _DemoOneState extends State<DemoOne> {
  int _count = 0;
  void _counter() {
    setState(() {
      _count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text('点击+按钮数字加1'),
            new Text(
              '$_count',
              style: Theme.of(context).textTheme.display1,
            ),
            new FlatButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return new DemoOneRoute();
                }));
              },
              child: new Text('跳转到新页面'),
              textColor: Colors.blue,
            ),
            new RaisedButton(
              onPressed: () async {
                // var result = await Navigator.push(context, MaterialPageRoute(builder: (context){
                //   return new DemoOneTipRoute(text:'传过来的参数在此');
                // }));
                var result = await Navigator.of(context)
                    .pushNamed('one_tip_page', arguments: '此处为传入参数');
                print('返回值：$result');
              },
              child: new Text('带参数跳转'),
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.add),
        tooltip: '点击后加1',
        onPressed: _counter,
      ),
    );
  }
}
