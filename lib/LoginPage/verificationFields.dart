import 'package:flutter/material.dart';
import 'package:sign_checker/LoginPage/passwordField.dart';

class VerificationFields extends StatefulWidget {
  const VerificationFields({super.key, required this.onValueChanged});
  final Function(String, String) onValueChanged;

  @override
  _VerificationFieldsState createState() => _VerificationFieldsState();
}

class _VerificationFieldsState extends State<VerificationFields> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailController.addListener(emailChanged);
  }

  void emailChanged() {
    final email = _emailController.text;
    widget.onValueChanged('email', email);
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(143, 148, 251, .2),
            blurRadius: 20.0,
            offset: Offset(0, 10),
          )
        ],
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color.fromARGB(255, 214, 207, 207),
                ),
              ),
            ),
            child: TextField(
              controller: _emailController,
              cursorColor: Colors.purpleAccent,
              style: const TextStyle(color: Color.fromRGBO(143, 148, 251, 1)),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Email or Phone number",
                hintStyle: TextStyle(color: Colors.grey[400]),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: PasswordField(onPasswordChanged: (newPassword) {
              widget.onValueChanged('password', newPassword);
            }),
          )
        ],
      ),
    );
  }
}
