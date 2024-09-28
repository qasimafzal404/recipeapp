import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:recipeapp/provider/theme_provider.dart';

import '../Widgets/colors.dart';
import '../Widgets/my_icon_button.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: kbackgroundColor(context),
     appBar: AppBar(
        backgroundColor: kbackgroundColor(context),
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: [
          const SizedBox(
            width: 15,
          ),
          MyIconButton(
        icon: Icons.arrow_back_ios_new,
        color: Theme.of(context).brightness == Brightness.dark 
            ? Colors.white 
            : Colors.black,  // Adjust color based on theme
        pressed: () {
          Navigator.pop(context);
        },
      ),
          const Spacer(),
          const Text(
            'Settings',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          MyIconButton(
            // Adjust color based on theme
            icon: Iconsax.notification,
            pressed: () {}, color: Theme.of(context).brightness == Brightness.dark 
            ? Colors.white 
            : Colors.black,
          ),
          const SizedBox(width: 15),
        ],
      ),
      body: Center(
        child: Padding(padding: const EdgeInsets.symmetric(horizontal: 70),
          child: SwitchListTile(
            
            title: const Text('Dark Theme' , style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),),
            value: Provider.of<ThemeProvider>(context).isDarkTheme,
            onChanged: (value) {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
          ),
        ),
      ),
    );
  }
}
