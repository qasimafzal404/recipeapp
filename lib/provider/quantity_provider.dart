import 'package:flutter/material.dart';

class QuantityProvider extends ChangeNotifier{
   int _currentNumber = 1;
   List<double> _baseIngredientsAmount = [];
   int get currentNumber => _currentNumber;
   void setBaseIngredientAmount(List<double> amounts){
     _baseIngredientsAmount = amounts;
     notifyListeners();
   }
   List<String> get updateIngredientAmount{
    return _baseIngredientsAmount.map<String>((amount) => (amount * _currentNumber).toStringAsFixed(2)).toList();
   }
   void increaseQuantity(){
    _currentNumber++;
    notifyListeners();
   }
   void decreaseQuantity(){
    if(_currentNumber > 1){
      _currentNumber--;
      notifyListeners();
    }
   }
}