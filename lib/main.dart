import 'package:evently/providers/theme_provider.dart';
import 'package:evently/ui/home/onboarding/onboarding_screen.dart';
import 'package:evently/ui/home/screen/home_screen.dart';
import 'package:evently/ui/signin/screen/signin_screen.dart';
import 'package:evently/ui/signup/screen/signup_screen.dart';
import 'package:evently/ui/start/screen/start_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/resources/app_theme.dart';
import 'core/resources/routes_manager.dart';
import 'package:evently/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool onBoarding = prefs.getBool('onBoarding') ?? false;
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) => ThemeProvider(),
      child: MyApp(onboarding: onBoarding),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool onboarding;

  const MyApp({super.key, required this.onboarding});

  @override
  Widget build(BuildContext context) {
    ThemeProvider provider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: provider.themeMode,
      routes: {
        RoutesManager.start: (context) => StartScreen(),
        RoutesManager.signup: (context) => SignupScreen(),
        RoutesManager.signIn: (context) => SignInScreen(),
        RoutesManager.home: (context) => HomeScreen(),
        RoutesManager.onboarding: (context) => OnboardingScreen(),
      },
      // If onboarding is true, it goes to log in
      initialRoute: onboarding ? RoutesManager.signIn : RoutesManager.onboarding,
    );
  }
}
