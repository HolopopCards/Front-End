import 'package:flutter/material.dart';
import 'package:holopop/dashboard/screens/settings/edit_profile_page.dart';
import 'package:holopop/dashboard/screens/settings/privacy_policy.dart';
import 'package:holopop/dashboard/screens/settings/terms_of_use.dart';
import 'package:holopop/shared/widgets/standard_header.dart';
import 'package:holopop/shared/styles/holopop_colors.dart';


/// Core page.
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<StatefulWidget> createState() => _SettingsPage();
}

class _SettingsPage extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          StandardHeader(headerTitle: "Settings",),
          SettingsBody(),
          SocialMediaIcons()
        ]
      )
    );
  }
}


/// Class representing a setting on this page.
class Setting {
  Setting(this.name, this.func);

  final String name;
  final Function()? func;
  final String type = "button";
}


/// Settings
class SettingsBody extends StatelessWidget {
  const SettingsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SettingsGroup(
          title: "Account",
          settings: [
            Setting("Edit Profile",  () { Navigator.push(context, MaterialPageRoute(builder: (ctx) => const EditProfilePage())); }),
            Setting("Notifications", () { })
          ],
        ),
        SettingsGroup(
          title: "Support",
          settings: [
            Setting("Contact Support", () { }),
            Setting("Help Center", () { })
          ],
        ),
        SettingsGroup(
          title: "About",
          settings: [
            Setting("About Holopop", () { }),
            Setting("Terms of Use", () {Navigator.push(context, MaterialPageRoute(builder: (ctx) => const TermsOfUse())); }),
            Setting("Privacy Policy", () { Navigator.push(context, MaterialPageRoute(builder: (ctx) => const PrivacyPolicy())); }),
            Setting("Share with Friends", () { }),
          ],
        )
      ]
    );
  }
}


/// Widget for a group of settings.
class SettingsGroup extends StatelessWidget {
  const SettingsGroup({super.key, required this.settings, required this.title});

  final List<Setting> settings;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              title,
              style: const TextStyle(
                color: HolopopColors.lightGrey
              ),),
          ),
          for (var setting in settings)
            if (setting.type == "button")
              ElevatedButton(
                onPressed: () { 
                  if (setting.func != null) {
                    setting.func!(); 
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(setting.name),
                    const Icon(Icons.chevron_right)
                  ],
                )
              )
        ]
      )
    );
  }
}


/// Social media icons
class SocialMediaIcons extends StatelessWidget {
  const SocialMediaIcons({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text("Join The Community"),
        SizedBox(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(padding: EdgeInsets.all(10), child: Image(image: AssetImage("assets/icons/instagram.png"), fit: BoxFit.fill)),
              Padding(padding: EdgeInsets.all(10), child: Image(image: AssetImage("assets/icons/facebook.png"),  fit: BoxFit.fill)),
              Padding(padding: EdgeInsets.all(10), child: Image(image: AssetImage("assets/icons/youtube.png"),   fit: BoxFit.fill)),
              Padding(padding: EdgeInsets.all(10), child: Image(image: AssetImage("assets/icons/tiktok.png"),    fit: BoxFit.fill)),
            ],
          )
        )
      ],
    );
  }
}