// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:flutter_switch/flutter_switch.dart';
import 'package:meshr_app/screens/home_page.dart';
import 'package:meshr_app/screens/login_screen.dart';
import 'package:meshr_app/screens/settings-option-two.dart';
import 'package:provider/provider.dart';

import '../provider/google_sign_in.dart';

class Settings extends StatefulWidget {
  Settings({Key? key, }) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool? status = false;
  final settingsItems = ['Sample 1', 'Sample 2', 'Sample 3'];
  int? value = 0;
  final user = FirebaseAuth.instance.currentUser!;
  final userDB = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid);

  Future getUserData() async {
    final snapshot = await userDB.get();
    if (snapshot.exists) {
      Map<String, dynamic>? data = snapshot.data();
      // setState(() {
      //   print("INIT USER");

      // });
      int index = 0;
      int counter = 0;
      for (var element in settingsItems) {
        if (data!['settingValue'] == element) {
          index = counter;
        }
        counter += 1;
      }
      setState(() {
        value = index;
        status = data!['settingStatus'];
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    print('INIT USER');
    getUserData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF2D2B2B),
        title: Text(
          "Settings",
          style: TextStyle(
            fontFamily: "Roboto",
            fontWeight: FontWeight.w700,
            fontSize: 30,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: ImageIcon(AssetImage("assets/images/back-icon.png")),
          iconSize: 40.0,
          color: Color(0xFFEFB83C),
        ),
      ),
      body: Container(
        color: Color(0xFF2D2B2B),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // USER PROFILE
              Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Account",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        // fontWeight: FontWeight.w300,
                        color:
                            Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: CircleAvatar(
                            radius: 28,
                            backgroundColor: Color(0xFF212121),
                            child: ImageIcon(
                              AssetImage("assets/images/user-icon.png"),
                              size: double.infinity,
                              color: Colors.grey[300],
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.displayName!,
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  color: Colors.grey[300],
                                  fontFamily: 'Roboto',
                                  fontSize: 17),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "UI/UX Designer",
                              style: TextStyle(
                                  color: Colors.grey[400],
                                  fontFamily: 'Roboto',
                                  fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      color: Colors.grey,
                      height: 1,
                    )
                  ],
                ),
              ),

              // SETTINGS OPTIONS
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Settings",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Roboto',
                              fontSize: 18,
                            ),
                          ),

                          // SETTINGS 1
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: Color(0xFFEFB83C),
                                child: ImageIcon(
                                  AssetImage("assets/images/tool-icon.png"),
                                  size: 25,
                                  color: Colors.black,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: 12),
                                  child: Text(
                                    "Settings 1 (Switch)",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Roboto',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                              ),
                              FlutterSwitch(
                                height: 25,
                                width: 45,
                                toggleSize: 20,
                                padding: 4.0,
                                activeColor: Color(0xFFEFB83C),
                                inactiveColor: Color(0xFF212121),
                                value: status!,
                                onToggle: (val) {
                                  setState(() {
                                    status = val;
                                  });
                                  userDB.update({
                                    'settingStatus': status,
                                  });
                                },
                              ),
                            ],
                          ),

                          // SETTINGS 2
                          SizedBox(
                            height: 35,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SettingsOptionTwo()));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Color(0xFFEFB83C),
                                  child: ImageIcon(
                                    AssetImage("assets/images/tool-icon.png"),
                                    size: 25,
                                    color: Colors.black,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(left: 12),
                                    child: Text(
                                      "Settings 2",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Roboto',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SettingsOptionTwo()));
                                    },
                                    icon: Icon(
                                      Icons.arrow_right,
                                      color: Colors.grey[300],
                                    ))
                              ],
                            ),
                          ),

                          // SETTINGS 3
                          SizedBox(
                            height: 35,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: Color(0xFFEFB83C),
                                child: ImageIcon(
                                  AssetImage("assets/images/tool-icon.png"),
                                  size: 25,
                                  color: Colors.black,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 12),
                                  child: DropdownButtonFormField<String>(
                                    decoration:
                                        InputDecoration.collapsed(hintText: ''),
                                    dropdownColor: Color(0xFF2D2B2B),
                                    isExpanded: true,
                                    items: settingsItems
                                        .map(buildMenuItem)
                                        .toList(),
                                    value: settingsItems[value!],
                                    icon: Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.grey[300],
                                    ),
                                    hint: Text(
                                      "Settings 3 (Dropdown)",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Roboto',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    onChanged: (value) {
                                      int index = 0;
                                      int counter = 0;
                                      settingsItems.forEach((element) {
                                        if (element == value) {
                                          index = counter;
                                        }
                                        counter += 1;
                                      });
                                      setState(() {
                                        this.value = index;
                                      });
                                      userDB.update({'settingValue': value});
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11),
                        color: Color(0xFFEFB83C),
                      ),
                      width: double.infinity,
                      margin: EdgeInsets.only(bottom: 50),
                      child: TextButton(
                        onPressed: () {
                          FirebaseAuth.instance.signOut();

                          final provider = Provider.of<GoogleSignInProvider>(
                              context,
                              listen: false);
                          provider.logout();

                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => HomePage()),
                              (Route<dynamic> route) => false);
                          print("Dito dumaan");
                        },
                        child: Text(
                          "Log Out",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF2D2B2B),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Roboto',
            fontSize: 15,
            fontWeight: FontWeight.w300,
          ),
        ),
      );
}
