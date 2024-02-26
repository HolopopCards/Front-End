import 'package:flutter/material.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:flutter_sms/flutter_sms.dart';


/// Core page.
class ContactPicker extends StatefulWidget {
  const ContactPicker({super.key});

  @override
  State<StatefulWidget> createState() => _ContactPicker();
}

class _ContactPicker extends State<ContactPicker> {
  final FlutterContactPicker _contactPicker = FlutterContactPicker();
  List<Contact>? _contacts;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: <Widget>[
              MaterialButton(
                color: Colors.blue,
                child: Text("Single"),
                onPressed: () async {
                  Contact? contact = await _contactPicker.selectContact();
                  setState(() {
                    _contacts = contact == null ? null : [contact];
                  });
                },
              ),
              MaterialButton(
                color: Colors.blue,
                child: new Text("Multiple"),
                onPressed: () async {
                  final contacts = await _contactPicker.selectContacts();
                  setState(() {
                    _contacts = contacts;
                  });
                },
              ),
              if (_contacts != null)
              ///to do return the contacts back to the settings page
                ..._contacts!.map(
                  (e) => Text(e.toString())
                ),
                MaterialButton(
                color: Colors.blue,
                child: Text("Invite Friends"),
                onPressed: () async {
                   await _sendSMS("Check out this app", _contacts!.map((e) => e.toString()).toList());
                },
              )
                

            ],
      )
    );
  }
}
//SMS invite friends
_sendSMS(String message, List<String> recipents) async {
 String result = await sendSMS(message: message, recipients: recipents)
        .catchError((onError) {
      return(onError);
    });
    return result;}