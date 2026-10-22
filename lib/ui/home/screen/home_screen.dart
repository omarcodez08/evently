import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/resources/assets_manager.dart';
import '../../../core/resources/colors_manager.dart';
import '../../../core/resources/routes_manager.dart';
import '../tabs/favorite_tab/favourite_tab.dart';
import '../tabs/home_tab/home_tab.dart';
import '../tabs/profile_tab/profile_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  List<Widget> tabs = [
    HomeTab(),
    FavoriteTab(),
    ProfileTab()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        onPressed: () {
          Navigator.pushNamed(context, RoutesManager.addevent);
        },
        child: SvgPicture.asset(AssetsManager.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        currentIndex:selectedIndex ,
        items: [
          BottomNavigationBarItem(
            label: "Home",
            icon: SvgPicture.asset(
              AssetsManager.home,
              colorFilter: ColorFilter.mode(
                ColorsManager.unselectedTabColor,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: SvgPicture.asset(
              AssetsManager.home_selected,
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.primary,
                BlendMode.srcIn,
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: "Favorite",
            icon: SvgPicture.asset(
              AssetsManager.heart,
              colorFilter: ColorFilter.mode(
                ColorsManager.unselectedTabColor,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: SvgPicture.asset(
              AssetsManager.heart_selected,
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.primary,
                BlendMode.srcIn,
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: "Profile",
            icon: SvgPicture.asset(
              AssetsManager.profile,
              colorFilter: ColorFilter.mode(
                ColorsManager.unselectedTabColor,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: SvgPicture.asset(
              AssetsManager.profile_selected,
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.primary,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
      body: tabs[selectedIndex],
    );
  }
}