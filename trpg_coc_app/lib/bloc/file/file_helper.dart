import 'dart:io';

import 'package:data_plugin/bmob/bmob_file_manager.dart';
import 'package:data_plugin/bmob/response/bmob_error.dart';
import 'package:data_plugin/bmob/response/bmob_handled.dart';
import 'package:data_plugin/data_plugin.dart';
import 'package:dio/dio.dart';


class FileHelper{
  static Future<dynamic> uploadFile(String path) async{
    if (path == null) {
      DataPlugin.toast("请先选择文件");
      return null;
    }
    DataPlugin.toast("上传中，请稍候……");
    File file = new File(path);
    try{
      var bmobFile = await BmobFileManager.upload(file);
      print("${bmobFile.cdn}\n${bmobFile.url}\n${bmobFile.filename}");
      DataPlugin.toast(
          "上传成功：${bmobFile.cdn}\n${bmobFile.url}\n${bmobFile.filename}");
      return bmobFile;
    }catch(e){

      throw e;
    }
  }
  static Future<dynamic> downloadFile(String url, String path) async {
    if (url == null) {
      DataPlugin.toast("请先上传文件");
      return null;
    }
    Dio dio = Dio();
    try{
      Response<dynamic> response = await dio.download(url, path);
      print(response.toString());
      print(response.data);
      DataPlugin.toast("下载结束");
      return response.data;
    }catch(e){
      throw e;
    }

  }
  static Future<dynamic>  deleteFile(String url) async {
    if (url == null) {
      DataPlugin.toast("请先上传文件");
      return null;
    }
    try{
      BmobHandled handled = await BmobFileManager.delete(url);
      DataPlugin.toast("删除成功：" + handled.msg);
      return handled;
    }catch(e){
      throw e;
    }
  }
}