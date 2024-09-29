import 'package:flutter/material.dart';
import 'package:recipeapp/screens/view_all_screen.dart';

import 'colors.dart';

class BannerToExplore extends StatelessWidget {
  const BannerToExplore({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: kBannerColor(context),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 30,
            left: 20,
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Cook the best\nrecipies at home ",
                style: TextStyle(
                    height: 1.1,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 33),
                    backgroundColor: Colors.white,
                    elevation: 0,
                  ),
                  onPressed: () {
                    Navigator.push(
                           context,
                           MaterialPageRoute(
                               builder: (_) => const ViewAllScreen())
              );},
                  child: const Text(
                    "Explore",
                    style: TextStyle(
                        color:  Color.fromARGB(255, 0, 0, 0),
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ))
            ],
          )),
          Positioned(
          top: 0,
          bottom: 0,
          right: -25,
          child: 
          Image.network("https://pngimg.com/d/chef_PNG199.png"))
        ],
      ),
    );
  }
}
