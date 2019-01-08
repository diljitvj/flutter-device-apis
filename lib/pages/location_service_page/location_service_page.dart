import 'package:flutter/material.dart';

class LocationServicePage extends StatefulWidget {
  @override
  LocationServicePageState createState() => new LocationServicePageState();
}

class LocationServicePageState extends State<LocationServicePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: Column(
          children: <Widget>[
            new Text(
              'Location Service',
              style: new TextStyle(fontSize: 20),
            )
          ],
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
      ),
    );
  }
}
