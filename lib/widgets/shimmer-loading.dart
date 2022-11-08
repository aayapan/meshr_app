import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';

Shimmer getShimmer() {
  return Shimmer.fromColors(
      child: Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(11)), color: Colors.white),
        margin: EdgeInsets.only(top: 35, left: 15, right: 15),
      ),
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!);
}
