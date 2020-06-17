import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationManager {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;  
  var initializationSettingsAndroid;
  var initializationSettings;
  Future initNotif() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings('app_icon');
    var ios = new IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var settings = new InitializationSettings(android, ios);
    await flutterLocalNotificationsPlugin.initialize(settings,
        onSelectNotification: onSelectNotification);
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    // await showDialog(
    //     context: context,
    //     builder: (BuildContext context) =>
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(body),
      actions: <Widget>[
        CupertinoDialogAction(
          isDefaultAction: true,
          child: Text("Ok"),
          onPressed: () => {},
        )
      ],
    );
  }

  Future onSelectNotification(String payload) async {
    if (payload != null) {
      print('notification payload: ' + payload);
    }
    /*await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SecondScreen(payload)),
    );*/
  }

  Future showNotification() async{
    await _demoNotif();
  }

  Future<void> _demoNotif() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'channelId', 'channelName', 'channelDescription',
        importance: Importance.Max,
        priority: Priority.High,
        ticker: 'test ticker');

    var iOSChannelSpecifics = IOSNotificationDetails(
        presentAlert: false,
        presentBadge: false,
        presentSound: false,
        sound: "");
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, 'This is Title', 'This is body', platformChannelSpecifics,
        payload: 'test payload');
  }

  Future sendScheduledNotification(int notifId,String notifTitle, String notifText,DateTime notifDate,
      [String id = "8990", String name = "TaskScheduledNotif", String description = "SendingScheduledNotifications"]) async {
    if (id.isEmpty) id = '8990';
    if (name.isEmpty) name = 'TaskScheduledNotif';
    if (description.isEmpty) description = 'SendingScheduledNotifications';
    if (notifTitle.isEmpty) notifTitle = 'You have a task to complete';
    if (notifText.isEmpty) notifText = 'Click here to see';
    print("sendScheduledNotificationInside : notificationCreated : id = " + notifId.toString() + " /n scheduled date" + notifDate.toString());
    var androidPlatformChannelSpecifics =
        AndroidNotificationDetails(id, name, description);
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(
        0, notifTitle, notifText, notifDate, platformChannelSpecifics);
    
  }
  Future cancelScheduledNotification(int id) async{
    print("cancelScheduledNotificationInside : notificationCanceled: id = " + id.toString());
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}
