import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:recipeapp/screens/favourite_screen.dart';
import 'package:recipeapp/screens/meal_plan_screen.dart';
import 'package:recipeapp/screens/my_app_home_screen.dart';
import 'package:recipeapp/screens/settings.dart';

import '../Widgets/colors.dart';
import '../provider/theme_provider.dart';

class AppMainScreen extends StatefulWidget {
  const AppMainScreen({super.key});

  @override
  State<AppMainScreen> createState() => _AppMainScreenState();
}

class _AppMainScreenState extends State<AppMainScreen> {
  int selectedIndex = 0;
  late final List<Widget> page;

  @override
  void initState() {
    super.initState();
    page = [
      const MyAppHomeScreen(),
      const FavouriteScreen(),
      MealPlanScreen(),
      const SettingsScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    // Get theme provider here
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: themeProvider.isDarkTheme ? Colors.black : Colors.white, // Change scaffold background
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: themeProvider.isDarkTheme ? Colors.black87 : Colors.white, // Change bottom nav color
        elevation: 0,
        iconSize: 28,
        currentIndex: selectedIndex,
        selectedItemColor:kprimaryColor(context) ,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle:
            TextStyle(color: kprimaryColor(context), fontWeight: FontWeight.w600),
        unselectedLabelStyle:
            const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(selectedIndex == 0 ? Iconsax.home5 : Iconsax.home_1),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(selectedIndex == 1 ? Iconsax.heart5 : Iconsax.heart),
              label: 'Favourite'),
          BottomNavigationBarItem(
              icon: Icon(
                  selectedIndex == 2 ? Iconsax.calendar5 : Iconsax.calendar),
              label: 'Meal Plan'),
          BottomNavigationBarItem(
              icon: Icon(
                  selectedIndex == 3 ? Iconsax.setting_21 : Iconsax.setting),
              label: 'Setting'),
        ],
      ),
      body: page[selectedIndex],
    );
  }

  Widget navBarPage(iconName) {
    return Center(
      child: Icon(
        iconName,
        size: 100,
        color: kprimaryColor(context),
      ),
    );
  }
}
