import 'dart:io';

import 'package:data_plugin/bmob/type/bmob_file.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:trpgcocapp/bloc/file/file_helper.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:regexed_validator/regexed_validator.dart';
part 'coc_file.g.dart';

class FileGenerator {
  static Future<File> fromAsset(String pathToAssets) async {
    try {
      final byteData = await rootBundle.load('$pathToAssets');
      final file = await new File(
              '${(await getTemporaryDirectory()).path}/$pathToAssets')
          .create(recursive: true);
      await file.writeAsBytes(byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
      return file;
    } catch (e) {
      throw e;
    }
  }

  static Future<File> fromURL(String url, String filename) async {
    Dio dio = Dio();
    try {
      Response<dynamic> response = await dio.download(url, filename);
      print(response.toString());
      File file = File(filename);
      var raf = file.openSync(mode: FileMode.write);
      // response.data is List<int> type
      raf.writeFromSync(response.data);
      await raf.close();
      return file;
    } catch (e) {
      throw e;
    }
  }
}

enum FILE_SOURCE { ASSET, STORAGE, NETWORK ,INVALID}

@JsonSerializable()
class COC_File extends BmobFile{
  FILE_SOURCE file_source = FILE_SOURCE.INVALID;
  Future<void> Update(File file) async{
    if(file_source==FILE_SOURCE.NETWORK){
      await BmobFileHelper().deleteFile(url);
    }
    await Upload(file);
  }
  Future<void> Upload(File file) async{
    BmobFile bmobFile= await BmobFileHelper().uploadFile(file);
    this.url = bmobFile.url;
    this.filename = bmobFile.filename;
    this.cdn = bmobFile.cdn;
    this.type = bmobFile.type;
    this.file_source = FILE_SOURCE.NETWORK;
    return true;
  }
  COC_File.Storage({url}) {
    this.url = url;
    this.file_source = FILE_SOURCE.ASSET;
  }

  COC_File.Asset({url}) {
    this.url = url;
    this.file_source = FILE_SOURCE.ASSET;
  }
  COC_File.Network({url}) {
    this.url = url;
    this.file_source = FILE_SOURCE.NETWORK;
  }
  void setFile(FILE_SOURCE file_source ,String url) {
    this.file_source = file_source;
    this.url = url;
  }


  factory COC_File.fromJson(Map<String, dynamic> json) =>
      _$COC_FileFromJson(json);

  Map<String, dynamic> toJson() => _$COC_FileToJson(this);

  COC_File();
}

ImageProvider buildCOCFileImg(COC_File imgFile) {
  switch(imgFile.file_source) {
    case FILE_SOURCE.ASSET:
      return AssetImage(imgFile.url);
      break;
    case FILE_SOURCE.STORAGE:
      return FileImage(File(imgFile.url));
      break;
    case FILE_SOURCE.NETWORK:
      return NetworkImage(imgFile.url);
      break;
    case FILE_SOURCE.INVALID:
    // TODO: Handle this case.
      return NetworkImage("https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=1875705305,2952422048&fm=26&gp=0.jpg");
      break;
  }
}
