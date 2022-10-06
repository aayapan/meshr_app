import 'package:hive_flutter/hive_flutter.dart';

class FilesLocalStorage {

  List objFileNames = [];
  List thumbFileNames = [];

  final _myBox = Hive.box('FilesCollection');

  void createInitialData() {
    objFileNames = ['sample1.obj', 'sample2.obj'];
    thumbFileNames = ['thumb1.png', 'thumb2.png'];
  }

  void loadData() {
    objFileNames = _myBox.get('OBJLIST');
    thumbFileNames = _myBox.get('THUMBLIST');
  }

  void updateData() {
    _myBox.put('OBJLIST', objFileNames);
    _myBox.put('THUMBLIST', thumbFileNames);
  }

}