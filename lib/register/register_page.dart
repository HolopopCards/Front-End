
import 'package:flutter/material.dart';
import 'package:holopop/login/login_page.dart';
import 'package:holopop/shared/providers/auth_provider.dart';
import 'package:holopop/shared/providers/user_provider.dart';
import 'package:provider/provider.dart';


class RegisterFormModel {
  String? name;
  String? phone;
  String? email;
  DateTime? dateTime;
  String? password;
  String? confirmPassword;
  bool? agreePrivacy;
  bool? agreeTerms;
}


class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterPage();
}


class _RegisterPage extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();

  RegisterFormModel registerForm = RegisterFormModel();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Text("Let's get started", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            ),
            RegisterTextField(labelText: "Name", onSaved: (x) => registerForm.name = x),
            RegisterTextField(labelText: "Mobile Phone", onSaved: (x) => registerForm.phone = x),
            RegisterTextField(labelText: "Email Address", onSaved: (x) => registerForm.email = x),
            // RegisterTextField(labelText: "Date Of Birth", onSaved: (x) => registerForm.dateTime = x),
            RegisterTextField(labelText: "Password", obscureText: true, onSaved: (x) => registerForm.password = x),
            RegisterTextField(labelText: "Confirm Password", obscureText: true, onSaved: (x) => registerForm.confirmPassword = x),
            RegisterCheckbox(labelText: "Agree with Privacy Policy", onChanged: (x) => registerForm.agreePrivacy = x),
            RegisterCheckbox(labelText: "Agree with Terms and Conditions", onChanged: (x) => registerForm.agreeTerms = x),
            const RegisterSentence(),
            SizedBox( 
              height: 65, 
              width: 360, 
              child: Padding( 
                padding: const EdgeInsets.only(top: 20.0), 
                child: TextButton( 
                  child: const Text( 'Create Account', style: TextStyle(color: Colors.white, fontSize: 20)), 
                  onPressed: () {
                    final form = formKey.currentState;
                    print(form);
                    if (form!.validate()) {
                      form.save();
                      register(registerForm);
                    }
                    //TODO: VALIDATE
                  }, 
                ), 
              ), 
            )
            // const CreateAccountButton(), 
          ],
        ),
      )
    );
  }

  void register(RegisterFormModel registerForm) {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    auth.register(
      registerForm.name!,
      registerForm.phone!,
      DateTime.now(),
      registerForm.email!,
      registerForm.password!)
      .then((res) {
        if (res.success) {
          final user = res.value!;
          Provider.of<UserProvider>(context, listen: false).setUser(user);
          Navigator.pushNamed(context, "/");
        } else {
          print("form is invalid");
        }
      });
  }
}


/// Text fields
class RegisterTextField extends StatelessWidget {
  const RegisterTextField({
    super.key,
    required this.labelText,
    required this.onSaved,
    this.obscureText = false
  });

  final String labelText;
  final Function(String?) onSaved;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.5), 
      child: TextFormField( 
        onSaved: onSaved,
        obscureText: obscureText,
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
  const RegisterCheckbox({
    super.key,
    required this.labelText,
    required this.onChanged
  });

  final String labelText;
  final Function(bool?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: false,
          onChanged: onChanged,
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
            const Text("Already have an account? "),
            Padding( 
              padding: const EdgeInsets.only(left:1.0), 
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => const Scaffold(body: LoginPage())
                  ));
                }, 
                child: const Text('Sign in', style: TextStyle(fontSize: 14, color: Colors.blue))
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