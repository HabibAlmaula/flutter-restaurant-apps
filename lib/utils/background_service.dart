import 'dart:isolate';

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/data/service/api_service.dart';
import 'package:restaurant_app/main.dart';
import 'package:restaurant_app/utils/notification_helper.dart';

final ReceivePort port = ReceivePort();

class BackGroundService {
  static BackGroundService? _instance;
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackGroundService._internal() {
    _instance = this;
  }

  factory BackGroundService() => _instance ?? BackGroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(port.sendPort, _isolateName);
  }

  static Future<void> callback() async {
    debugPrint('Alarm Fired!');
    final NotificationHelper _notificationHelper = NotificationHelper();
    var result = await ApiService().getListRestaurants();

    await _notificationHelper.showNotification(
        flutterLocalNotificationsPlugin, result.restaurants[0]);

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}
