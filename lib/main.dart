import 'package:first_demo/Pages/routePage01.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'Plugins/battery.dart';
import 'Plugins/appleMap.dart';
import 'Pages/pages_headers.dart';
import 'Pages/routePage01.dart';


void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      ),
      home: Scaffold(
        appBar:AppBar(
          title:Text("Demo")
        ),
        body: Container(
          child: AppTestList(),
        ),
      )
    );
  }

}

class AppTestList extends StatelessWidget {
  final List<String> titles = ["获取电量","简单的接入地图","页面跳转"];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount:titles.length,
      separatorBuilder:(buildContext,index){
        return Divider();
      },
      itemBuilder: (buildContext,index){
        return ListTile(
          title:Text(titles[index]),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: (){
            _cellTaped(index,context);
          },
        );
      }
    );
  }
    
  _cellTaped(int index,BuildContext context){
    print(titles[index]);
    switch (index) {
      case 0:
        Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FirstRoute()),
            );
        break;
      case 1:
      Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SecondRoute()),
          );
      break;
      case 2:
      Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RoutePage01()),
          );
      break;
      default:
      break;
    }

  }
}
