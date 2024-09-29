import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:recipeapp/provider/favourite_provider.dart';

import '../Widgets/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = FavouriteProvider.of(context);
    final favoutiteItems = provider.favouriteIds;
    return Scaffold(
      backgroundColor: kbackgroundColor(context),
      appBar: AppBar(
          backgroundColor: kbackgroundColor(context),
          centerTitle: true,
          title: const Text(
            "Favourite",
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
      body: favoutiteItems.isEmpty
          ? const Center(
              child: Text(
              "No Favourite Items",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ))
          : ListView.builder(
              itemCount: favoutiteItems.length,
              itemBuilder: (context, index) {
                String favoutite = favoutiteItems[index];
                return FutureBuilder<DocumentSnapshot>(
                    future: FirebaseFirestore.instance
                        .collection("complete-fields")
                        .doc(favoutite)
                        .get(),
                    builder: (context, snapShot) {
                      if (snapShot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (!snapShot.hasData || snapShot.data == null) {
                        return const Center(
                          child: Text("Error loading Favourites"),
                        );
                      }
                      var favoutiteItems = snapShot.data!;
                      return Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white),
                              child: Row(
                                children: [
                                  Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: CachedNetworkImageProvider(
                                              favoutiteItems['image']),
                                        )),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        favoutiteItems['name'],
                                        style:  TextStyle(color: kprimaryColor(context),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Iconsax.flash_1,
                                            size: 16,
                                            color: Colors.grey,
                                          ),
                                          Text(
                                             favoutiteItems['cal'],
                                            style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const Text(
                                            "  .  ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w900,
                                                color: Colors.grey),
                                          ),
                                          const Icon(
                                            Iconsax.clock,
                                            size: 16,
                                            color: Colors.grey,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            " ${favoutiteItems['time']} Min",
                                            style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w900),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 50,
                            right: 35,
                            child: GestureDetector(
                              onTap: (){
                                setState(() {
                                  provider.toggleFavourite(favoutiteItems);
                                });
                              },
                              child: const Icon(
                                Icons.delete,
                                color: Colors.red,
                                size: 25,
                              ),
                            ),
                          )
                        ],
                      );
                    });
              }),
    );
  }
}
