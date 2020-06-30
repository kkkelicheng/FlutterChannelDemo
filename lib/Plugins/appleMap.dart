import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';

class SecondRoute extends StatefulWidget {
  SecondRoute({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _SecondRouteState createState() => _SecondRouteState();
}

class _SecondRouteState extends State<SecondRoute> {
  static const platform = const MethodChannel('ios.flutter.plugin.map');
  String locationDesc;
  Widget mapView;

  initState() {
    super.initState();
    getPlatformCustomView();
    platform.setMethodCallHandler(_handleNativeMethodCall);
  }

  Future<dynamic> _handleNativeMethodCall(MethodCall call) async {
    var place = call.arguments["locationDesc"];
    print("place is $place");
    print(
        "...setMethodCallHandler ${call.method} argument:${call.arguments.toString()}");
    setState(() {
      locationDesc = place;
    });
  }

  Future<dynamic> _handleNativeMethodCall2(MethodCall call) async {
    if (call.method == "locationDescUpdate") {
      //这个方法明显出错了，居然没报错什么的。。。。。。。。。。。。。。。。。。
      //坑了好几个小时
      var args = call.arguments as Map<String,dynamic>;
      print("args ${args["locationDesc"]}");
      var place = call.arguments["locationDesc"];
      print("place is $place");
      print(
          "...setMethodCallHandler ${call.method} argument:${call.arguments.toString()}");
      setState(() {
        locationDesc = place;
      });
    }
  }

  Widget getPlatformCustomView() {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      mapView = UiKitView(
        viewType: "FPluginViewRedFactory_registerId",
        creationParams: {"lat": 20.000, "long": 120.0},
        creationParamsCodec: const StandardMessageCodec(),
      );
      return mapView;
    } else {
      mapView = Text("Not supported");
      return mapView;
    }
  }

  Widget getDot() {
    return Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: Colors.red));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('苹果地图'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                setState(() {
                  locationDesc = "loding...";
                });
              })
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                height: 40,
                color: Colors.green,
                child: Center(child: Text("$locationDesc"))),
            Expanded(
                child: Stack(alignment: Alignment.center, children: [
              mapView,
              Container(width: 200, height: 200, color: Colors.grey),
              getDot(),
              Icon(Icons.location_on)
            ]))
          ],
        ),
      ),
    );
  }
}
