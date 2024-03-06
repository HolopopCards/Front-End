import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:holopop/dashboard/screens/settings/contact_picker.dart';
import 'package:holopop/dashboard/screens/settings/edit_profile_page.dart';
import 'package:holopop/dashboard/screens/settings/privacy_policy.dart';
import 'package:holopop/dashboard/screens/settings/terms_of_use.dart';
import 'package:holopop/shared/widgets/standard_header.dart';
import 'package:holopop/shared/styles/holopop_colors.dart';
import 'package:mailto/mailto.dart';
import 'package:url_launcher/url_launcher.dart';



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
          ],
        ),
        SettingsGroup(
          title: "Support",
          settings: [
            Setting("Contact Support", () { launchMailto('Support Request');})
          ],
        ),
        SettingsGroup(
          title: "About",
          settings: [
            Setting("About Holopop", () { }),
            Setting("Terms of Use", () {Navigator.push(context, MaterialPageRoute(builder: (ctx) => const TermsOfUse())); }),
            Setting("Privacy Policy", () { Navigator.push(context, MaterialPageRoute(builder: (ctx) => const PrivacyPolicy())); }),
            Setting("Share with Friends", () {Navigator.push(context, MaterialPageRoute(builder:(ctx)=> const ContactPicker())); }),
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
    return  Column(
      children: [
        const Text("Join The Community"),
        SizedBox(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SocialButton(iconPath: "assets/icons/social - facebook.png", 
                           onPressed: () async {
                                                const url = 'https://www.facebook.com/holopopcards'; 
                                                if (await canLaunchUrl(url as Uri)) {
                                                  await launchUrl(url as Uri);} 
                                                else {throw 'Could not launch $url';}}),
              SocialButton(iconPath: "assets/icons/social - instagram.png", 
                           onPressed: () async {
                                                const url = 'https://www.instagram.com/holopop.cards/'; 
                                                if (await canLaunchUrl(url as Uri)) {
                                                  await launchUrl(url as Uri);} 
                                                else {throw 'Could not launch $url';}}),
              SocialButton(iconPath: "assets/icons/social - tiktok.png", 
                           onPressed: () async {
                                                const url = 'https://www.tiktok.com/@holopopcards?lang=en'; 
                                                if (await canLaunchUrl(url as Uri)) {
                                                  await launchUrl(url as Uri);} 
                                                else {throw 'Could not launch $url';}}),
              SocialButton(iconPath: "assets/icons/social - youtube.png", 
                           onPressed: () async {
                                                const url = 'https://www.youtube.com/channel/UC9z'; 
                                                if (await canLaunchUrl(url as Uri)) {
                                                  await launchUrl(url as Uri);} 
                                                else {throw 'Could not launch $url';}})
            ],
          )
        )
      ],
    );
  }
}
///Mail to support 
launchMailto( String subject) async {
    final mailtoLink = Mailto(
        to: ['support@holopop.cards'],
        cc: [''],
        subject: subject,
        body: '',
    );
    await launch('$mailtoLink');
}

class SocialButton extends StatelessWidget {
  const SocialButton({super.key, required this.onPressed, required this.iconPath});

  final String iconPath;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      
      child: IconButton(
        // icon: Icon(iconData), 
        icon: SvgPicture.asset(iconPath), 
        onPressed: onPressed),
    );
  }
}
