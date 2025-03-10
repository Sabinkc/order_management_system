import 'package:flutter/material.dart';

class SwitchOrderScreenProvider extends ChangeNotifier{
int selectedIndex = 0;
 void switchSelectedIndex(int index){
selectedIndex = index;
notifyListeners();
 }
}