import 'package:flutter/material.dart';

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
            child: Text("回到首页"),
            onTap: (){
                Navigator.of(context).popUntil(ModalRoute.withName("/"));
            },
          )
        ),
      ),
    );
  }
}