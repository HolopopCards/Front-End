
import 'package:flutter/material.dart';
import 'package:holopop/login/login_page.dart';
import 'package:holopop/register/widgets/privacy_checkbox.dart';
import 'package:holopop/register/widgets/terms_of_service_checkbox.dart';
import 'package:holopop/shared/providers/auth_provider.dart';
import 'package:holopop/shared/providers/user_provider.dart';
import 'package:holopop/shared/validation/register_validator.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';


class RegisterFormModel {
  String? name;
  String? phone;
  String? email;
  DateTime? dateTime;
  String? password;
  String? confirmPassword;
  bool agreePrivacy = false;
  bool agreeTerms = false;

  @override
  String toString() {
    return '''$name|$phone|$email|$dateTime|$password|$confirmPassword|$agreePrivacy|$agreeTerms''';
  }
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
    return SingleChildScrollView(
      child: Padding(
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
              RegisterTextField(labelText: "Name", onChanged: (x) => registerForm.name = x, validator: RegisterValidator().validateName),
              RegisterTextField(labelText: "Mobile Phone", onChanged: (x) => registerForm.phone = x, validator: RegisterValidator().validatePhone),
              RegisterTextField(labelText: "Email Address", onChanged: (x) => registerForm.email = x, validator: RegisterValidator().validateEmail),
              DateTimeField(labelText: "Date Of Birth", onChanged: (x) => registerForm.dateTime = x),
              RegisterTextField(labelText: "Password", obscureText: true, onChanged: (x) => registerForm.password = x, validator: RegisterValidator().validatePassword),
              RegisterTextField(labelText: "Confirm Password", obscureText: true, onChanged: (x) => registerForm.confirmPassword = x, validator: (v) { return RegisterValidator().validateConfirmPassword(v, registerForm.password);}),
              PrivacyCheckbox(value: registerForm.agreePrivacy, onChanged: (x) => registerForm.agreePrivacy = x ?? false),
              TermsCheckbox(value: registerForm.agreeTerms, onChanged: (x) => registerForm.agreeTerms = x ?? false),
              Column(
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
                          // Validate form
                          if (form!.validate()) {
                            // Toast if checkboxes aren't checked.
                            if (registerForm.agreePrivacy == false || registerForm.agreeTerms == false) {
                              toastification.show(
                                context: context,
                                title: const Text("Please agree to the privacy policy and terms and conditions."), 
                                type: ToastificationType.error,
                              );
                              return;
                            } 

                            toastification.dismissAll();
                            form.save();
                            register(registerForm);
                          }
                        }, 
                      ), 
                    ), 
                  )
                ]
              )
            ],
          ),
        )
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
    required this.onChanged,
    this.validator,
    this.obscureText = false
  });

  final String labelText;
  final Function(String?) onChanged;
  final String? Function(String?)? validator;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.5), 
      child: TextFormField( 
        onChanged: onChanged,
        validator: validator,
        obscureText: obscureText,
        decoration: InputDecoration( 
          labelText: labelText,
        ),
      )
    );
  }
}

class DateTimeField extends StatelessWidget {
  const DateTimeField ({
    super.key,
    required this.labelText,
    required this.onChanged,
    this.validator,
    this.obscureText = false
  });

  final String labelText;
  final Function(DateTime?) onChanged;
  final String? Function(String?)? validator;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.5), 
      child: InputDatePickerFormField(
        firstDate: DateTime(1900),
        lastDate: DateTime(2024),
        fieldLabelText: "Date of Birth",
        keyboardType: TextInputType.datetime,
        errorInvalidText: "Invalid format (MM/DD/YYYY)",
        onDateSaved: onChanged,
        acceptEmptyDate: false,
      )
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