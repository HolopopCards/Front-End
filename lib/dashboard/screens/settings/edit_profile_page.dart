import 'package:flutter/material.dart';
import 'package:holopop/dashboard/widgets/standard_header.dart';


/// Core page.
class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<StatefulWidget> createState() => _EditProfilePage();
}

class _EditProfilePage extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          StandardHeader(headerTitle: "Edit Profile",)
        ]
      )
    );
  }
}