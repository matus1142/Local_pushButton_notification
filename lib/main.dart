import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NotificationApp(),
    );
  }
}

class NotificationApp extends StatefulWidget {
  @override
  State<NotificationApp> createState() => _NotificationAppState();
}

class _NotificationAppState extends State<NotificationApp> {
  int Channelid = 0;
  //local notification object
  late FlutterLocalNotificationsPlugin localNotification;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var androidInitialize =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    //ic_launcher is icon in drawble folder
    //The function to initialize android setting
    //Make sure that the icon exist in the drawable folder

    var iOSInitialize = DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
      android: androidInitialize,
    );
    localNotification = FlutterLocalNotificationsPlugin();
    localNotification.initialize(initializationSettings);
    // we instanciate the local notification
  }

  Future<void> _showNotification() async {
    var andoridDetails = AndroidNotificationDetails(
        "channelId", "Local Notification",
        channelDescription: "AAAA",
        importance: Importance.max,
        priority: Priority.high);
    var iosDetails = DarwinNotificationDetails();
    var generalNotificationDetails = NotificationDetails(
      android: andoridDetails,
    );
    await localNotification.show(
        Channelid++,
        "Notify Title CH:${Channelid}",
        "The Body of the Notification CH:${Channelid}",
        generalNotificationDetails);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Click the button to recieve a notification")),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.notifications),
          onPressed: () async {
            await _showNotification();
          }),
    );
  }
}
