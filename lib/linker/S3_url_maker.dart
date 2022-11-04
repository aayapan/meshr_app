import 'dart:convert';
import 'package:http/http.dart' as http;

class UrlMaker {
  bool? success;
  String message = '';
  bool isGenerated = false;
  Uri uploadUrl = Uri();
  Uri downloadUrl = Uri();
  String fileName = '';

  Uri url = Uri.parse('http://18.183.40.87/generatePresignedUrl');

  Future<Uri> createURL(String fileType) async{

    try {

      
      Map body = {"fileType": fileType};
      var response = await http.post(url, body:body);
      print("Hello");
      var result = jsonDecode(response.body);
      print(result);

      if(result["success"] != null){
        success = result["success"];
        message = result['message'];
        print("Hello2");
        if (response.statusCode == 201) {
          isGenerated = true;
          print("Hello3");
          uploadUrl = Uri.parse(result["uploadUrl"]);
          var string = uploadUrl.toString().split('/');
          fileName = string[3].substring(0, 40);
          downloadUrl = Uri.parse(result["downloadUrl"]);
          print("Hello4");
          return uploadUrl;
        } else {
          throw "URL not generated";
        }

      } else {
        throw "Failed Connecting to Server";
      }

    } catch (e) {
      throw e;
    }

  }

}