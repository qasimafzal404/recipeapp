// ignore_for_file: avoid_print


import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:recipeapp/Widgets/banner.dart';
import 'package:recipeapp/Widgets/colors.dart';
import 'package:recipeapp/Widgets/food_item_display.dart';
import 'package:recipeapp/Widgets/my_icon_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipeapp/screens/view_all_screen.dart';

class MyAppHomeScreen extends StatefulWidget {
  const MyAppHomeScreen({super.key});

  @override
  State<MyAppHomeScreen> createState() => _MyAppHomeScreenState();
}

class _MyAppHomeScreenState extends State<MyAppHomeScreen> {
  String category = "All";
  final CollectionReference categoriesItems =
      FirebaseFirestore.instance.collection("Category");
  Query get fileteredRecipie => FirebaseFirestore.instance
      .collection("complete-fields")
      .where("category", isEqualTo: category);
  Query get alldRecipie =>
      FirebaseFirestore.instance.collection("complete-fields");
  Query get selectedRecipie =>
      category == "All" ? alldRecipie : fileteredRecipie;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundColor(context),
      body: SafeArea(
        child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                 const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [ const SizedBox(height: 5,),
                headerParts(),
                 const SizedBox(height: 10,),
                mysearchBar(),
                 const SizedBox(height: 15,),
                const BannerToExplore(),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    "Categories",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                selectedCategory(),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Quick & Easy",
                      style: TextStyle(
                          fontSize: 20,
                          letterSpacing: 0.1,
                          fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                        onPressed: () {
                         Navigator.push(
                           context,
                           MaterialPageRoute(
                               builder: (_) => const ViewAllScreen()),
                         );
                        },
                        child: Text(
                          "View all",
                          style: TextStyle(
                              color: kBannerColor(context), fontWeight: FontWeight.w600),
                        )),
                  ],
                ),
              ],
            ),
          ),
          StreamBuilder(
              stream: selectedRecipie.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.hasData) {
                  final List<DocumentSnapshot> recipes =
                      streamSnapshot.data!.docs;
                  return Padding(
                    padding: const EdgeInsets.only(top: 5, left: 15),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: recipes
                            .map((e) => FoodItemDisplay(
                                documentSnapshot:
                                    e as DocumentSnapshot<Object>))
                            .toList(),
                      ),
                    ),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                ); // return something while waiting for data
              })
        ])),
      ),
    );
  }

  StreamBuilder<QuerySnapshot<Object?>> selectedCategory() {
    return StreamBuilder(
        stream: categoriesItems.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            dynamic data = snapshot.data!.docs[0].data(); // changed index to 0
            print(data);
            print(data['name']);

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  snapshot.data!.docs.length,
                  (index) {
                    dynamic docData = snapshot.data!.docs[index]
                        .data(); // get data for each document
                    String name = docData['name'] ?? ''; // add null check
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          category = snapshot.data!.docs[index]["name"];
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: category == snapshot.data!.docs[index]["name"]
                              ? kprimaryColor(context)
                              : Colors.white,
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        margin: const EdgeInsets.only(right: 20),
                        child: Text(
                          name, // use the name variable
                          style: TextStyle(
                              color:
                                  category == snapshot.data!.docs[index]["name"]
                                      ? Colors.white
                                      : Colors.grey.shade600,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  Row headerParts() {
    return Row(
      children: [
       
        const Text(
          "What are you\ncooking today?",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
 MyIconButton(
        icon: Iconsax.notification,
        color: Theme.of(context).brightness == Brightness.dark 
            ? Colors.white 
            : Colors.black,  // Adjust color based on theme
        pressed: () {},
      ),
      ],
    );
  }

  Padding mysearchBar() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 22),
        child: TextField(
          decoration: InputDecoration(
            filled: true,
            prefix: const Icon(Iconsax.search_normal),
            fillColor: Colors.white,
            border: InputBorder.none,
            hintText: "Search for Recipes",
            hintStyle: const TextStyle(color: Colors.grey),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ));
        
  }
}
