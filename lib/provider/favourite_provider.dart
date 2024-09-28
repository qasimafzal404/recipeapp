// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class FavouriteProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<String> _favouriteIds = [];

  List<String> get favouriteIds => _favouriteIds;

  FavouriteProvider() {
    loadFavourites();
  }

  // Toggle favourite state
 Future<void> toggleFavourite(DocumentSnapshot product) async {
  String productId = product.id;
  if (_favouriteIds.contains(productId)) {
    _favouriteIds.remove(productId);
    await _removeFavourite(productId);
  } else {
    _favouriteIds.add(productId);
    await _addFavourite(productId);
  }

  // Call notifyListeners after changes have been made
  notifyListeners();
}


  // Check if product is favourite
  bool isExit(DocumentSnapshot product) {
    return _favouriteIds.contains(product.id);
  }

  // Add a product to favourites
  Future<void> _addFavourite(String productId) async {
    try {
      await _firestore.collection('userFavourites').doc(productId).set({
        'isFavourite': true,
      });
    } catch (e) {
      print(e.toString());
    }
  }

  // Remove a product from favourites
  Future<void> _removeFavourite(String productId) async {
    try {
      await _firestore.collection('userFavourites').doc(productId).delete();
    } catch (e) {
      print(e.toString());
    }
  }

  // Load all favourites from Firestore
  Future<void> loadFavourites() async {
    try {
      QuerySnapshot snapshot =
          await _firestore.collection('userFavourites').get();
      _favouriteIds = snapshot.docs.map((doc) => doc.id).toList();
    } catch (e) {
      print(e.toString());
    }

    // Delay notifying listeners until the widget build phase is complete
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  // Provider utility method
  static FavouriteProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<FavouriteProvider>(context, listen: listen);
  }
}
