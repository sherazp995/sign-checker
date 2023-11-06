import 'package:sign_checker/Core/apiClient.dart';
import 'package:sign_checker/LoginPage/passwordField.dart';
import 'package:flutter/material.dart';
import 'package:sign_checker/LoginPage/signupButton.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  Map<String, dynamic> registerData = {};
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final _apiClient = ApiClient();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        children: <Widget>[
          Container(
            child: Container(
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
                          color: Color.fromARGB(255, 214, 191, 191),
                        ),
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          controller: _firstNameController,
                          cursorColor: Colors.purpleAccent,
                          style: const TextStyle(
                              color: Color.fromRGBO(143, 148, 251, 1)),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "First Name",
                            hintStyle: TextStyle(color: Colors.grey[400]),
                          ),
                        ),
                        TextField(
                          controller: _lastNameController,
                          cursorColor: Colors.purpleAccent,
                          style: const TextStyle(
                              color: Color.fromRGBO(143, 148, 251, 1)),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Last Name",
                            hintStyle: TextStyle(color: Colors.grey[400]),
                          ),
                        ),
                        TextField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          cursorColor: Colors.purpleAccent,
                          style: const TextStyle(
                              color: Color.fromRGBO(143, 148, 251, 1)),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Email address",
                            hintStyle: TextStyle(color: Colors.grey[400]),
                          ),
                        ),
                        PasswordField(
                            onPasswordChanged: (password) {
                              registerData['password'] = password;
                            }
                        ),
                        PasswordField(
                            onPasswordChanged: (confirmPassword) {
                              registerData['confirmPassword'] = confirmPassword;
                            }
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          SignupButton(
            onSubmit: () async {
              registerData['email'] = _emailController.text;
              registerData['firstName'] = _firstNameController.text;
              registerData['lastName'] = _lastNameController.text;
              final res = await _apiClient.register(registerData);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(res["message"]),
              ));
            },
          ),
        ],
      ),
    );
  }
}
