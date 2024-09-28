import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:recipeapp/Widgets/colors.dart';
import 'package:recipeapp/Widgets/food_item_display.dart';
import 'package:recipeapp/Widgets/my_icon_button.dart';

class ViewAllScreen extends StatefulWidget {
  const ViewAllScreen({super.key});

  @override
  State<ViewAllScreen> createState() => _ViewAllScreenState();
}

class _ViewAllScreenState extends State<ViewAllScreen> {
  final CollectionReference viewAll =
      FirebaseFirestore.instance.collection("complete-fields");

  @override
  Widget build(BuildContext context) {
    // Determine the color based on the current theme brightness
    Color iconColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black;

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
            color: iconColor, // Adjust color based on theme
            pressed: () {
              Navigator.pop(context);
            },
          ),
          const Spacer(),
          const Text(
            'Quick & Easy',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          MyIconButton(
            color: iconColor, // Adjust color based on theme
            icon: Iconsax.notification,
            pressed: () {},
          ),
          const SizedBox(width: 15),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 15, right: 5),
        child: Column(
          children: [
            const SizedBox(height: 10),
            StreamBuilder(
              stream: viewAll.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.hasData) {
                  return GridView.builder(
                    itemCount: streamSnapshot.data!.docs.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, childAspectRatio: 0.78),
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot =
                          streamSnapshot.data!.docs[index];

                      return Column(
                        children: [
                          FoodItemDisplay(documentSnapshot: documentSnapshot),
                          Row(
                            children: [
                              const Icon(
                                Iconsax.star1,
                                color: Colors.amberAccent,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                documentSnapshot['rating'],
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const Text(
                                "/5",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                "${documentSnapshot['reviews'].toString()} Reviews",
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          )
                        ],
                      );
                    },
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
