import 'package:evently/core/resources/assets_manager.dart';
import 'package:evently/core/resources/colors_manager.dart';
import 'package:evently/core/resources/routes_manager.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final GlobalKey<IntroductionScreenState> introKey = GlobalKey<IntroductionScreenState>();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.whiteColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Image.asset(
          AssetsManager.logo,
          width: 120,
          height: 40,
        ),
        leading: currentIndex > 0
            ? IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            introKey.currentState?.previous();
          },
        )
            : null,
        actions: [
          if (currentIndex == 0)
            TextButton(
              onPressed: () async {
                await saveOnboarding(); // Save preference on Skip
                navigateToSignIn();
              },
              child: Text(
                "Skip",
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          const SizedBox(width: 8),
        ],
      ),
      body: IntroductionScreen(
        key: introKey,
        showDoneButton: false,
        showNextButton: false,
        showSkipButton: false,
        globalBackgroundColor: ColorsManager.whiteColor,
        onChange: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        pages: [
          buildPage(
            context,
            title: "Find Events That Inspire You",
            body: "Dive into a world of events crafted to fit your unique interests. Whether you're into live music, art workshops, professional networking, or simply discovering new experiences, we have something for everyone. Our curated recommendations will help you explore, connect, and make the most of every opportunity around you.",
            imagePath: AssetsManager.onboarding1,
          ),
          buildPage(
            context,
            title: "Effortless Event Planning",
            body: "Take the hassle out of organizing events with our all-in-one planning tools. From setting up invites and managing RSVPs to scheduling reminders and coordinating details, we’ve got you covered. Plan with ease and focus on what matters – creating an unforgettable experience for you and your guests.",
            imagePath: AssetsManager.onboarding2,
          ),
          buildPage(
            context,
            title: "Connect with Friends & Share Moments",
            body: "Make every event memorable by sharing the experience with others. Our platform lets you invite friends, keep everyone in the loop, and celebrate moments together. Capture and share the excitement with your network, so you can relive the highlights and cherish the memories.",
            imagePath: AssetsManager.onboarding3,
          ),
        ],
        dotsDecorator: DotsDecorator(
          activeSize: const Size(20, 8),
          size: const Size(8, 8),
          activeColor: ColorsManager.lightPrimary,
          color: ColorsManager.unselectedTabColor,
          spacing: const EdgeInsets.symmetric(horizontal: 4),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        child: SizedBox(
          width: double.infinity,
          height: 55,
          child: ElevatedButton(
            onPressed: () async {
              if (currentIndex < 2) {
                introKey.currentState?.next();
              } else {
                await saveOnboarding();
                navigateToSignIn();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsManager.lightPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 0,
            ),
            child: Text(
              currentIndex == 2 ? "Get started" : "Next",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  PageViewModel buildPage(
      BuildContext context, {
        required String title,
        required String body,
        required String imagePath,
      }) {
    return PageViewModel(
      titleWidget: SizedBox(
        width: double.infinity,
        child: Text(
          title,
          textAlign: TextAlign.start,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      bodyWidget: SizedBox(
        width: double.infinity,
        child: Text(
          body,
          textAlign: TextAlign.start,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: ColorsManager.lightSecondaryColor,
          ),
        ),
      ),
      image: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Image.asset(imagePath, fit: BoxFit.contain),
        ),
      ),
      decoration: const PageDecoration(
        pageColor: ColorsManager.whiteColor,
        contentMargin: EdgeInsets.symmetric(horizontal: 16),
        bodyAlignment: Alignment.topCenter,
        imagePadding: EdgeInsets.only(bottom: 24),
      ),
    );
  }

  Future<void> saveOnboarding() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onBoarding', true);
  }

  void navigateToSignIn() {
    Navigator.pushReplacementNamed(context, RoutesManager.signIn);
  }
}