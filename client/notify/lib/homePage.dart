import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'main.dart';
import 'measurementModel.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _fcmToken;
  String _messageText;
  String getResponseString;
  var measure;
  List samples;

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  Future<MeasurementModel> getMeasurements(
      String token, String response) async {
    final String measurementsUrl =
        'http://students.atmosphere.tools/v1/measurements';

    final getResponse =
        await http.get(measurementsUrl, headers: {"Authorization": token});
    print(getResponse.body);

    if (getResponse.statusCode == 200) {
      response = getResponse.body;
      measure = new MeasurementModel.fromJson(jsonDecode(response));
      print(_fcmToken);
      this.setState(() {
        samples = measure.getAllSample();
      });

      return measurementModelFromJson(response);
    } else {
      print(getResponse.statusCode);
      response = getResponse.body;
      print(response);
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    getMeasurements(myToken.token, getResponseString);

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        setState(() {
          _messageText = "Push Messaging message: $message";
        });
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        setState(() {
          _messageText = "Push Messaging message: $message";
        });
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        setState(() {
          _messageText = "Push Messaging message: $message";
        });
        print("onResume: $message");
      },
    );

    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });

    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      setState(() {
        _fcmToken = "Push Messaging token: $token";
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Measures'),
        centerTitle: true,
        backgroundColor: Colors.green[400],
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(null),
          ),
        ],
        leading: new Container(),
      ),
      body: Container(
        color: Colors.white,
        child: ListView.builder(
            itemCount: samples == null ? 0 : samples.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(samples[index]),
                subtitle: Text(measure.docs[index].thing.toString() +
                    ', ' +
                    measure.docs[index].endDate.toString()),
              );
            }),
      ),
    );
  }
}
