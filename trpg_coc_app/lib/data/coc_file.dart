import 'dart:io';

import 'package:data_plugin/bmob/type/bmob_file.dart';
import 'package:trpgcocapp/bloc/file/file_helper.dart';

abstract class CoCFile<T>{
  T file;
  Future<T> fromLocalFile(File file);
  Future<File> toLocalFile(T file,String save_path);
}
class LocalFile extends CoCFile<File>{
  String defaultPath = "";
  LocalFile({this.defaultPath=""});

  @override
  Future<File> fromLocalFile(File file) async {
    return file;
  }

  @override
  Future<File> toLocalFile(File file,String save_path) async{
    return file;
  }
}

class COCBmobFile extends  CoCFile<BmobFile>{
  @override
  Future<BmobFile> fromLocalFile(File file) async {
    BmobFile f = await BmobFileHelper().uploadFile(file.path);
    return f;
  }

  @override
  Future<File> toLocalFile(BmobFile file,String save_path) async {
    File f = await    BmobFileHelper().downloadFile(file.url, save_path);
    return f;
  }
}