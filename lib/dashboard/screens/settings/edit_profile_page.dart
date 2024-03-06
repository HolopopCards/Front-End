import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:holopop/shared/storage/create_application_storage.dart';
import 'package:holopop/shared/styles/holopop_colors.dart';
import 'package:logging/logging.dart';

class EditProfileModel {
  String? name;
  String? userName;
  String? mobilePhone;
  String? emailAddress;
  String? dob;
  String? password;

  @override
  String toString() => 
    "Edit Profile Model => $name|$userName|$mobilePhone|$emailAddress|$dob|$password";
}
/// Core page.
class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<StatefulWidget> createState() => _EditProfilePage();
}

class _EditProfilePage extends State<EditProfilePage> {
    final formKey = GlobalKey<FormState>();

  final formModel = EditProfileModel();
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child:Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: () => Navigator.pop(context)),
                const Text("Edit Profile", style: TextStyle(fontWeight: FontWeight.bold)),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: RichText(
                  text: TextSpan(
                    text: "Save",
                    style: const TextStyle(color: HolopopColors.blue),
                    recognizer: TapAndPanGestureRecognizer()..onTapDown = (_) { 
                      Logger('Edit Profile').info("Edit Profile form completed: $formModel");
                      CreateApplicationStorage()
                        .getAppAsync()
                        .then((res) {
                          if (res.success) {
                            return CreateApplicationStorage()
                              .updateLastCardAsync((c) {
                                c.subject = formModel.name;
                                c.recipient = formModel.userName;
                                c.occasion = formModel.mobilePhone;
                                c.message = formModel.emailAddress;
                                c.message = formModel.dob;
                                c.message = formModel.password;
                                return c;
                              })
                              .then((res) {
                                if (res.success) {
                                  // handleDialogResult(null); // For gift cards one day.
                                  Navigator.pushNamed(context, "/settings");
                                }
                              });
                          }
                        });
                    }
                  )))
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Profile(
              name: "Name",
              description: "Your full name. I.e. John Doe",   
              formField: TextFormField(
                decoration: const InputDecoration(
                  hintText: "John Doe",
                  contentPadding: EdgeInsets.all(10)
                ),
                onChanged: (value) => formModel.name = value,
              ))
            ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Profile(
              name: "Username",
              description: "Your username. I.e. johndoe@email.com",
              formField: TextFormField(
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(10)
                ),
                onChanged: (value) => formModel.userName = value,
              ))
            ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Profile(
              name: "Mobile Phone",
              description: "Your mobile phone number. I.e. 123-456-7890",
              formField: TextFormField(
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(10)
                ),
                onChanged: (value) => formModel.mobilePhone = value,
              ))
            ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Profile(
              name: "Email Address",
              description: "Your email address. I.e. johndoe@email.com",
              formField: TextFormField(
                inputFormatters: [
                  LengthLimitingTextInputFormatter(500)
                ],
                decoration: const InputDecoration(
                  hintText: "johndoe@email.com",
                  contentPadding: EdgeInsets.all(10)),
                onChanged: (value) => formModel.emailAddress = value,
            ))),
            Padding(
            padding: const EdgeInsets.all(5),
            child: Profile(
              name: "Date of Birth",
              description: "Your Date of Birth. I.e. 01/01/2000",
              formField: TextFormField(
                inputFormatters: [
                  LengthLimitingTextInputFormatter(500)
                ],
                decoration: const InputDecoration(
                  hintText: "01/01/2000",
                  contentPadding: EdgeInsets.all(10)),
                onChanged: (value) => formModel.emailAddress = value,
            )))
        ],
      ));
  }  
}
class Profile extends StatelessWidget {
  final String name;
  final String description;
  final Widget formField;

  const Profile({
    super.key,
    required this.name,
    required this.description,
    required this.formField
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: HolopopColors.darkGreyBackground,
        borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
            child: Text(
              name, 
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16))),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
            child: Text(description)),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
            child: formField)
        ],
      ),
    );
  }
}