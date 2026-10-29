import 'package:evently/core/resources/app_theme.dart';
import 'package:evently/core/resources/routes_manager.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/ui/add_event/screen/add_event_screen.dart';
import 'package:evently/ui/event_details/event_details_screen.dart';
import 'package:evently/ui/home/onboarding/onboarding_screen.dart';
import 'package:evently/ui/home/screen/home_screen.dart';
import 'package:evently/ui/signin/screen/signin_screen.dart';
import 'package:evently/ui/signup/screen/signup_screen.dart';
import 'package:evently/ui/start/screen/start_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:evently/firebase_options.dart';

import 'ui/event_details/edit_event/edit_event_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool onboardingFinished = prefs.getBool('onBoarding') ?? false;

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) => ThemeProvider(),
      child: MyApp(onboardingFinished: onboardingFinished),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool onboardingFinished;

  const MyApp({super.key, required this.onboardingFinished});

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
        RoutesManager.addevent: (context) => AddEventScreen(),
        RoutesManager.onboarding: (context) => OnboardingScreen(),
        RoutesManager.eventDetails: (context) => EventDetailsScreen(),
        RoutesManager.editEvent: (context) =>EditEventScreen(),
        RoutesManager.home: (context) => ChangeNotifierProvider(
          create: (context) => UserProvider()..setUserValue(),
          child: const HomeScreen(),
        ),
      },
      //onboarding only when you run 4 the first time after installation.
      // Everytime I open the app, it directly opens the Sign In Screen.
      initialRoute: onboardingFinished ? RoutesManager.signIn : RoutesManager.onboarding,
    );
  }
}