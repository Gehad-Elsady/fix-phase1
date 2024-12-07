import 'package:fix_go/Auth/login-screen.dart';
import 'package:fix_go/SplashScreen/OnBoarding/OnboardingPage1.dart';
import 'package:fix_go/SplashScreen/OnBoarding/OnboardingPage2.dart';
import 'package:fix_go/SplashScreen/OnBoarding/OnboardingPage3.dart';
import 'package:fix_go/SplashScreen/provider/finish-onboarding.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import 'package:recycling_app/home-screen.dart';

class OnboardingScreen extends StatefulWidget {
  static const String routeName = 'onboarding-screen';

  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<FinishOnboarding>(context);
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Stack(
          children: [
            // PageView to swipe through onboarding pages
            PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              children: [
                OnboardingPage1(), // First page
                OnboardingPage2(), // Second page
                OnboardingPage3(), // Third page
              ],
            ),

            // Skip button at the top right
            Positioned(
              top: 40,
              right: 20,
              child: GestureDetector(
                onTap: () {
                  provider..completeOnBoarding();
                  print(
                      "00000000000000000000000000000000000000000000000000${provider.isOnBoardingCompleted}");
                  Navigator.pushReplacementNamed(context, LoginPage.routeName);
                },
                child: Text(
                  'skip',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // Bottom navigation buttons
            Positioned(
              bottom: 30,
              left: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Page indicator dots
                  Row(
                    children: List.generate(
                      3, // Total number of pages
                      (index) => _buildIndicator(index == _currentIndex),
                    ),
                  ),
                  // Next or Get Started button
                  GestureDetector(
                    onTap: () {
                      if (_currentIndex == 2) {
                        // Last page
                        provider..completeOnBoarding();
                        print(
                            "00000000000000000000000000000000000000000000000000${provider.isOnBoardingCompleted}");
                        Navigator.pushReplacementNamed(
                            context, LoginPage.routeName);
                      } else {
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                      }
                    },
                    child: Text(
                      _currentIndex == 2 ? 'get-started' : 'next',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
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

  // Page indicator for the dots at the bottom
  Widget _buildIndicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: 8,
      width: isActive ? 10 : 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.blue : Colors.blue[900],
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
