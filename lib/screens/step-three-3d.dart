// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, avoid_print, sort_child_properties_last

import 'dart:io';

import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meshr_app/data/local-storage.dart';
import 'package:meshr_app/linker/request_id_generator.dart';
import 'package:meshr_app/linker/send_to_server.dart';
import 'package:meshr_app/linker/set_filename.dart';
import 'package:meshr_app/screens/main_menu.dart';
import 'package:meshr_app/screens/step-two-3d.dart';
import 'package:meshr_app/screens/step-two-txt.dart';
import 'package:meshr_app/screens/step-two.dart';
import 'package:meshr_app/screens/view-output-3d.dart';
import 'package:meshr_app/widgets/generate-footer.dart';
import 'package:meshr_app/widgets/generate-header.dart';
import 'package:meshr_app/widgets/proceed-button.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class GenerateStepThree3D extends StatefulWidget {
  List<File> displayImages;
  GenerateStepThree3D({
    Key? key,
    required this.displayImages,
  }) : super(key: key);

  @override
  State<GenerateStepThree3D> createState() => _GenerateStepThree3DState();
}

class _GenerateStepThree3DState extends State<GenerateStepThree3D> {
  File? _image;

  final _myBox = Hive.box('FilesCollection');
  FilesLocalStorage fls = FilesLocalStorage();

  List<File> passImages = [];

  FileHandler fh = FileHandler();
  RequestHandler rh = RequestHandler();
  late List<String> _filename;

  bool _clickable = false;

  Future captureImage(bool update, int index) async {
    try {
      final image = await ImagePicker().pickImage(
          source: ImageSource.camera, preferredCameraDevice: CameraDevice.rear);
      if (image == null) return;
      final img = await saveImagePermanently(image.path);
      print("IMAGE PATH: ${img.path}");

      setState(() {
        _image = img;
      });
    } on PlatformException catch (e) {
      print(e);
    }
  }

  Future<File> saveImagePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();

    final name = basename(imagePath);
    final image = File('${directory.path}/$name');
    return File(imagePath).copy(image.path);
  }

  void deleteFilesExceptExtension(String suffix, String path) {
    final dir = Directory(path);
    dir.list(recursive: true).listen((file) {
      if (file is File && !file.path.endsWith(suffix)) file.deleteSync();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    passImages = widget.displayImages;

    if (passImages.length >= 3) {
      _clickable = true;
    }

    print('FILES: $passImages');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xFFEFB83C),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: ImageIcon(AssetImage("assets/images/back-icon.png")),
            iconSize: 40.0,
            color: Colors.white,
          ),
        ),
        body: Container(
          width: double.infinity,
          color: Color(0xFFEFB83C),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GenerateHeaderText(
                  header: "Step 3:",
                  subheader:
                      "Review your photos that you took. Tap the photo that you want to change."),
              SizedBox(
                height: 50,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          captureImage(true, 0).then((value) {
                            if (_image == null) {
                              setState(() {});
                            } else {
                              setState(() {
                                passImages[0] = _image!;
                              });
                              print("Change Navigation");
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => GenerateStepThree3D(
                                          displayImages: passImages)));
                            }
                          });
                        },
                        child: Container(
                          height: 110,
                          width: 110,
                          decoration: BoxDecoration(
                              border: Border.all(width: 2, color: Colors.white),
                              color: Colors.transparent),
                          child: Image.file(widget.displayImages[0],
                              fit: BoxFit.cover),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          captureImage(true, 1).then((value) {
                            if (_image == null) {
                              setState(() {});
                            } else {
                              setState(() {
                                passImages[1] = _image!;
                              });
                              print("Change Navigation");
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => GenerateStepThree3D(
                                          displayImages: passImages)));
                            }
                          });
                        },
                        child: Container(
                          height: 110,
                          width: 110,
                          decoration: BoxDecoration(
                              border: Border.all(width: 2, color: Colors.white),
                              color: Colors.transparent),
                          child: Image.file(
                            widget.displayImages[1],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (widget.displayImages.length < 3) {
                            captureImage(false, 2).then((value) {
                              if (_image == null) {
                                setState(() {});
                              } else {
                                passImages.add(_image!);
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            GenerateStepThree3D(
                                                displayImages: passImages)));
                              }
                            });
                          } else {
                            captureImage(true, 2).then((value) {
                              if (_image == null) {
                                setState(() {});
                              } else {
                                setState(() {
                                  passImages[2] = _image!;
                                });
                                print("Change Navigation");
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            GenerateStepThree3D(
                                                displayImages: passImages)));
                              }
                            });
                          }
                        },
                        child: Container(
                            height: 110,
                            width: 110,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 2, color: Colors.white),
                                color: Colors.transparent),
                            child: widget.displayImages.length == 2
                                ? Center(
                                    child: Text(
                                      "+",
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 50,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                : Image.file(
                                    widget.displayImages[2],
                                    fit: BoxFit.cover,
                                  )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: widget.displayImages.length <= 4
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (widget.displayImages.length < 4) {
                            captureImage(false, 3).then((value) {
                              if (_image == null) {
                                setState(() {});
                              } else {
                                passImages.add(_image!);
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            GenerateStepThree3D(
                                                displayImages: passImages)));
                              }
                            });
                          } else {
                            captureImage(true, 3).then((value) {
                              if (_image == null) {
                                setState(() {});
                              } else {
                                setState(() {
                                  passImages[3] = _image!;
                                });
                                print("Change Navigation");
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            GenerateStepThree3D(
                                                displayImages: passImages)));
                              }
                            });
                          }
                        },
                        child: Visibility(
                          visible: passImages.length >= 3,
                          child: Container(
                              margin: widget.displayImages.length == 4
                                  ? EdgeInsets.only(right: 10)
                                  : EdgeInsets.zero,
                              height: 110,
                              width: 110,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 2, color: Colors.white),
                                  color: Colors.transparent),
                              child: widget.displayImages.length == 3
                                  ? Center(
                                      child: Text(
                                        "+",
                                        style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: 50,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  : Image.file(
                                      widget.displayImages.length >= 3
                                          ? widget.displayImages[3]
                                          : widget.displayImages[0],
                                      fit: BoxFit.cover,
                                    )),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (widget.displayImages.length < 5) {
                            captureImage(false, 4).then((value) {
                              if (_image == null) {
                                setState(() {});
                              } else {
                                passImages.add(_image!);
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            GenerateStepThree3D(
                                                displayImages: passImages)));
                              }
                            });
                          } else {
                            captureImage(true, 4).then((value) {
                              if (_image == null) {
                                setState(() {});
                              } else {
                                setState(() {
                                  passImages[4] = _image!;
                                });
                                print("Change Navigation");
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            GenerateStepThree3D(
                                                displayImages: passImages)));
                              }
                            });
                          }
                        },
                        child: Visibility(
                          visible: passImages.length >= 4,
                          child: Container(
                              height: 110,
                              width: 110,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 2, color: Colors.white),
                                  color: Colors.transparent),
                              child: widget.displayImages.length == 4
                                  ? Center(
                                      child: Text(
                                        "+",
                                        style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: 50,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  : Image.file(
                                      widget.displayImages.length >= 4
                                          ? widget.displayImages[4]
                                          : widget.displayImages[0],
                                      fit: BoxFit.cover,
                                    )),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (widget.displayImages.length < 6) {
                            captureImage(false, 5).then((value) {
                              if (_image == null) {
                                setState(() {});
                              } else {
                                passImages.add(_image!);
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            GenerateStepThree3D(
                                                displayImages: passImages)));
                              }
                            });
                          } else {
                            captureImage(true, 5).then((value) {
                              if (_image == null) {
                                setState(() {});
                              } else {
                                setState(() {
                                  passImages[5] = _image!;
                                });
                                print("Change Navigation");
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            GenerateStepThree3D(
                                                displayImages: passImages)));
                              }
                            });
                          }
                        },
                        child: Visibility(
                          visible: passImages.length >= 5,
                          child: Container(
                              height: 110,
                              width: 110,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 2, color: Colors.white),
                                  color: Colors.transparent),
                              child: widget.displayImages.length == 5
                                  ? Center(
                                      child: Text(
                                        "+",
                                        style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: 50,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  : Image.file(
                                      widget.displayImages.length >= 5
                                          ? widget.displayImages[5]
                                          : widget.displayImages[0],
                                      fit: BoxFit.cover,
                                    )),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                  margin: EdgeInsets.only(right: 15),
                  child: ProceedButton(
                      clickable: _clickable,
                      onPressed: () async {
                        String rqid = RequestID.create("user");
                        _filename = FileNameConvert.convert(passImages, rqid);
                        await fh.upload(rqid, passImages).then((value) {
                          rh.im2ms_request(rqid, fh, _filename);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ViewOutput3D()));
                        });
                      }))
            ],
          ),
        ),
        bottomNavigationBar: GenerateBottomNav(helpFunction: () {}));
  }
}
