import 'package:flutter/material.dart';
import 'package:hello_world/page_one.dart';
import 'package:hello_world/page_two.dart';
import './page1.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Startup Name Generator',
      initialRoute: '/',
      theme: new ThemeData(
        primaryColor: Colors.blue,
      ),
      // routes: {
      //   '/':(context)=>RandomWords(),
      //   'one_page':(context)=>DemoOne(title: ModalRoute.of(context).settings.arguments),
      //   'one_tip_page':(context)=>DemoOneTipRoute(text:ModalRoute.of(context).settings.arguments),
      // },
      onGenerateRoute: (RouteSettings setting) {
        String routeName = setting.name;
        print('route:$routeName');
        WidgetBuilder builder;
        switch (routeName) {
          case '/':
            builder = (BuildContext context) => RandomWords();
            break;
          case 'one_page':
            builder =
                (BuildContext context) => DemoOne(title: setting.arguments);
            break;
            case 'two_page':
            builder=(context)=>DemoTwo();
            break;
          case 'one_tip_page':
            builder = (BuildContext context) =>
                DemoOneTipRoute(text: setting.arguments);
            break;
          default:
            builder = (BuildContext context) => RandomWords();
        }
        return MaterialPageRoute(builder: builder, settings: setting);
      },
      //home: new RandomWords(),
    );
  }
}
