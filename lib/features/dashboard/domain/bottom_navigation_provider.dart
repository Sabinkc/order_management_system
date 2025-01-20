import 'package:flutter/cupertino.dart';

class BottomNavigationProvider extends ChangeNotifier{

  int _currentIndex = 0; 
  int get CurrentIndex => _currentIndex;

  void updateIndex(index){
    _currentIndex = index;
    notifyListeners();
  }
}