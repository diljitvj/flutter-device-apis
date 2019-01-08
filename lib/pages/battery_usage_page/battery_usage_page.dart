// Import package
import 'package:flutter/material.dart';
import 'package:battery/battery.dart';
import 'dart:async';

// Instantiate it

// Access current battery level

class BatteryUsagePage extends StatefulWidget {
  @override
  BatteryUsagePageState createState() => new BatteryUsagePageState();
}

class BatteryUsagePageState extends State<BatteryUsagePage> {
  Battery _battery = Battery();

  var _batteryState;
  var _batteryLevel;
  StreamSubscription<BatteryState> _batteryStateSubscription;

  @override
  void initState() {
    super.initState();
    _batteryStateSubscription =
        _battery.onBatteryStateChanged.listen((BatteryState state) {
      setState(() {
        print(state.toString());
        if (state.toString() == "BatteryState.charging") {
          _batteryState = "Charging";
        } else {
          _batteryState = "Not Charging";
        }
      });
    });

    _battery.batteryLevel.asStream().listen((batterLevel) {
      setState(() {
        _batteryLevel = batterLevel;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: Column(
          children: <Widget>[
            new Icon(
              Icons.battery_alert,
              size: 50,
            ),
            new Text(
              '$_batteryState',
              style: new TextStyle(fontSize: 20),
            ),
            new Text(
              '$_batteryLevel%',
              style: new TextStyle(fontSize: 20),
            )
          ],
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (_batteryStateSubscription != null) {
      _batteryStateSubscription.cancel();
    }
  }
}
