// ignore_for_file: prefer_const_constructors, unnecessary_new, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meshr_app/main.dart';
import 'package:meshr_app/provider/google_sign_in.dart';
import 'package:meshr_app/screens/home_page.dart';
import 'package:meshr_app/screens/login_screen.dart';
import 'package:flutter/services.dart';
import 'package:meshr_app/screens/main_menu.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? _email, _password, _confirmPassword, _firstName, _lastName;

  int? _month;
  int? _day;
  int? _year;

  String _dateDisplay = 'mm/dd/yyyy';

  final formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final _confirmPasswordController = TextEditingController();

  final _firstNameController = TextEditingController();

  final _lastNameController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future addUserDetails() async {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .set({
            'email': _email,
            'firstName': _firstName,
            'lastName': _lastName,
            'monthBday': _month,
            'dayBday': _day,
            'yearBday': _year,
            'settingStatus': false,
            'settingValue': null
          })
          .then((_) => print('Added'))
          .catchError((error) => print('Add failed: $error'));
    }

    Future signUp() async {
      // create user
      final isValid = formKey.currentState!.validate();
      try {
        if (_confirmPassword != _password) {
          throw FirebaseAuthException(
              code: "Register Error", message: "Password did not match.");
        } else if (_confirmPassword == null ||
            _password == null ||
            _email == null ||
            _firstName == null ||
            _lastName == null ||
            _month == null ||
            _confirmPassword == "" ||
            _password == "" ||
            _email == "" ||
            _firstName == "" ||
            _lastName == "") {
          throw FirebaseAuthException(
              code: "Register Error",
              message: "Please complete the Registration Form.");
        }
      } on FirebaseAuthException catch (e) {
        print(e.message);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.message!),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ));
        return;
      }
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (contex) => Center(child: CircularProgressIndicator()));

      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _email!, password: _password!);
        await FirebaseAuth.instance.currentUser
            ?.updateDisplayName('$_firstName $_lastName');
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => HomePage()),
            (Route<dynamic> route) => false);
        // add user details (Firestore)
        addUserDetails();
      } on FirebaseAuthException catch (e) {
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.message!),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ));
      }

      navigatorKey.currentState!.popUntil((route) => route.isFirst);
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/bg-register.png'),
                  fit: BoxFit.cover)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Color(0xFFEFB83C),
                ),
                margin: EdgeInsets.only(left: 20, right: 20, top: 50),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                              alignment: Alignment.centerLeft,
                              child: IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Image(
                                    image: AssetImage(
                                        'assets/images/back-icon.png'),
                                    color: Colors.black,
                                    height: 20,
                                  ))),
                          Text(
                            "Sign Up",
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w700,
                                fontSize: 24),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Email',
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Container(
                              height: 24,
                              child: TextFormField(
                                onChanged: (value) {
                                  _email = _emailController.text.trim();
                                },
                                keyboardType: TextInputType.emailAddress,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: _emailController,
                                decoration: InputDecoration(
                                    errorStyle: TextStyle(color: Colors.black),
                                    contentPadding: EdgeInsets.only(bottom: 12),
                                    hintText: 'email@example.com',
                                    border: UnderlineInputBorder()),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Password',
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Container(
                              height: 24,
                              child: TextFormField(
                                onChanged: (value) {
                                  _password = _passwordController.text.trim();
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: _passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(bottom: 12),
                                    hintText: '******',
                                    border: UnderlineInputBorder()),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Confirm Password',
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Container(
                              height: 24,
                              child: TextFormField(
                                onChanged: (value) {
                                  _confirmPassword =
                                      _confirmPasswordController.text.trim();
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: _confirmPasswordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(bottom: 12),
                                    hintText: '******',
                                    border: UnderlineInputBorder()),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'First Name',
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Container(
                              height: 24,
                              child: TextField(
                                onChanged: (value) {
                                  _firstName = _firstNameController.text.trim();
                                },
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r"[a-zA-Z]+|\s"))
                                ],
                                controller: _firstNameController,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(bottom: 12),
                                    hintText: 'Juggs',
                                    border: UnderlineInputBorder()),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Last Name',
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Container(
                              height: 24,
                              child: TextField(
                                onChanged: (value) {
                                  _lastName = _lastNameController.text.trim();
                                },
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r"[a-zA-Z]+|\s"))
                                ],
                                controller: _lastNameController,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(bottom: 12),
                                    hintText: 'Sentedih',
                                    border: UnderlineInputBorder()),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Stack(alignment: Alignment.bottomRight, children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Birthday',
                                style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Container(
                                height: 24,
                                child: TextField(
                                  readOnly: true,
                                  decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(bottom: 12),
                                      hintText: _dateDisplay,
                                      border: UnderlineInputBorder()),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: -10,
                          right: -10,
                          child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 30),
                              child: IconButton(
                                  onPressed: () {
                                    showDatePicker(
                                            builder: ((context, child) {
                                              return Theme(
                                                  data: Theme.of(context)
                                                      .copyWith(
                                                          colorScheme:
                                                              ColorScheme.light(
                                                    primary: Color(0xFFEFB83C),
                                                    onPrimary: Colors.black,
                                                  )),
                                                  child: child!);
                                            }),
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(
                                                DateTime.now().year - 200),
                                            lastDate: DateTime(
                                                DateTime.now().year + 1))
                                        .then((value) {
                                      if (value != null) {
                                        setState(() {
                                          _month = value.month;
                                          _day = value.day;
                                          _year = value.year;
                                          _dateDisplay = '$_month/$_day/$_year';
                                        });
                                      }
                                    });
                                  },
                                  icon: Icon(Icons.date_range))),
                        )
                      ]),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 30),
                        width: double.infinity,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.black)),
                            onPressed: signUp,
                            child: Text(
                              'Register',
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15),
                            )),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 30),
                        width: double.infinity,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: 1,
                              color: Colors.grey,
                            ),
                            Container(
                              width: 40,
                              color: Color(0xFFEFB83C),
                              child: Center(child: Text('or')),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 30),
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              foregroundColor:
                                  MaterialStateProperty.all(Colors.black),
                              side: MaterialStateProperty.all(BorderSide(
                                  color: Colors.black,
                                  width: 1.0,
                                  style: BorderStyle.solid))),
                          onPressed: () {
                            final provider = Provider.of<GoogleSignInProvider>(
                                context,
                                listen: false);
                            provider.googleLogin().then((value) =>
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => HomePage()),
                                    (Route<dynamic> route) => false));
                          },
                          label: Text('Sign up with Google',
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15)),
                          icon: Image(
                              image:
                                  AssetImage('assets/images/google-icon.png'),
                              width: 28,
                              height: 28,
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.center,
                            ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
