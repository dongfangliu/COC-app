import 'dart:io';

import 'package:data_plugin/bmob/type/bmob_file.dart';
import 'package:dio/dio.dart';
import 'package:trpgcocapp/bloc/file/file_helper.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
class FileGenerator{
  static Future<File> fromAsset(String pathRelativeToAssets) async {
    try {
      final byteData = await rootBundle.load('assets/$pathRelativeToAssets');
      final file =await new File('${(await getTemporaryDirectory()).path}/$pathRelativeToAssets').create(recursive: true);
      await file.writeAsBytes(byteData.buffer.asUint8List(
          byteData.offsetInBytes, byteData.lengthInBytes));
      return file;
    }catch(e){
      throw  e;
    }
  }
  static Future<File> fromURL(String url,String filename) async {
    Dio dio = Dio();
    try{
      Response<dynamic> response = await dio.download(url, filename);
      print(response.toString());
      File file = File(filename);
      var raf = file.openSync(mode: FileMode.write);
      // response.data is List<int> type
      raf.writeFromSync(response.data);
      await raf.close();
      return file;
    }catch(e){
      throw e;
    }
  }
}

abstract class COCFile{

}

class COCEditableFile<T extends COCServerFile> extends COCFile{
  File file=null;
  T serverFile=null;
  COCEditableFile(this.file);
}

abstract class COCServerFile<T>  extends COCFile{
  T serverfile;
  toServer(File file);
  COCServerFile(this.serverfile);
  COCServerFile.from(File file){
    toServer(file);
  }
}

class COCBmobServerFile extends  COCServerFile<BmobFile>{
  COCBmobServerFile.from(File file) : super.from(file);
  @override
  toServer(File file) async {
    try {
      if (this.serverfile != null) {
        await BmobFileHelper().deleteFile(serverfile.url);
      }
      this.serverfile = await BmobFileHelper().uploadFile(file);
    } catch (e) {
      throw e;
    }
  }
}
class COCBmobEditable extends COCEditableFile<COCBmobServerFile>{
  COCBmobEditable({File file=null}):super(file);
}