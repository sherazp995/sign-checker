import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({super.key, required this.onPasswordChanged});
  final Function(String) onPasswordChanged;

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _ishidden = true;
  final TextEditingController _passwordEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _passwordEditingController.addListener(passwordChanged);
  }

  @override
  void dispose() {
    _passwordEditingController.dispose();
    super.dispose();
  }

  void passwordChanged() {
    final password = _passwordEditingController.text;
    widget.onPasswordChanged(password);
  }

  void _toggleVisibility() {
    setState(() {
        _ishidden = !_ishidden;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        controller: _passwordEditingController,
        obscureText: _ishidden ? true : false,
        style: const TextStyle(color: Color.fromRGBO(143, 148, 251, 1)),
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: Icon(_ishidden ? Icons.visibility_off : Icons.visibility),
            onPressed: _toggleVisibility,
          ),
          border: InputBorder.none,
          hintText: "Password",
          hintStyle: TextStyle(
            color: Colors.grey[400],
          ),
        ),
      ),
    );
  }
}
