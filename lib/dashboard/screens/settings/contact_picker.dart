import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:holopop/shared/nav/holopop_navigation_bar.dart';
import 'package:holopop/shared/widgets/standard_header.dart';
import 'package:url_launcher/url_launcher.dart';

/// Core page.
class ContactPicker extends StatefulWidget
{
    const ContactPicker({super.key});

    @override
    State<StatefulWidget> createState() => _ContactPicker();
}

class _ContactPicker extends State<ContactPicker>
{
    final FlutterContactPicker _contactPicker = FlutterContactPicker();

    @override
    Widget build(BuildContext context)
    {
        return Scaffold(
            body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                    children: [
                        const StandardHeader(headerTitle: "Invite Friends"),
                        Expanded(child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                    MaterialButton(
                                        color: Colors.blue,
                                        child:  Text("Choose a contact"),
                                        onPressed: () async
                                        {
                                            Contact? contact = await _contactPicker.selectContact();
                                            setState(()
                                                {
                                                    contact == null ? null : contact;
                                                }
                                            );
                                            await _sendSMS(
                                                "Holopop lets you send personalized holographic greetings. Use promo code WELCOME2HOLO to get an extra 10% off on your first purchase! Let's create unforgettable moments together! Check it out at https://holopop.cards", 
                                                contact!.phoneNumbers.toString());
                                        }            
                                    )
                                ]
                            )
                        )
                    ]
                )
            ),
            bottomNavigationBar: HolopopNavigationBar.getNavBar(context, NavBarItem.create));
    }
}
//SMS invite friends
_sendSMS(String message, String recipent) async
{
    Uri url;
    if(Platform.isAndroid)
    {
        //FOR Android
        url = Uri.parse('sms:$recipent?body=$message');
        await launchUrl(url);
    } 
    else if(Platform.isIOS)
    {
        //FOR IOS
        url = Uri.parse('sms:$recipent&body=$message');
        await launchUrl(url);
    }
}
