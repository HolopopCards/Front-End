import 'package:flutter/material.dart';
import 'package:holopop/dashboard/models/notification.dart';
import 'package:holopop/dashboard/services/notification_service.dart';
import 'package:holopop/shared/styles/holopop_colors.dart';


/// Core page.
class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<StatefulWidget> createState() => _DashboardPage();
}

class _DashboardPage extends State<NotificationPage> {
  final Future<List<HolopopNotification>> notifications = NotificationService.getNotifications();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          const Header(),
          NotificationsBody(notifications: notifications,)
        ]
      )
    );
  }
}


/// Header
class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () { Navigator.pop(context); },
        ),
        const Text("Notifications")
      ],
    );
  }
}


/// List of notifications.
class NotificationsBody extends StatelessWidget {
  const NotificationsBody({super.key, required this.notifications});

  final Future<List<HolopopNotification>> notifications;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: notifications,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data;
          if (data == null || data.isEmpty) {
            return const Column();
          } else {
            return Notifications(notifications: data);
          }
        } else if (snapshot.hasError) {
          return NotificationsError(error: snapshot.error!);
        } else {
          return const NotificationsLoading();
        }
      }
    );
  }
}


/// Once notifications have loaded and there are some.
class Notifications extends StatelessWidget {
  const Notifications({super.key, required this.notifications});

  final List<HolopopNotification> notifications;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var n in notifications)
          NotificationDisplay(notification: n)
      ],
    );
  }
}

class NotificationDisplay extends StatelessWidget {
  const NotificationDisplay({super.key,required this.notification});

  final HolopopNotification notification;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Card(
            elevation: 4.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (notification.read == false)
                      const Padding(
                        padding: EdgeInsets.fromLTRB(16, 0, 0, 0), 
                        child: Icon(Icons.circle, size: 7.5, color: HolopopColors.blue,)
                      ),
                    Expanded(child: 
                      ListTile(
                        title: Text(
                          notification.from,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700
                          )
                        )
                      )
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(notification.message),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}


/// If there was an error getting notifications.
class NotificationsError extends StatelessWidget {
  const NotificationsError({super.key, required this.error});

  final Object error;

  @override
  Widget build(BuildContext context) => 
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Text("There was an error getting notifications: $error")]
    );
}


/// While user is waiting for notifications.
class NotificationsLoading extends StatelessWidget {
  const NotificationsLoading({super.key});

  @override
  Widget build(BuildContext context) => const Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [Text("Getting notifications...")]
  );
}