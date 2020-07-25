import 'dart:io';

import 'package:data_plugin/bmob/bmob.dart';
import 'package:data_plugin/bmob/response/bmob_handled.dart';
import 'package:data_plugin/bmob/type/bmob_file.dart';
import 'file_helper.dart';
import 'package:trpgcocapp/bloc/common/timecost_op/timecost_operator.dart';


class FileRepository<fileHelper extends FileHelper> {
  String localPath = ""; // currently use by local but can be not-uploaded
  String defaultRemoteURL= "";
  FileRepository();
  FileRepository.url(this.defaultRemoteURL);

  ItemCreator<fileHelper> _helperCreator;
  fileHelper _helper;
  dynamic remoteData = null; // downloaded remote file 's data..
  BmobFile remoteFile = BmobFile(); // uploaded file's remote path


  void init() {
    _helper = _helperCreator();
    String appId = 'c0e5dbfe38a164ba90d2c4c7e1c846a9';
    String apiKey = '6fc3e0520028a3a095ebb8aa1097c10e';
    String appHost = 'https://api2.bmob.cn';
    Bmob.init(appHost, appId, apiKey);
  }

  void setLocalFile(String path) {
    this.localPath = path;
  }


  Future<OperateResult> upload() async {
    try {
      BmobFile file = await _helper.uploadFile(File(localPath));
      this.remoteFile = file;
      OperateResult result=OperateResult();result.isSuccess=true;
      result.result=remoteFile;result.msg="success upload";
      return result;
    } catch (e) {
      OperateResult result=OperateResult();result.isSuccess=false;result.msg=e.toString();
      return result;
    }
    ;
  }

  Future<OperateResult> delete() async {
    if (remoteFile == null || remoteFile.url == "") {
      String e = "No file to delete at all";
      OperateResult result=OperateResult();result.isSuccess=false;result.msg=e.toString();
      return result;
    }
    try {
      BmobHandled handled = await _helper.deleteFile(remoteFile.url);
      this.remoteFile = BmobFile();

      OperateResult result=OperateResult();result.isSuccess=true;
      result.result=handled;result.msg=handled.msg;
      return result;
    } catch (e) {
      OperateResult result=OperateResult();result.isSuccess=false;result.msg=e.toString();
      return result;
    }
  }

  Future<OperateResult> download() async {
    try {
      remoteData = await _helper.downloadFile(remoteFile.url, null);
      OperateResult result=OperateResult();
      result.isSuccess=true;
      result.result=remoteData;
      result.msg = "download success";
      return result;
    } catch (e) {
      OperateResult result=OperateResult();result.isSuccess=false;result.msg=e.toString();
      return result;
    }
  }


}
