import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_webapi_first_course/screens/common/confirmation_dialog.dart';
import 'package:flutter_webapi_first_course/screens/common/exception_dialog.dart';
import 'package:flutter_webapi_first_course/services/auth_service.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final AuthService service = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.all(32),
        decoration:
            BoxDecoration(border: Border.all(width: 8), color: Colors.white),
        child: Form(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Icon(
                    Icons.bookmark,
                    size: 64,
                    color: Colors.brown,
                  ),
                  const Text(
                    "Simple Journal",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const Text("by Alura",
                      style: TextStyle(fontStyle: FontStyle.italic)),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Divider(thickness: 2),
                  ),
                  const Text("Sign in or Sign up"),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      label: Text("Email"),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(label: Text("Password")),
                    keyboardType: TextInputType.visiblePassword,
                    maxLength: 16,
                    obscureText: true,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        login(context);
                      },
                      child: const Text("Continue")),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  login(BuildContext context) {
    String email = _emailController.text;
    String password = _passwordController.text;

    service.login(email: email, password: password).then(
      (resultLogin) {
        if (resultLogin) {
          Navigator.pushReplacementNamed(context, "home");
        }
      },
    ).catchError(
      (error) {
        var innerError = error as HttpException;
        showExceptionDialog(context, content: innerError.message);
      },
      test: (error) => error is HttpException,
    ).catchError((error) {
      showConfirmationDialog(context,
              content:
                  "Do you want to register a new user with the email $email?",
              affirmativeOption: "REGISTER")
          .then((value) {
        if (value != null && value) {
          service
              .register(email: email, password: password)
              .then((resultRegister) {
            if (resultRegister) {
              Navigator.pushReplacementNamed(context, "home");
            }
          });
        }
      });
    }, test: (error) => error is UserNotFoundException).catchError(
      (error) {
        showExceptionDialog(context,
            content:
                "The server is taking too long to answer. Try again later.");
      },
      test: (error) => error is TimeoutException,
    );
  }
}
