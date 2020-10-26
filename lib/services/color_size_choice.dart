import 'package:flutter/cupertino.dart';

class ChoiceService with ChangeNotifier{
String color = '';
String size = '';

void setColor(String s){
  color = s;
  notifyListeners();
}

void setSize(String s){
  size = s;
  notifyListeners();
}


}