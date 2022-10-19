
import 'package:flutter/material.dart';
import 'package:meshr_app/widgets/output-footer.dart';

class ViewOutput extends StatelessWidget {
  ViewOutput({Key? key,}) : super(key: key);

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
        color: Colors.white,
        child: Center(
          child: Text("SAMPLE 3D OUTPUT"),
        ),
      ),
      bottomNavigationBar: OutputBottomNav(),
    );
  }
}