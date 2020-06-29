import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LearnDio extends StatefulWidget {
  @override
  _LearnDioState createState() => _LearnDioState();
}

class _LearnDioState extends State<LearnDio> {

@override
  void initState() {
    super.initState();
    _loaded();
  }

  void _loaded() async{

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Text("data")
      ),
    );
  }
}