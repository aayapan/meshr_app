	
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
    var rqid = utf8.encode(user+datetime.toString());
    String sha1Version = sha1.convert(rqid).toString();
    print(sha1Version);
    count++;
    return sha1Version;
  }



}