import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Location location = Location();
  late bool serviceEnabled;

  Future<void> checkGpsPermission() async {
    await location.requestPermission().then((permissionStatus) {
      if (permissionStatus == PermissionStatus.granted) {
        print('Permission granted');
        checkGpsStatus();
      } else {
        print('Permission not granted');
        SystemNavigator.pop();
      }
    });
  }

  Future<void> checkGpsStatus() async {
    serviceEnabled = await location.serviceEnabled();

    if (serviceEnabled) {
      print('GPS enabled.');
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    } else {
      serviceEnabled = await location.requestService();
      if (serviceEnabled) {
        print('GPS finally enabled.');
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      } else {
        SystemNavigator.pop();
      }
    }
  }

  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      checkGpsPermission();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Center(
        child: SizedBox(
          width: 150,
          height: 150,
          child: Image.network(
            'https://cdn-icons-png.flaticon.com/512/1146/1146808.png',
          ),
        ),
      ),
    );
  }
}