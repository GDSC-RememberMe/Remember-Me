import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remember_me_mobile/common/const/colors.dart';
import 'package:remember_me_mobile/common/const/text.dart';
import 'package:remember_me_mobile/common/provider/go_router.dart';
import 'package:remember_me_mobile/common/utils/data_utils.dart';
import 'package:remember_me_mobile/firebase_options.dart';
import 'package:remember_me_mobile/memory_bubble/view/memory_bubble_detail_page.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp(
    name: "rememberme-1edf1",
    options: DefaultFirebaseOptions.currentPlatform,
  );

  print("Handling a background message: ${message.messageId}");
}

late AndroidNotificationChannel channel;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: "fcm-test-333c6",
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  configureFCM();

  runApp(
    const ProviderScope(
      child: _App(),
    ),
  );
}

void configureFCM() async {
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.', // description
    importance: Importance.max,
  );

  var initialzationSettingsAndroid = AndroidInitializationSettings('mipmap/ic_launcher');

  var initialzationSettingsIOS = DarwinInitializationSettings(
    requestSoundPermission: true,
    requestBadgePermission: true,
    requestAlertPermission: true,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  var initializationSettings =
      InitializationSettings(android: initialzationSettingsAndroid, iOS: initialzationSettingsIOS);

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
  );

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
}

class _App extends ConsumerStatefulWidget {
  const _App({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => __AppState();
}

class __AppState extends ConsumerState<_App> {
  @override
  void initState() {
    super.initState();
    requestPermission();
    initInfo();
  }

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  void initInfo() async {
    var androidInitialize = const AndroidInitializationSettings("launcher_icon");
    var iOSInitialize = const DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(android: androidInitialize, iOS: iOSInitialize);

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        if (response.payload != null) {
          ref.read(routerProvider).pushNamed(
            MemoryBubbleDetailPage.routeName,
            params: {
              "memoryId": "${jsonDecode(response.payload as String)["memoryId"]}",
              "isFromPatient": "true",
            },
          );
        }
      },
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      AndroidNotificationDetails androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        "1001",
        "General Notification",
        channelDescription: "This is a general notification channel",
        importance: Importance.max,
        channelShowBadge: true,
      );

      NotificationDetails platformChanelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);

      await flutterLocalNotificationsPlugin.show(
        0,
        message.notification?.title,
        message.notification?.body,
        platformChanelSpecifics,
        payload: jsonEncode(message.data),
      );
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.data["memoryId"] != null) {
        ref.read(routerProvider).pushNamed(
          MemoryBubbleDetailPage.routeName,
          params: {
            "memoryId": "${message.data["memoryId"]}",
            "isFromPatient": "true",
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(routerProvider);
    return ScreenUtilInit(
      designSize: const Size(375, 768),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: "Remember Me",
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: false,
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: DataUtils.createMaterialColor(PRIMARY_COLOR),
              backgroundColor: WHITE,
            ).copyWith(
              primary: PRIMARY_COLOR,
            ),
            fontFamily: NOTO_SANS,
            dialogBackgroundColor: WHITE,
            scaffoldBackgroundColor: WHITE,
          ),
          darkTheme: ThemeData(
            useMaterial3: false,
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: DataUtils.createMaterialColor(PRIMARY_COLOR),
              backgroundColor: WHITE,
            ).copyWith(
              primary: PRIMARY_COLOR,
            ),
            fontFamily: NOTO_SANS,
            dialogBackgroundColor: WHITE,
            scaffoldBackgroundColor: WHITE,
          ),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('ko', 'KR'),
          ],
          locale: const Locale('ko'),
          routeInformationParser: router.routeInformationParser,
          routerDelegate: router.routerDelegate,
          routeInformationProvider: router.routeInformationProvider,
        );
      },
    );
  }
}
