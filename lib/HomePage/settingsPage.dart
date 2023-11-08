import 'package:flutter/material.dart';
import 'package:sign_checker/HomePage/profileUpdatePage.dart';
import 'package:sign_checker/HomePage/stateSelectionPage.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});

  final Map<String, Widget> routes = {
    'Change Your State': const StateSelectionPage(redirectBack: true),
    'Update Profile': const ProfileUpdatePage(),
    // 'Payment Page': PaymentPage(),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: ListView(
        children: routes.entries.map((entry) {
          final routeName = entry.key;
          final routeWidget = entry.value;
          return RouteBlock(
            title: routeName,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => routeWidget));
            },
          );
        }).toList(),
      ),
    );
  }
}

class RouteBlock extends StatelessWidget {
  const RouteBlock({super.key, required this.title, required this.onPressed});

  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}

