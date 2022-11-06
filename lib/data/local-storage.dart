// ignore_for_file: avoid_print

import 'package:hive_flutter/hive_flutter.dart';
// HIVE CLASS (LOCAL STORAGE uses BOXES)
class FilesLocalStorage {

  List objFileNames = [];
  List thumbFileNames = [];
  List imageFileNames = [];

  final _myBox = Hive.box('FilesCollection');
// INITIALIZING LIST
  void createInitialData() {
    objFileNames = [];
    thumbFileNames = [];
    imageFileNames = [];
    updateData();
  }
// LOAD THE DATA
  void loadData() {
    objFileNames = _myBox.get('OBJLIST');
    thumbFileNames = _myBox.get('THUMBLIST');
    imageFileNames = _myBox.get('IMGLIST');
    print("LOAD DATA!");
  }
// UPDATE THE DATA
  void updateData() {
    _myBox.put('OBJLIST', objFileNames);
    _myBox.put('THUMBLIST', thumbFileNames);
    _myBox.put('IMGLIST', imageFileNames);
    print("BOX UPDATED!");
  }

}