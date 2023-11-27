
import 'package:flutter/material.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView( 
      child: Column( 
        children: [ 
          const Padding( 
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
          ), 
          const Padding( 
            padding: EdgeInsets.symmetric(horizontal: 15), 
            child: TextField( 
              decoration: InputDecoration( 
                  border: OutlineInputBorder(), 
                  labelText: 'Email, username, or mobile phone', 
                  hintText: 'Enter valid email id as abc@gmail.com'), 
            ), 
          ), 
          const Padding( 
            padding: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15), 
            child: TextField( 
              obscureText: true, 
              decoration: InputDecoration( 
                  border: OutlineInputBorder(), 
                  labelText: 'Password'
              ), 
            ), 
          ), 
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
          ), 
          SizedBox( 
            height: 65, 
            width: 360, 
            child: Padding( 
              padding: const EdgeInsets.only(top: 20.0), 
              child: TextButton( 
                child: const Text( 'Sign In ', style: TextStyle(color: Colors.white, fontSize: 20)), 
                onPressed: () { }, 
              ), 
            ), 
          ), 
        ], 
      ),
    );
  }
}