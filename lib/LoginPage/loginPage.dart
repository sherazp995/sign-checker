import 'package:flutter/material.dart';
import 'package:sign_checker/LoginPage/verificationFields.dart';
import 'package:sign_checker/LoginPage/loginButton.dart';
import 'package:sign_checker/LoginPage/signupPage.dart';
import 'package:sign_checker/LoginPage/loginDecoration.dart';
import 'package:sign_checker/HomePage/cameraPage.dart';
import 'package:sign_checker/Core/apiClient.dart';
import 'package:camera/camera.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.loggedIn});

  final bool loggedIn;
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _pageLogin = true;
  Map<String, dynamic> loginData = {};
  final _apiClient = ApiClient();

  void _togglePage(bool switchme) {
    setState(
      () {
        _pageLogin = switchme;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              const LoginDecoration(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(
                          _pageLogin
                              ? const Color.fromRGBO(143, 148, 251, 1)
                              : Colors.transparent),
                    ),
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: _pageLogin
                            ? Colors.white
                            : const Color.fromRGBO(143, 148, 251, 1),
                      ),
                    ),
                    onPressed: () {
                      _togglePage(true);
                    },
                  ),
                  TextButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(
                            _pageLogin
                                ? Colors.transparent
                                : const Color.fromRGBO(143, 148, 251, 1))),
                    child: Text(
                      "SignUp",
                      style: TextStyle(
                        color: _pageLogin
                            ? const Color.fromRGBO(143, 148, 251, 1)
                            : Colors.white,
                      ),
                    ),
                    onPressed: () {
                      _togglePage(false);
                    },
                  ),
                ],
              ),
              _pageLogin
                  ? Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        children: <Widget>[
                          VerificationFields(onValueChanged: (type, value) {
                            loginData[type] = value;
                          }),
                          Container(
                            alignment: const AlignmentDirectional(1.0, 0.0),
                            child: TextButton(
                              child: const Text(
                                "Forgot Password?",
                                style: TextStyle(
                                  color: Color.fromRGBO(143, 148, 251, 1),
                                ),
                              ),
                              onPressed: () => {},
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          LoginButton(onSubmit: () async {
                            final res = await _apiClient.login(loginData);
                            if (res["status"] == 200) {
                              await availableCameras().then((value) =>
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (_) =>
                                          CameraPage(cameras: value))));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(res["message"]),
                              ));
                            }
                          },),
                        ],
                      ),
                    )
                  : const SignupPage()
            ],
          ),
        ),
      ),
    );
  }
}
