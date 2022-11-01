import 'dart:io';
import 'package:path/path.dart' as path;

class FileNameConvert {

  static List<String> convert(List<File> file, String rqid){
    

    List<String> newFile = [];

    for(int i = 0; i < file.length; i++){
      String filename = rqid.substring(0,rqid.length-1);      
      if (file.length > 1){
        filename += "(" + i.toString() + ")";
      }
      filename +=  path.extension(file[i].path);

      newFile.add(filename);
    }

    return newFile;

  }



}