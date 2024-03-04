
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:holopop/forgot/forgot_page.dart';
import 'package:holopop/register/register_page.dart';
import 'package:holopop/shared/providers/auth_provider.dart';
import 'package:holopop/shared/providers/user_provider.dart';
import 'package:holopop/shared/styles/holopop_colors.dart';
import 'package:holopop/shared/validation/login_validator.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:toastification/toastification.dart';


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
                    Expanded(child: Divider(color: HolopopColors.darkGrey)),
                    Text("  OR  ", style: TextStyle(color: HolopopColors.darkGrey)),
                    Expanded(child: Divider(color: HolopopColors.darkGrey))
                  ],
                )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SsoButton(iconPath: "assets/icons/login - google.svg", 
                    onPressed: () { 
                      try {
                        Logger('Login').info("Logging in through Google...");
                        GoogleSignIn(clientId: "314163482556-vb6fa4pbk1iku60rmsqkikjrteju3h9s.apps.googleusercontent.com").signIn()
                          .then(loginWithGoogle);
                      } catch (e) {
                        Logger('Login').severe("Issue logging in: ${e.toString()}");
                        toastification.show(
                          context: context,
                          title: Text("Error logging in through Google: ${e.toString()}"), 
                          type: ToastificationType.error,
                        );
                      }
                    }),
                  // SsoButton(iconPath: "assets/icons/login - facebook.svg", onPressed: () async { }),
                  // SsoButton(iconPath: "assets/icons/login - apple.svg", onPressed: () async { }),
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
    auth.loginWithEmail(username, password)
      .then((res) {
        if (res.success) {
          final user = res.value!;
          Provider.of<UserProvider>(context, listen: false).setUser(user);
          Navigator.pushNamed(context, "/");
        } else {
          Logger('Login').severe("Login through password failed: ${res.error}");
        }
      });
  }

  void loginWithGoogle(GoogleSignInAccount? googleSignInAccount) {
    if (googleSignInAccount == null) {
      Logger('Login').severe("Failed to login via google because sign in account was unavailable.");
      return;
    }

    Logger('Login').info("Authenticating API with google token...");
    final auth = Provider.of<AuthProvider>(context, listen: false);
    googleSignInAccount.authentication.then((googleAuth) {
      return auth.loginWithGoogle(googleSignInAccount.email, googleAuth.idToken!)
        .then((res) {
          if (res.success) {
            final user = res.value!;
            Provider.of<UserProvider>(context, listen: false).setUser(user);
            Navigator.pushNamed(context, "/");
          } else {
            Logger('Login').severe("Login through google failed: ${res.error}");
          }
        });
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
  const SsoButton({super.key, required this.onPressed, required this.iconPath});

  final String iconPath;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.5),
      child: IconButton(
        // icon: Icon(iconData), 
        icon: SvgPicture.asset(iconPath), 
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