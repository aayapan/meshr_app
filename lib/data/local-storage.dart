import 'package:hive_flutter/hive_flutter.dart';

class FilesLocalStorage {

  List objFileNames = [];
  List thumbFileNames = [];
  List imageFileNames = [];

  final _myBox = Hive.box('FilesCollection');

  void createInitialData() {
    objFileNames = ['sample1.obj', 'sample2.obj'];
    thumbFileNames = ['thumb1.png', 'thumb2.png'];
    imageFileNames = ['img.png', 'img2.png'];
    updateData();
  }

  void loadData() {
    objFileNames = _myBox.get('OBJLIST');
    thumbFileNames = _myBox.get('THUMBLIST');
    imageFileNames = _myBox.get('IMGLIST');
  }

  void updateData() {
    _myBox.put('OBJLIST', objFileNames);
    _myBox.put('THUMBLIST', thumbFileNames);
    _myBox.put('IMGLIST', imageFileNames);
    print("BOX UPDATED!");
  }

}