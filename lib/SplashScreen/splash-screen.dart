import 'dart:async';

import 'package:fix_go/Auth/login-screen.dart';
import 'package:fix_go/SplashScreen/OnBoarding/boarding-screen.dart';
import 'package:fix_go/SplashScreen/provider/check-user.dart';
import 'package:fix_go/SplashScreen/provider/finish-onboarding.dart';
import 'package:fix_go/constants/photos/photos.dart';
import 'package:fix_go/home/home-screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:road_mate/theme/app-colors.dart';
// import 'package:recycling_app/home-screen.dart'; // Import HomeScreen

class SplashScreen extends StatefulWidget {
  static const String routeName = 'splash-screen';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Remove the Provider access from initState
    // Delay navigation to allow context to be ready
    Future.delayed(Duration.zero, () {
      navigateToNextScreen();
    });
  }

  void navigateToNextScreen() {
    var provider = Provider.of<FinishOnboarding>(context, listen: false);
    var user = Provider.of<CheckUser>(context,
        listen: false); // Updated to listen: false

    Timer(const Duration(seconds: 10), () {
      print(
          "000000000000000000000000000000000000000000000000000000${provider.isOnBoardingCompleted}");

      Navigator.pushReplacementNamed(
        context,
        user.firebaseUser != null
            ? HomeScreen.routeName
            : provider.isOnBoardingCompleted
                ? LoginPage.routeName
                : OnboardingScreen.routeName,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen height and width for responsive design
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(height: size.height * 0.08),
                  Image.asset(
                    Photos.loading,
                    height: size.height * 0.4,
                  ),
                  SizedBox(height: size.height * 0.08),
                  Text(
                    "Welcome to Fix & Go",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  Text(
                    "We care about Safety",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
