import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'dart:async';
import 'package:flutter/services.dart';

class NetworkStatusPage extends StatefulWidget {
  @override
  NetworkStatusPageState createState() => new NetworkStatusPageState();
}

class NetworkStatusPageState extends State<NetworkStatusPage> {
  Connectivity _connectivity = Connectivity();
  String _connectionStatus = 'Unknown';
  ConnectivityResult connectivityResult;
  Icon _connectionIcon = new Icon(Icons.perm_scan_wifi);

  StreamSubscription<ConnectivityResult> _connectionStateSubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();

    _connectionStateSubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult connectionStatus) {
      // Got a new connectivity status!
      print(connectionStatus);
      _setConnectivityState(connectionStatus.toString());
    });
  }

  void _setConnectivityState(connectionStatus) {
    setState(() {
      print(connectionStatus);
      if (connectionStatus == "ConnectivityResult.mobile") {
        _connectionStatus = "Mobile";
        _connectionIcon = new Icon(
          Icons.network_cell,
          size: 50,
        );

        // I am connected to a mobile network.
      } else if (connectionStatus == "ConnectivityResult.wifi") {
        _connectionStatus = "WiFi";
        _connectionIcon = new Icon(
          Icons.wifi,
          size: 50,
        );
        // I am connected to a wifi network.
      } else if (connectionStatus == "ConnectivityResult.none") {
        _connectionStatus = "No Connection";
        _connectionIcon = new Icon(
          Icons.signal_cellular_null,
          size: 50,
        );
        // I am connected to a wifi network.
      }
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    String connectionStatus;

    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      connectionStatus = (await _connectivity.checkConnectivity()).toString();
      print(connectionStatus);
    } on PlatformException catch (e) {
      print(e.toString());
      connectionStatus = 'Failed to get connectivity.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return;
    }

    _setConnectivityState(connectionStatus);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: Column(
          children: <Widget>[
            _connectionIcon,
            new Text(
              '$_connectionStatus',
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
    if (_connectionStateSubscription != null) {
      _connectionStateSubscription.cancel();
    }
  }
}
