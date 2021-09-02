import 'package:flutter/foundation.dart';

class ListProvider with ChangeNotifier {
  List<String> list = [];
  Map<String, dynamic> groupanddocid = new Map<String, dynamic>();

  void addItem(String item) {
    list.add(item);
    notifyListeners();
  }

  void addtomap(String groupname, String docid) {
    groupanddocid.putIfAbsent(groupname, () => docid);
    notifyListeners();
    print(groupanddocid);
  }

  void deleteItem(int index) {
    list.remove(index);
    notifyListeners();
  }

  String getfrommap(String groupname) {
    return groupanddocid[groupname];
  }

  bool check(String item) {
    return groupanddocid.containsKey(item);
  }
}
