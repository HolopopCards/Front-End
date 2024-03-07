import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:url_launcher/url_launcher.dart';

/// Core page.
class ContactPicker extends StatefulWidget {
  const ContactPicker({super.key});

  @override
  State<StatefulWidget> createState() => _ContactPicker();
}

class _ContactPicker extends State<ContactPicker> {
  final FlutterContactPicker _contactPicker = FlutterContactPicker();
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: <Widget>[
              MaterialButton(
                color: Colors.blue,
                child: const Text("Single"),
                onPressed: () async {
                  Contact? contact = await _contactPicker.selectContact();
                  setState(() {
                     contact == null ? null : [contact];
                  });
                  
                   await _sendSMS(
                    "Holopop lets you send personalized holographic greetings. Use promo code WELCOME2HOLO to get an extra 10% off on your first purchase! Let's create unforgettable moments together! Check it out at https://holopop.cards", 
                    contact!.phoneNumbers.toString());  
                }            
          )
        ],
      )
    );
  }
}
//SMS invite friends
_sendSMS(String message, String recipent) async {
  var url;
  if(Platform.isAndroid){
        //FOR Android
        url ='sms:${recipent}?body=$message';
        await launchUrl(url);
    } 
    else if(Platform.isIOS){
        //FOR IOS
        url ='sms:${recipent}&body=$message';
        await launchUrl(url);
    }
}