import 'dart:io';

import 'package:data_plugin/bmob/bmob.dart';
import 'package:data_plugin/bmob/bmob_file_manager.dart';
import 'package:data_plugin/bmob/response/bmob_error.dart';
import 'package:data_plugin/bmob/response/bmob_handled.dart';
import 'package:data_plugin/data_plugin.dart';
import 'package:dio/dio.dart';
typedef S ItemCreator<S>();

abstract class FileHelper{
  Future<dynamic> uploadFile(File file);
  Future<dynamic> downloadFile(String remote_url, String local_path);
  Future<dynamic>  deleteFile(String remote_url);
}

class BmobFileHelper extends FileHelper{
   Future<dynamic> uploadFile(File file) async{
    if (file == null) {
//      DataPlugin.toast("请先选择文件");
      throw Exception("No File Selected");
    }
//    DataPlugin.toast("上传中，请稍候……");
    try{
      var bmobFile = await BmobFileManager.upload(file);
//      print("${bmobFile.cdn}\n${bmobFile.url}\n${bmobFile.filename}");
//      DataPlugin.toast(          "上传成功：${bmobFile.cdn}\n${bmobFile.url}\n${bmobFile.filename}");
      return bmobFile;
    }catch(e){

      throw e;
    }
  }
    Future<dynamic> downloadFile(String remote_url, String savepath) async {
    if (remote_url == null) {
//      DataPlugin.toast("请先上传文件");
      throw Exception("No Remote File");
    }
    Dio dio = Dio();
    try{
      Response<dynamic> response = await dio.download(remote_url, savepath);
      print(response.toString());
      File file = File(savepath);
      var raf = file.openSync(mode: FileMode.write);
      // response.data is List<int> type
      raf.writeFromSync(response.data);
      await raf.close();
//      DataPlugin.toast("下载结束");
      return file;
    }catch(e){
      throw e;
    }

  }
   Future<dynamic>  deleteFile(String remote_url) async {
    if (remote_url == null) {
//      DataPlugin.toast("请先上传文件");
      throw Exception("No Remote File");
    }
    try{
      BmobHandled handled = await BmobFileManager.delete(remote_url);
//      DataPlugin.toast("删除成功：" + handled.msg);
      return handled;
    }catch(e){
      throw e;
    }
  }

  @override
  createInstance() {
    // TODO: implement createInstance
    return BmobFileHelper();
  }

}