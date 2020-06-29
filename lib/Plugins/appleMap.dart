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
  static const platform = const MethodChannel('ios.flutter.plugin.battery');
  String _batteryLevel = 'Unknown battery level.';

  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  Widget getPlatformCustomView(){
      if (defaultTargetPlatform == TargetPlatform.iOS){
        return UiKitView(
          viewType: "FPluginViewRedFactory_registerId",
          creationParams:{"lat":20.000,"long":120.0},
          creationParamsCodec: const StandardMessageCodec(),
        );
      }
      else {
          return Text("Not supported");
      }
  }

  Widget getDot(){
    return Container(
      width:100,
      height:100,
      decoration:BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.red
        )
    );
  }

@override
Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('简单接入地图'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height:40,
              color: Colors.green,
              child:Center(
                child:Text("当前位置")
              )
            ),
            Expanded(child: 
              Stack(
                alignment:Alignment.center,
                children:[
                  getPlatformCustomView(),
                  Container(
                    width:200,
                    height:200,
                    color:Colors.grey
                  ),
                  getDot(),
                  Icon(Icons.location_on)
                ]
              )
            )
          ],
        ),
      ),
    );
  }
}
