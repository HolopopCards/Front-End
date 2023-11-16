import 'package:flutter/material.dart';
import 'package:holopop/dashboard/screens/notification_page.dart';
import 'package:holopop/dashboard/screens/settings/settings_page.dart';


/// Holopop title + notifications and settings.
class TitleAndSettings extends StatelessWidget {
  const TitleAndSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("holopop"),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.notifications_none),
              onPressed: () { 
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) =>
                    const NotificationPage()
                ));
              },
            ),
            IconButton(
              icon: const Icon(Icons.settings_outlined),
              onPressed: () { 
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) =>
                    const SettingsPage()
                ));
              },
            )
          ]
        )
      ]
    );
  }
}