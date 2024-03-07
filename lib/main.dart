import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:holopop/shared/firebase/firebase_options.dart';
import 'package:holopop/shared/nav/routes.dart';
import 'package:holopop/shared/providers/auth_provider.dart';
import 'package:flutter/services.dart';
import 'package:holopop/shared/providers/user_provider.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'shared/styles/holopop_theme.dart';


void main() async {
  // Logger
  Logger.root.level = Level.FINE; // Change in prod.
  Logger.root.onRecord.listen((record) {
    // ignore: avoid_print
    print('${record.level.name}: ${record.loggerName}: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(record.time)}: ${record.message}');
  });

  Logger('Main').info("Starting up Holopop...");

  WidgetsFlutterBinding.ensureInitialized();

  // Global Configuration
  await GlobalConfiguration().loadFromPath("configs/appsettings.json");
  
  // Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true);
  await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(false);

  // Notifications
  AwesomeNotifications().requestPermissionToSendNotifications();
  AwesomeNotifications().initialize(
    'resource://drawable/app_icon',
    [
      NotificationChannel(
          channelGroupKey: 'holopop_group',
          channelKey: 'basic',
          channelName: 'Basic notifications',
          channelDescription: 'For basic notifications.',
          defaultColor: Colors.white,
          ledColor: Colors.white)
    ],
    // Channel groups are only visual and are not required
    channelGroups: [
      NotificationChannelGroup(
          channelGroupKey: 'holopop_group',
          channelGroupName: 'Holopop Group')
    ],
    debug: true // TODO: disable in prod.
  );

  runApp(const App());
}


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack); //Fullscreen
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider())
      ],
      child: MaterialApp(
        initialRoute: "/",
        routes: routes,
        title: 'HoloPop',
        theme: HolopopTheme().getTheme(),
        debugShowCheckedModeBanner: false,
        builder: (context, child) =>
          SafeArea(child: child ?? const CircularProgressIndicator()), // SafeArea everywhere
      )
    );
  }
}