
import 'package:flutter/material.dart';
import 'package:holopop/forgot/forgot_page.dart';
import 'package:holopop/register/register_page.dart';
import 'package:holopop/shared/providers/auth_provider.dart';
import 'package:holopop/shared/providers/user_provider.dart';
import 'package:holopop/shared/styles/holopop_colors.dart';
import 'package:holopop/shared/validation/login_validator.dart';
import 'package:provider/provider.dart';


/// Core widget
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();

  String? username;
  String? password;


  @override
  Widget build(BuildContext context) {
    const double leftRightPadding = 20;

    return 
      Padding(
        padding: const EdgeInsets.fromLTRB(leftRightPadding, 30, leftRightPadding, 0),
        child: Form(
          key: formKey,
          child: Column( 
            children: [ 
              const Header(), 
              LoginField(
                validator: LoginValidator().validateUsername,
                onSaved: (value) => username = value,
                labelText: 'Email, username, or mobile phone', 
                hintText: 'Enter valid email id as abc@gmail.com'
              ),
              LoginField(
                validator: LoginValidator().validatePassword,
                onSaved: (value) => password = value,
                obscureText: true,
                labelText: "Password",
                suffixIcon: IconButton(
                  icon: const Icon(Icons.help_outline),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => const Scaffold(body: ForgotPage())
                    ));
                   },
                )
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(15, 0, 15, 10),
                child: Row(
                  children: [
                    Expanded(child: Divider(color: HolopopColors.darkgrey)),
                    Text("  OR  ", style: TextStyle(color: HolopopColors.darkgrey)),
                    Expanded(child: Divider(color: HolopopColors.darkgrey))
                  ],
                )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SsoButton(iconData: Icons.circle, onPressed: () { }),
                  SsoButton(iconData: Icons.circle, onPressed: () { }),
                  SsoButton(iconData: Icons.circle, onPressed: () { }),
                ],
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end, 
                  children: [
                    const Register(), 
                    FractionallySizedBox( 
                      widthFactor: 0.9,
                      child: Padding( 
                        padding: const EdgeInsets.only(bottom: 40.0), 
                        child: TextButton( 
                          child: const Text( 'Sign In ', style: TextStyle(color: Colors.white, fontSize: 20)), 
                          onPressed: () {
                            final form = formKey.currentState;
                            if (form!.validate()) {
                              form.save();
                              login(username!, password!); 
                            }
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

  void login(String username, String password) {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    auth.login(username, password)
      .then((res) {
        if (res.success) {
          final user = res.value!;
          Provider.of<UserProvider>(context, listen: false).setUser(user);
          Navigator.pushNamed(context, "/");
        } else {
          print(res.error);
          print("form is invalid");
        }
      });
  }
}


/// Big 'let's sign you in' header.
class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding( 
      padding: EdgeInsets.fromLTRB(20, 110, 20, 0), 
      child: SizedBox(
        width: 400,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Let's sign you in.",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 30),
              child: Text(
                "Welcome back\nYou've been missed!",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400))
            )
          ],
        )
      )
    );
  }
}


/// Text fields.
class LoginField extends StatelessWidget {
  const LoginField({
    super.key,
    required this.labelText,
    required this.onSaved,
    this.hintText = "",
    this.autoFocus = false,
    this.obscureText  = false,
    this.suffixIcon,
    this.validator
  });

  final Function(String?) onSaved;
  final String? Function(String?)? validator;
  final String labelText;
  final String hintText;
  final bool obscureText;
  final bool autoFocus;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: TextFormField(
        onSaved: onSaved,
        validator: validator,
        autofocus: autoFocus,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          suffixIcon: suffixIcon
        ),
      )
    );
  }
}


class SsoButton extends StatelessWidget {
  const SsoButton({super.key, required this.onPressed, required this.iconData});

  final IconData iconData;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: IconButton(
        icon: Icon(iconData), 
        onPressed: onPressed),
    );
  }
}


/// Little register reminder bit.
class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {

    return Row( 
      mainAxisAlignment: MainAxisAlignment.center,
      children: [ 
        const Text("Don't have an account? "),
        Padding( 
          padding: const EdgeInsets.symmetric(vertical: 20), 
          child: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => const Scaffold(body: RegisterPage())
              ));
            }, 
            child: const Text('Register', style: TextStyle(fontSize: 14, color: Colors.blue))
          )
        )
      ],
    );
  }
}