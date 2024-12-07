import 'package:firebase_core/firebase_core.dart';
import 'package:fix_go/Auth/login-screen.dart';
import 'package:fix_go/Auth/signup-screen.dart';
import 'package:fix_go/SplashScreen/OnBoarding/boarding-screen.dart';
import 'package:fix_go/SplashScreen/provider/check-user.dart';
import 'package:fix_go/SplashScreen/provider/finish-onboarding.dart';
import 'package:fix_go/SplashScreen/splash-screen.dart';
import 'package:fix_go/firebase_options.dart';
import 'package:fix_go/home/home-screen.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

bool isConnectdet = false;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase with error handling
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print('Error initializing Firebase: $e');
  }

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => FinishOnboarding()),
      ChangeNotifierProvider(create: (_) => CheckUser()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => SplashScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        OnboardingScreen.routeName: (context) => OnboardingScreen(),
        LoginPage.routeName: (context) => LoginPage(),
        SignUpPage.routeName: (context) => SignUpPage(),
      },
    );
  }
}
