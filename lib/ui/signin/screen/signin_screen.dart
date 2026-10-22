import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../core/resources/app_constants.dart';
import '../../../core/resources/assets_manager.dart';
import '../../../core/resources/colors_manager.dart';
import '../../../core/resources/dialog_utiles.dart';
import '../../../core/resources/routes_manager.dart';
import '../../../core/resources/strings_manager.dart';
import '../../../core/reusable_components/custom_button.dart';
import '../../../core/reusable_components/custom_field.dart';
import '../../../model/user.dart';

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
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    bool isDarkMode = Theme
        .of(context)
        .brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          AssetsManager.logo,
          color: Theme
              .of(context)
              .colorScheme
              .primary,
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
                  style: Theme
                      .of(context)
                      .textTheme
                      .labelSmall
                      ?.copyWith(
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
                      style: Theme
                          .of(context)
                          .textTheme
                          .titleSmall,
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
                      style: Theme
                          .of(
                        context,
                      )
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontSize: 14),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      onPressed: () {
                        Navigator.of(context).pushNamed(RoutesManager.signup);
                      },
                      child: Text(
                        "Sign Up",
                        style: Theme
                            .of(context)
                            .textTheme
                            .titleSmall,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: isDarkMode
                            ? ColorsManager.darkFieldBorderColor
                            : ColorsManager.lightFieldBorderColor,
                        thickness: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        "Or",
                        style: TextStyle(
                          color: isDarkMode
                              ? ColorsManager.darkPrimary
                              : ColorsManager.lightPrimary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: isDarkMode
                            ? ColorsManager.darkFieldBorderColor
                            : ColorsManager.lightFieldBorderColor,
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      signInWithGoogle();
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: isDarkMode
                            ? ColorsManager.darkFieldBorderColor
                            : ColorsManager.lightFieldBorderColor,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    icon: Image.asset(
                      AssetsManager.google,
                      height: 24,
                      width: 24,
                    ),
                    label: Text(
                      "Login with Google",
                      style: TextStyle(
                        color: Theme
                            .of(context)
                            .colorScheme
                            .primary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
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
      Navigator
          .of(context)
          .pop;
      Navigator.of(context).pushNamed(RoutesManager.home);
    } on FirebaseAuthException catch (e) {
      Navigator
          .of(context)
          .pop;

      if (e.code == 'user-not-found') {
        DialogUtils.showMessageDialog(
          context: context,
          content: 'No user found for that email.',
        );
      } else if (e.code == 'wrong-password') {
        DialogUtils.showMessageDialog(
          context: context,
          content: 'Wrong password provided for that user.',
        );
      }
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      print("Initializing Google Sign In...");
      final GoogleSignIn googleSignIn = GoogleSignIn.instance;

      // Initialize with your Web Client ID
      await googleSignIn.initialize(
        serverClientId: '447892618722-5acd28mrfc3vkrme4nj277k88nionage.apps.googleusercontent.com',
      );

      print("Opening Google account picker...");
      final GoogleSignInAccount? googleUser = await googleSignIn.authenticate();

      if (googleUser == null) {
        print("Google Sign-In was cancelled by the user.");
        return;
      }

      print("Getting auth details for: ${googleUser.email}");
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Pass only idToken for the current google_sign_in package version
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      print("Signing into Firebase with Google credential...");
      final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      final firebaseUser = userCredential.user;

      if (firebaseUser != null) {
        print("Firebase user signed in successfully: ${firebaseUser.uid}");

        MyUser user = MyUser(
          id: firebaseUser.uid,
          name: firebaseUser.displayName ?? "",
          email: firebaseUser.email ?? "",
        );

        // Save user to Firestore under the "Users" collection
        await FirebaseFirestore.instance
            .collection(MyUser.collectionName)
            .doc(user.id)
            .set(user.toFireStore());

        print("User saved to Firestore. Navigating to home...");

        if (!mounted) return;
        Navigator.of(context).pushReplacementNamed(RoutesManager.home);
      }
    } catch (e) {
      print("Error in signInWithGoogle: $e");
      if (!mounted) return;
      DialogUtils.showMessageDialog(context: context, content: e.toString());
    }
  }
}