import 'package:flutter/cupertino.dart';

class TabProvider extends ChangeNotifier {
  int _selectedTab = 0;

  int get selectedTab => _selectedTab;

  selectTab(int index) {
    _selectedTab = index;
    print("Selecting - $_selectedTab");
    notifyListeners();
  }
}
