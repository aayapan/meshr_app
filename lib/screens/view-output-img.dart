
import 'package:flutter/material.dart';
import 'package:meshr_app/widgets/output-footer.dart';

class ViewOutputImage extends StatelessWidget {
  String imageUrl;
  ViewOutputImage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: ImageIcon(AssetImage("assets/images/back-icon.png")),
          iconSize: 40.0,
          color: Color(0xFFEFB83C),
        ),
        actions: [
          IconButton(
          onPressed: () {
            // SAVE TO GALLERY FUNCTION 
          },
          icon: ImageIcon(AssetImage("assets/images/save-icon.png")),
          iconSize: 40.0,
          color: Color(0xFFEFB83C),
        ),
        ],
      ),
      body: Container(
        width: double.infinity,
        color: Colors.white,
        child: Center(
          child: Image.network(imageUrl, fit: BoxFit.cover,),
        ),
      ),
      bottomNavigationBar: OutputBottomNav(),
    );
  }
}