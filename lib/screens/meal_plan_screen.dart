// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:recipeapp/Widgets/my_icon_button.dart';
import '../Widgets/colors.dart';

class MealPlanScreen extends StatefulWidget {
  @override
  _MealPlanScreenState createState() => _MealPlanScreenState();
}

class _MealPlanScreenState extends State<MealPlanScreen> {
  List<Map<String, String>> mealPlans = [];

  void _showMealDialog({Map<String, String>? mealPlan, int? index}) {
    final isEditing = mealPlan != null;
    String mealName = isEditing ? mealPlan['name']! : '';
    String cookingTime = isEditing ? mealPlan['time']! : '';

    // TextEditingControllers
    final TextEditingController mealNameController = TextEditingController(text: mealName);
    final TextEditingController cookingTimeController = TextEditingController(text: cookingTime);

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 10, // Increased elevation for a stronger shadow effect
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 20,
                  spreadRadius: 5,
                  offset: const Offset(0, 10), // Position of shadow
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    isEditing ? 'Edit Meal Plan' : 'Add Meal Plan',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  // Meal Name Input Field
                  TextField(
                    controller: mealNameController,
                    decoration: InputDecoration(
                      labelText: 'Meal Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: (value) {
                      mealName = value;
                    },
                  ),
                  const SizedBox(height: 15), // Space between input fields
                  
                  // Cooking Time Input Field
                  TextField(
                    controller: cookingTimeController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Cooking Time (mins)',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: (value) {
                      cookingTime = value;
                    },
                  ),
                  const SizedBox(height: 20),
                  
                  // Buttons for Add or Update
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (isEditing && index != null) {
                            setState(() {
                              mealPlans[index] = {
                                'name': mealName,
                                'time': cookingTime,
                              };
                            });
                          } else {
                            setState(() {
                              mealPlans.add({
                                'name': mealName,
                                'time': cookingTime,
                              });
                            });
                          }
                          Navigator.of(context).pop();
                        },
                        child: Text(isEditing ? 'Update' : 'Add' ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kprimaryColor(context), // Button color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(isEditing ? 'Cancel' : 'Cancel' , style: const TextStyle(color: Colors.black),),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _deleteMealPlan(int index) {
    setState(() {
      mealPlans.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    
   
    return Scaffold(
      backgroundColor: kbackgroundColor(context),
      appBar: AppBar(
        backgroundColor: kbackgroundColor(context),
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: [
          const SizedBox(width: 15),
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
            'Your Meal Plans',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          MyIconButton(
        icon: Iconsax.notification,
        color: Theme.of(context).brightness == Brightness.dark 
            ? Colors.white 
            : Colors.black,  // Adjust color based on theme
        pressed: () {},
      ),
          const SizedBox(width: 15),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: mealPlans.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    elevation: 4,
                    child: ListTile(
                      title: Text(mealPlans[index]['name']!,style: TextStyle(  color: Theme.of(context).brightness == Brightness.dark 
            ? Colors.white 
            : Colors.black, ), ),
                      subtitle: Text('${mealPlans[index]['time']} mins', ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              _showMealDialog(mealPlan: mealPlans[index], index: index);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteMealPlan(index),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            GestureDetector(
              onTap: () => _showMealDialog(),
              child: Container(
                margin: const EdgeInsets.only(top: 16.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kprimaryColor(context),
                    padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 13),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30), // Rounded corners
                    ),
                  ),
                  onPressed: () => _showMealDialog(),
                  child: const Text(
                    "Add Meal",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
