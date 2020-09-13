import 'dart:io';

import 'package:data_plugin/bmob/type/bmob_file.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:trpgcocapp/bloc/file/file_helper.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
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

abstract class COCFile {}

enum FILE_SOURCE { ASSET, STORAGE, NETWORK }
enum FILE_TYPE { MEME, IMAGE, VIDEO, DOCUMENT }

class COCEditableFile<T extends COCServerFile> extends COCFile {
  FILE_SOURCE filesource;
  FILE_TYPE filetype;
  String filePath = "";
  File file = null;
  T serverFile = null;
  COCEditableFile(this.file);
  bool hasDefaultFile() {
    return (filePath != null) && (filePath != "");
  }

  COCEditableFile.Image(
      {this.filesource = FILE_SOURCE.ASSET,
      @required this.filePath}) {
    this.filetype = FILE_TYPE.IMAGE;
  }
  COCEditableFile.AssetImage({@required this.filePath}) {
    this.filetype = FILE_TYPE.IMAGE;
    this.filesource = FILE_SOURCE.ASSET;
  }
  COCEditableFile.NetworkImage({@required this.filePath}) {
    this.filetype = FILE_TYPE.IMAGE;
    this.filesource = FILE_SOURCE.NETWORK;
  }
  void setPath(
      {FILE_SOURCE file_source = FILE_SOURCE.ASSET, @required String path}) {
    this.filesource = file_source;
    this.filePath = path;
  }

  void setFile(File file) {
    if(file==null){return;}
    this.file = file;
    this.filesource = FILE_SOURCE.STORAGE;
  }

  void checkFileBeforeUpload() async {
    if (file == null) {
      switch (filesource) {
        case FILE_SOURCE.ASSET:
          this.file = await FileGenerator.fromAsset(filePath);
          break;

        case FILE_SOURCE.STORAGE:
          // TODO: Handle this case.
          break;
        case FILE_SOURCE.NETWORK:
          Directory tempDir = await getTemporaryDirectory();
          this.file = await FileGenerator.fromURL(
              this.filePath, tempDir.path + "/temp0");
          // TODO: Handle this case.
          break;
      }
    }
  }
}

@JsonSerializable()
class COCServerFile<T> extends COCFile {
  @JsonKey(fromJson: _dataFromJson, toJson: _dataToJson)
  T serverfile;
  Future<T> toServer(File file) {}
  COCServerFile();
  from(File file) async {
    this.serverfile = await toServer(file);
  }

  factory COCServerFile.fromJson(Map<String, dynamic> json) =>
      _$COCServerFileFromJson(json);
  Map<String, dynamic> toJson() => _$COCServerFileToJson(this);
}

@JsonSerializable()
class COCBmobServerFile extends COCServerFile<BmobFile> {
  COCBmobServerFile() : super();

  @override
  Future<BmobFile> toServer(File file) async {
    try {
      if (this.serverfile != null) {
        await BmobFileHelper().deleteFile(serverfile.url);
      }

      this.serverfile = await BmobFileHelper().uploadFile(file);
      return this.serverfile;
    } catch (e) {
      throw e;
    }
  }
}

class COCBmobEditable extends COCEditableFile<COCBmobServerFile> {
  COCBmobEditable({File file = null}) : super(file);
  COCBmobEditable.Image(
      {FILE_SOURCE filesource = FILE_SOURCE.ASSET,
      @required String defaultFilePath})
      : super.Image(filesource: filesource, filePath: defaultFilePath) {}
  COCBmobEditable.AssetImage({@required String defaultFilePath})
      : super.AssetImage(filePath: defaultFilePath) {}
  COCBmobEditable.NetworkImage({@required String defaultFilePath})
      : super.NetworkImage(filePath: defaultFilePath) {}
}

T _dataFromJson<T>(Map<String, dynamic> input) => input['value'] as T;

Map<String, dynamic> _dataToJson<T>(T input) => {'value': input};

ImageProvider buildCOCEditableImg(COCBmobEditable imgFile) {
  switch(imgFile.filesource) {
    case FILE_SOURCE.ASSET:
      return AssetImage(imgFile.filePath);
      break;
    case FILE_SOURCE.STORAGE:
      return FileImage(imgFile.file);
      break;
    case FILE_SOURCE.NETWORK:
      return NetworkImage(imgFile.filePath);
      break;
  }
}