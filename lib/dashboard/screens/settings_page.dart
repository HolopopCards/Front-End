import 'package:flutter/material.dart';
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
          Header(),
          SettingsBody(),
          SocialMediaIcons()
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
        const Text("Settings")
      ],
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
    // return SettingsList(
    //   shrinkWrap: true,
    //   applicationType: ApplicationType.material,
    //   darkTheme: const SettingsThemeData(
    //     settingsSectionBackground: HolopopColors.darkgrey,

    //   ),
    //   sections: [
    //     SettingsSection(
    //       title: const Text('Account'),
    //       tiles: [
    //         SettingsTile.navigation(
    //           title: const Text("Edit Profile"),
    //           value: const Text('editprofile'),
    //         )
    //       ]
    //     )
    //   ],
    // );
    return Column(
      children: [
        SettingsGroup(
          title: "Account",
          settings: [
            Setting("Edit Profile",  () { }),
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
            Setting("Terms of Use", () { }),
            Setting("Privacy Policy", () { }),
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
                color: HolopopColors.lightgrey
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