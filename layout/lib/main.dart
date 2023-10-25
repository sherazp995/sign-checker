import 'package:flutter/material.dart';
import 'package:sign_checker/screens/register.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // String userId = prefs.getString('userId');
  // String userName = prefs.getString('userName');
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sign Checker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const RegisterScreen(),
    );
  }
}
