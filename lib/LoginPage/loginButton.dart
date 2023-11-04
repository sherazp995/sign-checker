import 'package:flutter/material.dart';
import 'package:sign_checker/HomePage/cameraPage.dart';
import 'package:camera/camera.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 100,
      child: ElevatedButton(
        onPressed: () async {
          await availableCameras().then((value) => Navigator.push(context,
              MaterialPageRoute(builder: (_) => CameraPage(cameras: value))));
        },
        child: Ink(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color.fromRGBO(143, 148, 251, 1),
                Color.fromRGBO(143, 148, 251, .6),
              ],
            ),
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: const Center(
            child: Text(
              "Login",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
