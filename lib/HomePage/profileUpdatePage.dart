import 'package:flutter/material.dart';
import 'package:sign_checker/LoginPage/passwordField.dart';
import 'package:sign_checker/LoginPage/signupButton.dart';

class ProfileUpdatePage extends StatefulWidget {
  const ProfileUpdatePage({super.key});

  @override
  _ProfileUpdatePageState createState() => _ProfileUpdatePageState();
}

class _ProfileUpdatePageState extends State<ProfileUpdatePage> {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  Map<String, dynamic> data = {};

  Future<dynamic> updateProfile() async {
    data['firstName'] = _firstNameController.text;
    data['lastName'] = _lastNameController.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Update Profile',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: <Widget>[
            Container(
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
                        PasswordField(
                            hint: "Old Password",
                            onPasswordChanged: (password) {
                              data['oldPassword'] = password;
                            }),
                        PasswordField(
                            hint: "New Password",
                            onPasswordChanged: (confirmPassword) {
                              data['newPassword'] = confirmPassword;
                            }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SignupButton(
              hintText: "Update",
              onSubmit: updateProfile,
            ),
          ],
        ),
      ),
    );
  }
}
