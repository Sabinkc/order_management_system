import 'package:flutter/material.dart';

class BottomNavigationbarProvider extends ChangeNotifier{

  int selectedIndex = 0;
  
  updateSelectedIndex(int index){
selectedIndex = index;
notifyListeners();
  }
}