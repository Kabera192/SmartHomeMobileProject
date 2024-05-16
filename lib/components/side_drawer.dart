import 'package:flutter/material.dart';

// Side drawer widget
class SideDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Navigation',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: Text('Light Sensor'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/light');
            },
          ),
          ListTile(
            title: Text('Motion Sensor'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/motion');
            },
          ),
          ListTile(
            title: Text('Location Sensor'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/location');
            },
          ),
        ],
      ),
    );
  }
}
