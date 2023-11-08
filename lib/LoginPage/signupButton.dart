import 'package:flutter/material.dart';

class SignupButton extends StatelessWidget {
  const SignupButton({super.key, required this.onSubmit, this.hintText = ''});
  final Future<dynamic> Function() onSubmit;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 100,
      child: ElevatedButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            EdgeInsets.zero,
          ),
        ),
        onPressed: onSubmit,
        child: Ink(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(143, 148, 251, 1),
                Color.fromRGBO(143, 148, 251, .6),
              ],
            ),
          ),
          child: Center(
            child: Text(
              hintText.isEmpty ? "SignUp" : hintText,
              style: const TextStyle(
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
