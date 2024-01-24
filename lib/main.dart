import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:holopop/home_page.dart';
import 'package:holopop/shared/firebase/firebase_options.dart';
import 'package:holopop/shared/firebase/firebase_provider.dart';
import 'package:holopop/shared/providers/auth_provider.dart';
import 'package:flutter/services.dart';
import 'package:holopop/shared/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'shared/styles/holopop_theme.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Global Configuration
  await GlobalConfiguration().loadFromPath("configs/appsettings.json");
  
  // Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack); //Fullscreen
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => FirebaseProvider())
      ],
      child: MaterialApp(
        title: 'HoloPop',
        theme: HolopopTheme().getTheme(),
        home: const HomePage(),
        debugShowCheckedModeBanner: false,
      )
    );
  }
}