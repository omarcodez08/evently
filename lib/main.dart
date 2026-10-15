import 'package:evently/providers/theme_provider.dart';
import 'package:evently/ui/home/screen/home_screen.dart';
import 'package:evently/ui/signin/screen/signin_screen.dart';
import 'package:evently/ui/signup/screen/signup_screen.dart';
import 'package:evently/ui/start/screen/start_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/resources/app_theme.dart';
import 'core/resources/routes_manager.dart';
import 'package:evently/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
      },
      initialRoute: FirebaseAuth.instance.currentUser != null
          ? RoutesManager.home
          : RoutesManager.signIn,
    );
  }
}
