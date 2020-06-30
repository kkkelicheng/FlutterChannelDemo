import 'package:flutter/material.dart';

class RoutePage03 extends StatefulWidget {
  @override
  _RoutePage03State createState() => _RoutePage03State();
}

class _RoutePage03State extends State<RoutePage03> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Page 03")
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