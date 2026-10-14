import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../core/resources/app_constants.dart';
import '../../../core/resources/assets_manager.dart';
import '../../../core/resources/dialog_utiles.dart';
import '../../../core/resources/routes_manager.dart';
import '../../../core/resources/strings_manager.dart';
import '../../../core/reusable_components/custom_button.dart';
import '../../../core/reusable_components/custom_field.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late TextEditingController emailController;
  late TextEditingController passController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController = TextEditingController();
    passController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          AssetsManager.logo,
          color: Theme.of(context).colorScheme.primary,
          width: screenWidth * 0.45,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(17),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  StringsManager.loginTitle,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 24),
                CustomField(
                  validation: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email can't empty";
                    }
                    if (!RegExp(AppConstants.emailRegex).hasMatch(value)) {
                      return "Invalid email";
                    }
                    return null;
                  },
                  hint: "Enter your email",
                  prefixPath: AssetsManager.email,
                  controller: emailController,
                  keyboard: TextInputType.emailAddress,
                ),
                SizedBox(height: 16),
                CustomField(
                  validation: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password can't be empty";
                    }
                    if (value.length < 8) {
                      return "Password can't be less than 8 characters";
                    }
                    return null;
                  },
                  isPassword: true,
                  hint: "Enter your password",
                  prefixPath: AssetsManager.lock,
                  controller: passController,
                  keyboard: TextInputType.text,
                ),
                SizedBox(height: 8),
                TextButton(
                  onPressed: () {},
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Forgot password?",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                ),
                SizedBox(height: 48),
                CustomButton(
                  title: "Login",
                  onClick: () {
                    if (formKey.currentState?.validate() ?? false) {
                      SignIn();
                    }
                  },
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(fontSize: 14),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      onPressed: () {
                        Navigator.of(context).pushNamed(RoutesManager.signup);
                      },
                      child: Text(
                        "Sign Up",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  SignIn() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passController.text,
      );
      Navigator.of(context).pop;
      Navigator.of(context).pushNamed(RoutesManager.home);
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop;

      if (e.code == 'user-not-found') {
        DialogUtiles.showMessageDialog(context: context, content: 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        DialogUtiles.showMessageDialog(context: context, content: 'Wrong password provided for that user.');
      }
    }
  }
}
