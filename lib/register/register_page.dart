
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: Text("Let's get started", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          ),
          RegisterTextField(labelText: "Name"),
          RegisterTextField(labelText: "Mobile Phone"),
          RegisterTextField(labelText: "Email Address"),
          RegisterTextField(labelText: "Date Of Birth"),
          RegisterTextField(labelText: "Password"),
          RegisterTextField(labelText: "Confirm Password"),
          RegisterCheckbox(labelText: "Agree with Privacy Policy"),
          RegisterCheckbox(labelText: "Agree with Terms and Conditions"),
          RegisterSentence(),
          CreateAccountButton(), 
        ],
      ),
    );
  }
}


/// Text fields
class RegisterTextField extends StatelessWidget {
  const RegisterTextField({super.key, required this.labelText});

  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.5), 
      child: TextField( 
        decoration: InputDecoration( 
          border: const OutlineInputBorder(), 
          labelText: labelText,
        ),
      )
    );
  }
}


/// Checkboxes
class RegisterCheckbox extends StatelessWidget {
  const RegisterCheckbox({super.key, required this.labelText});

  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: false,
          onChanged: (value) {  },
        ),
        Text(labelText)
      ],
    );
  }
}


/// Register portion
class RegisterSentence extends StatelessWidget {
  const RegisterSentence({super.key,});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: 
        Row( 
          mainAxisAlignment: MainAxisAlignment.center,
          children: [ 
            const Text("Don't have an account? "),
            Padding( 
              padding: const EdgeInsets.only(left:1.0), 
              child: InkWell(
                onTap: () { }, 
                child: const Text('Register', style: TextStyle(fontSize: 14, color: Colors.blue))
              )
            )
          ],
        )
    );
  }
}


/// Create account button
class CreateAccountButton extends StatelessWidget {
  const CreateAccountButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox( 
      height: 65, 
      width: 360, 
      child: Padding( 
        padding: const EdgeInsets.only(top: 20.0), 
        child: TextButton( 
          child: const Text( 'Create Account', style: TextStyle(color: Colors.white, fontSize: 20)), 
          onPressed: () { }, 
        ), 
      ), 
    );
  }
}