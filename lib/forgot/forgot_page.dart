
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class ForgotPage extends StatelessWidget {
  const ForgotPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column( 
        children: [ 
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                //icon: const Icon(Icons.arrow_back), 
                icon: SvgPicture.asset(
                  "assets/icons/arrow back - white.svg",
                  height: 25,
                  width: 25,
                ),
                onPressed: () { Navigator.pop(context); }
              ),
            ],
          ),
          const Padding( 
            padding: EdgeInsets.all(20),
            child: SizedBox(
              width: 400,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Trouble signing in?",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 30),
                    child: Text(
                      "Enter the email associated with your account and we'll send you a link to reset your password.",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400))
                  )
                ],
              )
            )
          ), 
          const Padding( 
            padding: EdgeInsets.symmetric(horizontal: 30), 
            child: TextField( 
              decoration: InputDecoration( 
                labelText: 'Email, username, or mobile phone'
              )
            ), 
          ), 
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: FractionallySizedBox(
                widthFactor: 0.8,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30), 
                  child: TextButton( 
                    child: const Text( 'Recover Password', style: TextStyle(color: Colors.white, fontSize: 20)), 
                    onPressed: () { }, 
                  )
                ), 
              ),
            )
          )
        ], 
      ));
  }
}