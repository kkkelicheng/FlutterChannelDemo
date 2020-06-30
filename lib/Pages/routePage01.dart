import 'package:first_demo/Pages/routePage02.dart';
import 'package:flutter/material.dart';

class RoutePage01 extends StatefulWidget {
  @override
  _RoutePage01State createState() => _RoutePage01State();
}

class _RoutePage01State extends State<RoutePage01> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Page 01")
      ),
      body: Container(
        child: Center(
          child:InkWell(
            child: Text("push to page 02"),
            onTap: (){
                var route = MaterialPageRoute(builder:(ctx) => RoutePage02());
                Navigator.of(context).push(route);
            },
          )
        ),
      ),
    );
  }
}