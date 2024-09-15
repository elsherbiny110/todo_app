import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/core/models/user_model.dart';
import 'package:todo_app/core/service/firebase_functions.dart';

import '../../layout/layout.dart';

class AuthProvider extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  UserCredential? userCredential;
  UserModel? user;
  bool isSecure = true;
  changeSecure() {
    isSecure = !isSecure;
    notifyListeners();
  }

  createAccount(BuildContext context) async {
    UserCredential credential = await FireBaseFunctions.createAccount(
        emailController.text,
        passwordController.text,
        nameController.text,
        phoneController.text);
    if (credential.user != null) {
      Navigator.pushNamedAndRemoveUntil(
          context, LayoutScreen.routeName, (route) => false);
    }
  }

  login(BuildContext context) async {
    try {
      userCredential = await FireBaseFunctions.login(
          emailController.text, passwordController.text);
      if (userCredential?.user != null) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          LayoutScreen.routeName,
          (route) => false,
        );
        user = await FireBaseFunctions.getUser();
        final snackBar = SnackBar(
          elevation: 0,
          duration: Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Welcome',
            message: "Welcome back ${user!.name}",
            contentType: ContentType.success,
          ),
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    } catch (e) {
      final snackBar = SnackBar(
        elevation: 0,
        duration: Duration(seconds: 3),
        behavior: SnackBarBehavior.fixed,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'oh no!',
          message: "Email or Password is incorrect",
          contentType: ContentType.failure,
        ),
      );

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }

    notifyListeners();
  }
}
