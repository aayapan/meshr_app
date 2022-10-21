// ignore_for_file: avoid_print

import 'package:hive_flutter/hive_flutter.dart';

class FilesLocalStorage {

  List objFileNames = [];
  List thumbFileNames = [];
  List imageFileNames = [];
  List? tempImageFileNames = [];

  final _myBox = Hive.box('FilesCollection');

  void createInitialData() {
    objFileNames = [];
    thumbFileNames = [];
    imageFileNames = [];
    tempImageFileNames = [];
    updateData();
  }

  void loadData() {
    objFileNames = _myBox.get('OBJLIST');
    thumbFileNames = _myBox.get('THUMBLIST');
    imageFileNames = _myBox.get('IMGLIST');
    tempImageFileNames = _myBox.get('TEMPIMG');
  }

  void updateData() {
    _myBox.put('OBJLIST', objFileNames);
    _myBox.put('THUMBLIST', thumbFileNames);
    _myBox.put('IMGLIST', imageFileNames);
    _myBox.put('TEMPIMG', tempImageFileNames);
    print("BOX UPDATED!");
  }

}