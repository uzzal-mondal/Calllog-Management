import 'dart:async';
import 'package:call_log_management/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final AnimationController _imageController;
  late final Animation<Offset> _imageAnimation;
  late final Animation<double> _textAnimation;

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color(0xF5123000),
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..forward().then((_) => _navigateToLogin());

    _textAnimation = Tween<double>(
      begin: 0.4,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInCubic));

    _imageController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..forward();

    _imageAnimation = Tween<Offset>(begin: Offset(0, -1), end: Offset.zero)
        .animate(
          CurvedAnimation(parent: _imageController, curve: Curves.easeInCubic),
        );
  }

  void _navigateToLogin() {
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
      //context.pushReplacementToPage(Pages.login);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    return Scaffold(
      //backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: screenHeight * 0.09,
            ), // Use percentage of screen height
            Center(
              child: SlideTransition(
                position: _imageAnimation,
                // child: Image.asset(
                //   'assets/images/logo.png',
                //   width: 250,
                //   height: 250,
                //  // height: screenHeight * 0.22, // Responsive image height
                //  // width: screenWidth * 0.9, // Responsive image width
                // ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.05,
            ), // Use percentage of screen height
            ScaleTransition(
              scale: _textAnimation,
              child: Text(
                'Call Log Management',
                style: TextStyle(
                  fontSize: 30,
                  // Set the font size
                  fontWeight: FontWeight.bold,
                  // Set the font weight
                  color: Colors.black,
                ),
              ),
            ),
            const Spacer(),
            CircularProgressIndicator(
              backgroundColor: Colors.white,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.black),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _imageController.dispose();
    super.dispose();
  }
}
