import 'package:flutter/cupertino.dart';

class SimpleUiProvider extends ChangeNotifier {

  //provider to filter by date
  String selectedDate = "all";

  void switchSelectedDate(String value) {
    selectedDate = value;
    notifyListeners();
  }

//provider to filter by status
String selectedStatus = "all";
void switchSelectedStatus(String value){
selectedStatus = value;
notifyListeners();
}

}

