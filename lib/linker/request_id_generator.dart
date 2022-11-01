	
  import 'package:crypto/crypto.dart';
  import 'dart:convert';

class RequestID {

  static int count= 0;

  static final RequestID _singleton = RequestID._internal();

    factory RequestID() {
    return _singleton;
  }

  RequestID._internal();

  static String create(String user){
    DateTime datetime = DateTime.now();
    String date = DateTime(datetime.year, datetime.month, datetime.day).toString().replaceAll("00:00:00.000", "");
    var rqid = utf8.encode(user);
    String sha1Version = sha1.convert(rqid).toString();
    sha1Version += "_"  + count.toString() + "_" + date;
    print(sha1Version);
    count++;
    return sha1Version;
  }



}