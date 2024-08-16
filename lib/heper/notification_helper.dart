// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:food_delivery/controllers/auth_controller.dart';
// import 'package:get/get.dart';

// class NotificationHelper {
//   static Future<void> initialize(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
//     // Khởi tạo cho Android
//     var androidInitialize = const AndroidInitializationSettings('notification_icon');
//     // Khởi tạo cho iOS
//     var iOSInitialize = DarwinInitializationSettings();
//     // Cài đặt khởi tạo chung
//     var initializationsSettings = InitializationSettings(android: androidInitialize, iOS: iOSInitialize);

//     flutterLocalNotificationsPlugin.initialize(initializationsSettings,
//       onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) {
//         try {
//           final payload = notificationResponse.payload;
//           if (payload != null && payload.isNotEmpty) {
//             // Xử lý payload nếu cần
//           } else {
//             // Get.toNamed(RouteHelper.getNotificationRoute());
//           }
//         } catch (e) {
//           if (kDebugMode) {
//             print(e.toString());
//           }
//         }
//       });

//     await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//       alert: true, badge: true, sound: true
//     );

//     FirebaseMessaging.onMessage.listen((message) {
//       print('.............onMessage.............');
//       print('onMessage: ${message.notification?.title}/'
//           '${message.notification?.body}/'
//           '${message.notification?.titleLocKey}');

//       NotificationHelper.showNotification(message, flutterLocalNotificationsPlugin);
//       if (Get.find<AuthController>().userLoggedIn()) {
//         // Get.find<OrderController>().getRunningOrders(1);
//         // Get.find<OrderController>().getHistoryOrders(1);
//         // Get.find<NotificationController>().getNotificationList(true);
//       }
//     });

//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       print('onOpenApp: ${message.notification?.title}/${message.notification?.body}/${message.notification?.titleLocKey}');
//       try {
//         if (message.notification?.titleLocKey != null &&
//             message.notification?.titleLocKey != null) {} else {
//           // Get.toNamed(RouteHelper.getNotificationRoute());
//         }
//       } catch (e) {
//         print(e.toString());
//       }
//     });
//   }

//   static Future<void> showNotification(RemoteMessage msg,
//       FlutterLocalNotificationsPlugin fln) async {
//     BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
//       msg.notification!.body!, htmlFormatBigText: true, contentTitle: msg.notification!.title!, htmlFormatContentTitle: true,
//     );

//     AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
//       'channel_id_5', 'dbfood 2', importance: Importance.high, styleInformation: bigTextStyleInformation,
//       priority: Priority.high, playSound: true
//     );

//     NotificationDetails platformChannelSpecifics = NotificationDetails(
//       android: androidPlatformChannelSpecifics,
//       iOS: DarwinNotificationDetails()
//     );

//     await fln.show(0, msg.notification!.title!, msg.notification!.body!, platformChannelSpecifics);
//   }
// }
