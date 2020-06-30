import 'package:flutter/material.dart';

import 'routePage03.dart';

class RoutePage02 extends StatefulWidget {
  @override
  _RoutePage02State createState() => _RoutePage02State();
}

class _RoutePage02State extends State<RoutePage02> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Page 02")
      ),
      body: Container(
        child: Center(
          child:InkWell(
            child: Text("push to page 03"),
            onTap: (){
                var route = MaterialPageRoute(builder:(ctx) => RoutePage03());
                Navigator.of(context).push(route);
            },
          )
        ),
      ),
    );
  }
}