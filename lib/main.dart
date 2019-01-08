import 'package:flutter/material.dart';
import './pages/battery_usage_page/battery_usage_page.dart';
import './pages/network_status_page/network_status_page.dart';
import './pages/qr_scan_page/qr_scan_page.dart';
import './pages/location_service_page/location_service_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
          fontFamily: 'FiraSans',
          primaryColor: Colors.black,
          secondaryHeaderColor: Colors.black),
      home: NavigationDrawer(),
    );
  }
}

class NavigationDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new NavigationDrawerState();
  }
}

class NavigationDrawerState extends State<NavigationDrawer> {
  int _selectedIndex = 0;

  get drawerItems => [
        new BatteryUsagePage(),
        new NetworkStatusPage(),
        new QrScanPage(),
        new LocationServicePage()
      ];

  get drawerText => ["Battery", "Network", "QR Scan", "Location Service"];
  get drawerIcons => [
        new Icon(
          Icons.battery_std,
          size: 35,
          color: Colors.green,
        ),
        new Icon(
          Icons.network_wifi,
          size: 35,
          color: Colors.indigo,
        ),
        new Icon(Icons.crop_free),
        new Icon(Icons.location_on)
      ];

  _getDrawerItemScreen(int pos) {
    return drawerItems[_selectedIndex];
  }

  _onSelectItem(int index) {
    setState(() {
      _selectedIndex = index;
      _getDrawerItemScreen(_selectedIndex);
    });
    Navigator.of(context).pop(); // close the drawer
  }

  @override
  Widget build(BuildContext context) {
    var drawerOptions = [];
    for (var i = 0; i < drawerItems.length; i++) {
      drawerOptions.add(new ListTile(
        leading: drawerIcons[i],
        title: new Text(
          drawerText[i],
          style: new TextStyle(fontSize: 25.0),
        ),
        selected: i == _selectedIndex,
        onTap: () => _onSelectItem(i),
      ));
    }

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Filius"),
        backgroundColor: Colors.black,
      ),
      drawer: new Drawer(
        child: new Column(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text(
                "Filius",
                style:
                    new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
              ),
              accountEmail: new Text(
                "Pikkol Fulfilment",
                style:
                    new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
              ),
              decoration: new BoxDecoration(color: Colors.black),
            ),
            new Column(
              children: <Widget>[
                drawerOptions[0],
                new Divider(
                  color: Colors.black,
                ),
                drawerOptions[1],
                new Divider(
                  color: Colors.black,
                ),
                drawerOptions[2],
                new Divider(
                  color: Colors.black,
                ),
                drawerOptions[3],
                new Divider(
                  color: Colors.black,
                ),
              ],
            )
          ],
        ),
      ),
      body: _getDrawerItemScreen(_selectedIndex),
    );
  }
}
