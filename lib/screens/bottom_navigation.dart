// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, no_leading_underscores_for_local_identifiers, must_be_immutable

import "package:flutter/material.dart";
import 'package:meshr_app/screens/gallery.dart';
import 'package:meshr_app/screens/settings.dart';
import 'package:meshr_app/screens/view-gallery.dart';
import 'package:meshr_app/widgets/custom-bottom-navigation-bar.dart';

class BottomNavigation extends StatefulWidget {
  bool isGallery;
  bool isClicked;
  BottomNavigation({Key? key, required this.isGallery, required this.isClicked}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  
  int _currentIndex = 0;
  bool isGalleryView = false;


  @override
  Widget build(BuildContext context) {
    if(widget.isGallery) {
      _currentIndex ++;
      widget.isGallery = false;
    }

    if(widget.isClicked){
      isGalleryView = true;
    }

    PageController _pageController = PageController(initialPage: _currentIndex);
    return Scaffold(
      body: PageView(
        physics: AlwaysScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: widget.isClicked ? [
          Settings(isClicked: widget.isClicked),
          ViewGallery(),
        ] : [
          Settings(isClicked: widget.isClicked),
          Gallery(),
        ],
      ),
      //Custom bottom navigation bar
      bottomNavigationBar: CustomNavBar(controller: _pageController, currentIndex: _currentIndex, isGalleryView: isGalleryView),
    );
  }
}
