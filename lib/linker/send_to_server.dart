/*

Current Version: Upload only

File Handler
  Used for uploading one or more images.
Request Handler
  Used for sending non binary information to the server.

How to use:

1. Create a Global FileHandler and RequestHandler
2. In the function create a local variable that will store a generated RequestID
   String rqid = RequestID.create();
3. use this to send required information per function
4. use the file handler first when the request involves images
   onPressed: () async {
                    String rqid = RequestID.create("user");
                    <List<String>>_filename = FileNameConvert.convert(<List<File>>_photos, rqid);                  
                    await fh.upload(rqid, _photos);
                    rh.im2im_request(rqid, prompt, fh, _filename);
              }
5. you can use clear for FileHandlers, to clear the file list

*/
import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;


import 'S3_url_maker.dart';


Uri PYTHON_SERVER = Uri.parse("http://18.183.246.22:8080/req");




class  FileHandler{


  final List<Uri> uploadUrl = [];
  final List<Uri> downloadUrl = [];
  final List<String> fileName = [];
  UrlMaker urlmaker= UrlMaker();

  Future<void> upload(String rqid, List<File> file) async{
    try {

      for(int i =0; i < file.length; i++) {
        Uri uu = await urlmaker.createURL(path.extension(file[i].path));
        File f = File(file[i].path);
        uploadUrl.add(urlmaker.uploadUrl);
        downloadUrl.add(urlmaker.downloadUrl);
        fileName.add(urlmaker.fileName);
        print(fileName[i]);

        var response = await http.put(uploadUrl[i], body: f.readAsBytesSync());
        if (response.statusCode != 200) {
          throw ('Error in uploading');
        }
      }
    } catch (e) {
      throw (e);
    }
  }

  void clear() {
    uploadUrl.clear();
    downloadUrl.clear();
    fileName.clear();
  }

}

class RequestHandler{

  bool requestSuccess = true;

  void tx2im_request(String rqid, String prompt){
    request ({"RequestID" : rqid, "Prompt" : prompt, "RequestType" : "TX2IM"});
  }

  void im2im_request(String rqid, String prompt, FileHandler fh, List<String> fn){
    request ({"RequestID" : rqid, "Prompt" : prompt, "RequestType" : "IM2IM", "DownloadUrl" : fh.fileName.toString(), "FileName" : fn.toString()});
  }
  
  void im2ms_request(String rqid, FileHandler fh, List<String> fn){
    request ({"RequestID" : rqid, "RequestType" : "IM2MS", "DownloadUrl" : fh.fileName.toString(), "FileName" : fn.toString()});
  }
  

  Future<void> request(Map body) async{

    try{
      var response = await http.post(PYTHON_SERVER, body: json.encode(body));

      if (response.statusCode != 200){
         throw "Request Not Processed";
      }

      print(response.body);
    } catch (e) {
      throw (e);
    }

  }


}

