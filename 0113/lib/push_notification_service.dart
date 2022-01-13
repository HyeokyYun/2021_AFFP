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
      'AAAAS0sGY3U:APA91bGVkm3Bhh5KmQk0W6Gflt5EJCQUEMhQdt4nw1v2TDzPLTbOpcTlr2Dmmu-6WKTuHMW5abIaoVlLUCt6OCnTiQjplQL0XB1BdAPXQ4h6cVlEDptjksRyMlgyRg4ujIfN9lZaeJE0';
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

    // Android용 새 Notification Channel
    const AndroidNotificationChannel androidNotificationChannel = AndroidNotificationChannel(
      'video_call', // 임의의 id
      'High Importance Notifications', // 설정에 보일 채널명
      importance: Importance.max,
    );

    try{
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
              'body': message,
              'title': title
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
            //'registration_ids': tokens
            'registration_ids': [
              'cvnrmQNDxkXikLIlqMkzhM:APA91bG64-fQxP5S1RHqXRrdZVhIEAzKEcufiEpJlzDpTMtgCvVrV9YvBcVogfjvtlwc8GmV_btCKPWDbGW0OwzG0DgLzenGo6srndvUXfndBxK5iqtg2iXF8C3p_sDCTwHBBiXcGQbb',
              'dVxHqviwQYy3hf1YG1AZHZ:APA91bFwYPEmgCG6xbnP8JhYntTx-CpgGZVwe2jhNPRglmbPjXjEFKUfp6f8BPFth_OlgvPsZqVIPWBOfYpRmQuZPbaI0F2u3jaIW19InFjEWGtWPHaFA1RbB9U3LFARelkHODu9x_Se',
              'cZOGC-8rSzqD3EvVSIrLZ9:APA91bFdrlBbh5IOqfkYgM3nDoBS-Pbe0nLwWY2rK4iXnMCxh_0X1V-YledDtzWy29iiMKxiRfmshTmPYWEhHUV9nOnuroz1zIGIKecQGAkfZ9bo8Q2guJt6JuCqFZIt8YwhxHSyaihm',
              'ePa9heqoRhWE0Y_lc8rh7b:APA91bGV96OLCovsoBXnGV_8FFFd09PLF77qFzrH-AVk6WTOUnF_6VHo-9vsX9fxAP861PCYDRxi-KM1VPJ7LhE--0KxJb3zW5_3rUGi9u8XGZJtL_1SbMKdQ0wINAMk04lux2c-4bQs',
              'APA91bGlOgmFnHEG7akCHQog1vEWAyM8dx7sxKU06lVrLHVzW5o6syTplEfFIBJxU0VFl5MBGFKpLHkbFuTCAQ2k0y7IDz5etjKwhMzGi_r8kpdDxuM0EhHufLzFf050lZ3ppx67Ypb6'
            //   'dGsnZYO9QyCtgaN_VRaJ1y:APA91bF3Ud_wYo7vLyregHcHnCxo3qALNLgHQUvgNZomLcKwSDB2zq4IqLMB9HYkgVjlJ9dYgyoIun3gi0GoryRqUTZ0lTS69CWKs8qe36KlhEWcnpDsbJ46eScwXrtQsyLnq4bHdRJM',
            //   'dypc7BwfQIKGLag7ecQtrp:APA91bFT8p37RGwW21TqT7Ys7bK-iMAgN3S-EZQ3WP7MlXtPABpTHHvr-Z9SYoV3jy9zI8lOcCRDWN8ljhLdIy4E_-wXtoj0T9gs-C-cBktZwRLvzjkptnKcSWrvn7IWKGGAr7shG7k7',
            //   'ce4Udk-qUUqBiI_Ay18rX6:APA91bHKmiqVZgS6MddgMpBqPTfMZKn4yAphyjG1yqukUbPu18_58ujWxwMkbeZplCOPhJkgmGsK6qSR69acPQEJZ9B1tMjYfAbMKyoJwmFqAxL_Xq5szw6a17oR0VkdBEVekpkbpz7N'
            ]
          },
        ),
      );
    } catch (e) {
      print("Error in sending notification");
      print(e);
    }
    // try {
    //   QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('users').get();
    //   for (var element in querySnapshot.docs) {
    //     tokens.add((element.data() as dynamic)["token"]);
    //   }
    //   //if (ds.data()!["token"] != null) {
    //   if (tokens != null) {
    //     //String userToken = ds.data()!["token"];
    //     await post(
    //       Uri.parse('https://fcm.googleapis.com/fcm/send'),
    //       headers: <String, String>{
    //         'Content-Type': 'application/json',
    //         'Authorization': 'key=$serverKey',
    //         // replace $serverToken with your firebase messaging server token
    //       },
    //       body: jsonEncode(
    //         <String, dynamic>{
    //           'notification': <String, dynamic>{
    //             'body': message,
    //             'title': title
    //           },
    //           'priority': 'high',
    //           'data': <String, dynamic>{
    //             'click_action': 'FLUTTER_NOTIFICATION_CLICK',
    //             'id': '${Random().nextInt(100)}',
    //             'status': 'done',
    //             'view': 'orders',
    //             //'screen': "CALLPAGE_HELPER",
    //             //'extradata': uid
    //           },
    //
    //           //'to': userToken,
    //           'registration_ids': tokens
    //           // 'registration_ids': [
    //           //   'dGsnZYO9QyCtgaN_VRaJ1y:APA91bF3Ud_wYo7vLyregHcHnCxo3qALNLgHQUvgNZomLcKwSDB2zq4IqLMB9HYkgVjlJ9dYgyoIun3gi0GoryRqUTZ0lTS69CWKs8qe36KlhEWcnpDsbJ46eScwXrtQsyLnq4bHdRJM',
    //           //   'dypc7BwfQIKGLag7ecQtrp:APA91bFT8p37RGwW21TqT7Ys7bK-iMAgN3S-EZQ3WP7MlXtPABpTHHvr-Z9SYoV3jy9zI8lOcCRDWN8ljhLdIy4E_-wXtoj0T9gs-C-cBktZwRLvzjkptnKcSWrvn7IWKGGAr7shG7k7',
    //           //   'ce4Udk-qUUqBiI_Ay18rX6:APA91bHKmiqVZgS6MddgMpBqPTfMZKn4yAphyjG1yqukUbPu18_58ujWxwMkbeZplCOPhJkgmGsK6qSR69acPQEJZ9B1tMjYfAbMKyoJwmFqAxL_Xq5szw6a17oR0VkdBEVekpkbpz7N'
    //           // ]
    //         },
    //       ),
    //     );
    //   } else {
    //     print("unable to fetch admin device token from database");
    //   }
    // } catch (e) {
    //   print("Error in sending notification");
    //   print(e);
    // }
  }
}