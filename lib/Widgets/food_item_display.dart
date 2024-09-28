import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:recipeapp/provider/favourite_provider.dart';
import 'package:recipeapp/screens/recipe_details.dart';

class FoodItemDisplay extends StatefulWidget {
  final DocumentSnapshot<Object?> documentSnapshot;
  const FoodItemDisplay({super.key, required this.documentSnapshot});

  @override
  State<FoodItemDisplay> createState() => _FoodItemDisplayState();
}

class _FoodItemDisplayState extends State<FoodItemDisplay> {
  @override
  Widget build(BuildContext context) {
    final provider = FavouriteProvider.of(context);
    final data = widget.documentSnapshot.data() as Map<String, dynamic>?;
    return GestureDetector(
      onTap: ()  {
        Navigator.push(context , MaterialPageRoute(builder: (context) => RecipeDetails(documentSnapshot: widget.documentSnapshot)));
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        width: 230,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: widget.documentSnapshot.id,
                  child: Container(
                    width: double.infinity,
                    height: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: data != null && data.containsKey('image')
                            ? NetworkImage(data['image'])
                            : const NetworkImage(''), // default image
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  data != null && data.containsKey('name') ? data['name'] : '',
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(
                      Iconsax.flash_1,
                      size: 16,
                      color: Colors.grey,
                    ),
                    Text(
                      "${data != null && data.containsKey('cal') ? data['cal'] : ''} ${data != null && data.containsKey('cal') ? data['cal'] : ''}",
                      style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "  .  ",
                      style: TextStyle(
                          fontWeight: FontWeight.w900, color: Colors.grey),
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
                      data != null && data.containsKey('time')
                          ? data['time'].toString()
                          : '',
                      style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.w900),
                    ),
                  ],
                ),


              ],
            ),
            Positioned(
              top: 5,
              right: 5,
                child: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.white,
              child: InkWell(
                onTap: () {
                  provider.toggleFavourite( widget.documentSnapshot);
                },
                child:  Icon(
                  provider.isExit(widget.documentSnapshot)?
                  Iconsax.heart5:
                  Iconsax.heart,
                  color: provider.isExit(widget.documentSnapshot)?
                   Colors.red:
                    Colors.black,
                  size: 20,
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
