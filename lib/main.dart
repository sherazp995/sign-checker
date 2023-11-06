import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:camera/camera.dart';
import 'package:sign_checker/LoginPage/loginPage.dart';
import 'package:sign_checker/HomePage/cameraPage.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  List<CameraDescription>? cameras;
  bool loggedIn;
  String? user;
  String? accessToken;
  // await dotenv.load(fileName: ".env");
  // Stripe.publishableKey = dotenv.env['STRIPE_PUBLISHABLE_KEY']!;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  user = prefs.getString('user');
  accessToken = prefs.getString('accessToken');
  loggedIn = (user != null &&
      accessToken != null &&
      user.isNotEmpty &&
      accessToken.isNotEmpty);

  if (loggedIn) {
    cameras = await availableCameras();
  }

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(loggedIn: loggedIn, cameras: cameras),
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.loggedIn, required this.cameras});
  final bool loggedIn;
  final dynamic cameras;

  @override
  Widget build(BuildContext context) {
    if (loggedIn) {
      return CameraPage(cameras: cameras);
    } else {
      return LoginPage(loggedIn: loggedIn);
    }
  }
}
