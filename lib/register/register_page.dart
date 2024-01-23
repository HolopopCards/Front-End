
import 'package:flutter/material.dart';
import 'package:holopop/dashboard/screens/settings/privacy_policy.dart';
import 'package:holopop/dashboard/screens/settings/terms_of_use.dart';
import 'package:holopop/login/login_page.dart';
import 'package:holopop/shared/providers/auth_provider.dart';
import 'package:holopop/shared/providers/user_provider.dart';
import 'package:holopop/shared/styles/holopop_colors.dart';
import 'package:provider/provider.dart';


class RegisterFormModel {
  String? name;
  String? phone;
  String? email;
  DateTime? dateTime;
  String? password;
  String? confirmPassword;
  bool agreePrivacy = false;
  bool agreeTerms = false;
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
            RegisterCheckbox(
              value: registerForm.agreePrivacy,
              onChanged: (x) => registerForm.agreePrivacy = x ?? false,
              textSpan: TextSpan(
                children: [
                  const TextSpan(text: "Agree with "),
                  TextSpan(
                    text: "Privacy Policy", 
                    style: const TextStyle(color: HolopopColors.blue), 
                    recognizer: TapAndPanGestureRecognizer()..onTapDown = (_) { Navigator.push(context, MaterialPageRoute(builder: (ctx) => const Scaffold(body: TermsOfUse()))) ;}
                  )
                ]
              )
            ),
            RegisterCheckbox(
              value: registerForm.agreeTerms,
              onChanged: (x) => registerForm.agreeTerms = x ?? false,
              textSpan: TextSpan(
                children: [
                  const TextSpan(text: "Agree with "),
                  TextSpan(
                    text: "Terms and Conditions",
                    style: const TextStyle(color: HolopopColors.blue),
                    recognizer: TapAndPanGestureRecognizer()..onTapDown = (_) { Navigator.push(context, MaterialPageRoute(builder: (ctx) => const Scaffold(body: PrivacyPolicy()))) ;}
                  )
                ]
              ),
            ),
            Expanded( 
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const RegisterSentence(),
                  FractionallySizedBox(
                    widthFactor: 0.9,
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
                ]
              )
            )
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
          labelText: labelText,
        ),
      )
    );
  }
}


/// Checkboxes
class RegisterCheckbox extends StatefulWidget {
  const RegisterCheckbox({
    super.key,
    required this.value,
    required this.onChanged, 
    required this.textSpan,
  });

  final bool value;
  final Function(bool?) onChanged;
  final TextSpan textSpan;

  @override
  State<StatefulWidget> createState() => _RegisterCheckbox();
}

class _RegisterCheckbox extends State<RegisterCheckbox> {
  late bool isChecked = widget.value;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: isChecked,
          onChanged: (x) {
            setState(() {
              widget.onChanged(x);
              isChecked = !isChecked;
            });
          },
        ),
        RichText(text: widget.textSpan)
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