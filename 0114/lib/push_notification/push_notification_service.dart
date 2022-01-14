import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class NotificationService{
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  //String? token;
  static const String serverKey =
      'AAAAYJGNJi4:APA91bEzEuA2FMkTx27heVa728NpaaKn7y51zfsT5wngt54-l8fYRuL4cf43d7baQM1lhzqwfpIpQAr8000X3qOk7EAEDtKuKeCSKMqp8l_jDmE5Ov9SxXqC2r8TPCuJp3fFnQRdNG-x';
  //NotificationService.getTokenAndUpdate(currentUserId);

  static getTokenAndUpdate(String username) async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    String? token = await firebaseMessaging.getToken();
    print("FirebaseMessaging token: $token");

    await FirebaseFirestore.instance.collection('users').doc(username).update({'token': token});
  }

  static Future sendNotification(String title, String message) async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

    List<String> tokens = [];
    await firebaseMessaging.requestPermission(
        sound: true,
        badge: true,
        alert: true,
        provisional: false
    );

    //Android용 새 Notification Channel
    const AndroidNotificationChannel androidNotificationChannel = AndroidNotificationChannel(
      'video_call', // 임의의 id
      'High Importance Notifications', // 설정에 보일 채널명
      importance: Importance.max,
    );


    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('users').get();
      for (var element in querySnapshot.docs) {
        tokens.add((element.data() as dynamic)["token"]);
      }
      //if (ds.data()!["token"] != null) {
      if (tokens != null) {
        //String userToken = ds.data()!["token"];
        await post(
          Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'key=$serverKey',
            // replace $serverToken with your firebase messaging server token
          },
          body: jsonEncode(
            <String, dynamic>{
              'notification': <String, dynamic>{
                'title': title,
                'body': message,
              },
              'priority': 'high',
              'data': <String, dynamic>{
                'click_action': 'FLUTTER_NOTIFICATION_CLICK',
                'id': '${Random().nextInt(100)}',
                'status': 'done',
                'view': 'orders',
                //'screen': "CALLPAGE_HELPER",
                //'extradata': uid
              },

              //'to': userToken,
              'registration_ids': tokens
              // 'registration_ids': [
              // ]
            },
          ),
        );
      } else {
        print("unable to fetch admin device token from database");
      }
    } catch (e) {
      print("Error in sending notification");
      print(e);
    }
  }
}