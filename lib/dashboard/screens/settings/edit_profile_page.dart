import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:holopop/shared/nav/holopop_navigation_bar.dart';
import 'package:holopop/shared/providers/auth_provider.dart';
import 'package:holopop/shared/providers/user_provider.dart';
import 'package:holopop/shared/styles/holopop_colors.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

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
  @override
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
                      if (formKey.currentState!.validate()) {
                        save(formModel, context);
                      }
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
 void save(EditProfileModel profileForm, BuildContext context) {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    auth.editProfile(
      profileForm.name!,
      profileForm.emailAddress!,
      profileForm.userName!,
      profileForm.mobilePhone!,
      profileForm.dob! as DateTime,
      profileForm.password!)
      .then((res) {
        if (res.success) {
          final user = res.value!;
          Provider.of<UserProvider>(context, listen: false).setUser(user);
          Navigator.pushNamed(context, "/");
        } else {
          Logger('Edit Profile').severe("Failed to save: ${res.error}}");
          toastification.show(
            context: context,
            title: Text("Failed to save: ${res.error}"),
            type: ToastificationType.error);
        }
      })
      .onError((e, x) {
        Logger('Edit Profile').severe("Failed to save: $e");
        toastification.show(
          context: context,
          title: Text("Failed to save: $e"),
          type: ToastificationType.error);
      });
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