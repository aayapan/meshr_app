// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, no_leading_underscores_for_local_identifiers, must_be_immutable

import "package:flutter/material.dart";
import 'package:hive/hive.dart';
import 'package:meshr_app/data/local-storage.dart';
import 'package:meshr_app/screens/gallery_3d.dart';
import 'package:meshr_app/screens/gallery_choose.dart';
import 'package:meshr_app/screens/settings.dart';
import 'package:meshr_app/screens/view-gallery-3d.dart';
import 'package:meshr_app/screens/view-gallery-img.dart';
import 'package:meshr_app/widgets/custom-bottom-navigation-bar.dart';

// SCREEN FOR BOTTOM NAVIGATION FOR SETTINGS AND GALLERY (PAGE VIEW)
class BottomNavigation extends StatefulWidget {
  bool isGallery;
  bool isClicked;
  bool isImg;
  BottomNavigation({
    Key? key,
    required this.isGallery,
    required this.isClicked,
    required this.isImg,
  }) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;
  bool isGalleryView = false;
// ACCESS BOX COLLECTION
  final _myBox = Hive.box('FilesCollection');
  FilesLocalStorage fls = FilesLocalStorage();
  late int imgLength;
  late int objLength;

  @override
  void initState() {
    // TODO: implement initState

    fls.loadData();

    imgLength = fls.imageFileNames!.length;
    objLength = fls.objFileNames!.length;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isGallery) {
      _currentIndex++;
      widget.isGallery = false;
    }

    if (widget.isClicked) {
      isGalleryView = true;
    }

    PageController _pageController = PageController(initialPage: _currentIndex);
    return Scaffold(
      // PAGE VIEW FOR SLIDABLE VIEW BETWEEN GALLERY AND SETTINGS
      body: PageView(
        physics: AlwaysScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: widget.isClicked
            ? [
                Settings(
                  isClicked: widget.isClicked,
                ),
                widget.isImg ? ViewGalleryImg() : ViewGallery3D(),
              ]
            : [
                Settings(
                  isClicked: widget.isClicked,
                ),
                GalleryMain(
                  imgLength: imgLength,
                  objLength: objLength,
                ),
              ],
      ),
      //Custom bottom navigation bar
      bottomNavigationBar: CustomNavBar(
        controller: _pageController,
        currentIndex: _currentIndex,
        isGalleryView: isGalleryView,
      ),
    );
  }
}
