import 'package:flutter/material.dart';

class LoginDecoration extends StatelessWidget {
  const LoginDecoration({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          Positioned(
            child: Container(
              margin: const EdgeInsets.only(top: 30),
              child: const Center(
                child: Text(
                  "Logo",
                  style: TextStyle(
                      color: Color.fromRGBO(143, 148, 251, 1),
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
