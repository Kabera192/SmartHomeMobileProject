// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:new_sensors/components/light_graph.dart';
//import 'package:new_sensors/components/location_graph.dart';
import 'package:new_sensors/components/motion_graph.dart';
import 'package:new_sensors/components/side_drawer.dart';
import 'package:new_sensors/screens/light_sensor.dart';
import 'package:new_sensors/screens/location.dart';
import 'package:new_sensors/screens/motion_sensor.dart';

void main() async {
  runApp(SmartHomeApp());
  await initNotifications();
}

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> initNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse:
        (NotificationResponse notificationResponse) async {
      // Handle notification tap
    },
  );
}

class SmartHomeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Home Monitoring',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      routes: {
        '/home': (context) => HomePage(),
        '/light': (context) => LightSensorScreen(),
        '/motion': (context) => StepCounterApp(),
        '/location': (context) => NewMapPage(),
      },
    );
  }
}

// Home page widget
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        title: Text('Smart Home Monitoring'),
      ),
      drawer: SideDrawer(), // Side drawer for navigation
      body: SingleChildScrollView(
        child: Column(children: [
          Text(
            'Light Sensor Activity',
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
          Container(
            color: Colors.black12,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: LightSensorGraph(),
          ),
          SizedBox(height: 25.0),
          Text(
            'Motion Sensor Activity',
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
          Container(
            color: Colors.black12,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: MotionSensorGraph(),
          ),
        ]),
      ),
    );
  }
}
