import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qrcode_reader/qrcode_reader.dart';

class QrScanPage extends StatefulWidget {
  @override
  QrScanPageState createState() => new QrScanPageState();
}

class QrScanPageState extends State<QrScanPage> {
  Future<String> _barcodeString;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Column(
          children: <Widget>[
            new Padding(
                padding: const EdgeInsets.all(60.0),
                child: new FlatButton(
                    child: new Padding(
                        padding: EdgeInsets.all(20),
                        child: new Row(children: <Widget>[
                          new Icon(
                            Icons.camera,
                            color: Colors.white,
                          ),
                          new Padding(
                              padding: new EdgeInsets.only(left: 10),
                              child: new Text(
                                "Scan QR code",
                                style: new TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ))
                        ])),
                    color: Colors.black,
                    onPressed: () {
                      setState(() {
                        _barcodeString = new QRCodeReader()
                            .setAutoFocusIntervalInMs(200)
                            .setForceAutoFocus(true)
                            .setTorchEnabled(true)
                            .setHandlePermissions(true)
                            .setExecuteAfterPermissionGranted(true)
                            .scan();
                      });
                    })),
            new FutureBuilder<String>(
                future: _barcodeString,
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  return new Text(snapshot.data != null ? snapshot.data : '');
                })
          ],
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
      ),
    );
  }
}
