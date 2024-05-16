// ignore_for_file: deprecated_member_use, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:new_sensors/main.dart';
//import 'package:new_sensors/components/side_drawer.dart';
import 'package:sensors_plus/sensors_plus.dart';

class StepCounterApp extends StatefulWidget {
  @override
  _StepCounterAppState createState() => _StepCounterAppState();
}

class _StepCounterAppState extends State<StepCounterApp> {
  int _stepCount = 0;
  StreamSubscription<AccelerometerEvent>? _streamSubscription;

  @override
  void initState() {
    super.initState();
    _streamSubscription = accelerometerEvents.listen((event) {
      setState(() {
        // Simple step detection: detect sudden change in accelerometer's y-axis
        if (event.z.abs() > 20.0) {
          _stepCount++;
        }
        _triggerGoalNotification();
      });
    });
  }

  @override
  void dispose() {
    _streamSubscription!.cancel();
    super.dispose();
  }

  void _triggerGoalNotification() async {
    if (_stepCount >= 1) {
      const AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
        'StepCounter_channel',
        'StepCounter Notifications',
        importance: Importance.max,
        priority: Priority.high,
      );
      const NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);
      await flutterLocalNotificationsPlugin.show(
        0,
        'Step Counter Update',
        'You have started making some steps!',
        platformChannelSpecifics,
      );
      //_notificationShown = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Step Counter'),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      // drawer: SideDrawer(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.green],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Steps Count:',
                style: TextStyle(fontSize: 24.0, color: Colors.white),
              ),
              Text(
                '$_stepCount',
                style: TextStyle(
                    fontSize: 48.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _stepCount = 0;
          });
        },
        tooltip: 'Reset',
        child: Icon(Icons.refresh),
      ),
    );
  }
}
