import 'dart:convert';
import 'package:http/http.dart' as http;

class UrlMaker {
  bool? success;
  String message = '';
  bool isGenerated = false;
  Uri uploadUrl = Uri();
  Uri downloadUrl = Uri();
  String fileName = '';

  Uri url = Uri.parse('http://54.65.241.79/generatePresignedUrl');

  Future<Uri> createURL(String fileType) async{

    try {

      
      Map body = {"fileType": fileType};
      var response = await http.post(url, body:body);
      print("Hello");
      var result = jsonDecode(response.body);


      if(result["success"] != null){
        success = result["success"];
        message = result['message'];

        if (response.statusCode == 201) {
          isGenerated = true;
          uploadUrl = Uri.parse(result["uploadUrl"]);
          var string = uploadUrl.toString().split('/');
          fileName = string[3].substring(0, 40);
          downloadUrl = Uri.parse(result["downloadUrl"]);
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