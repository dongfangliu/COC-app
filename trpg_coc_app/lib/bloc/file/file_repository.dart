import 'package:data_plugin/bmob/bmob.dart';
import 'package:data_plugin/bmob/response/bmob_handled.dart';
import 'package:data_plugin/bmob/type/bmob_file.dart';
import 'file_helper.dart';

enum FileStatus { READY, OPERATING, COMPLETED }
enum FileOperateStatus { OPERATING, FAILURE, SUCCESS }

class FileRepository {
  String localPath = ""; // currently use by local but can be not-uploaded
  dynamic remoteData = null; // downloaded remote file 's data..
  BmobFile remoteFile = BmobFile();

  FileStatus get status => _status;

  set status(FileStatus value) {
    _status = value;
  } // uploaded file's remote path

  FileStatus _status = FileStatus.READY;
  bool _hasError = false;
  String _msg = "";

  void init() {
    String appId = 'c0e5dbfe38a164ba90d2c4c7e1c846a9';
    String apiKey = '6fc3e0520028a3a095ebb8aa1097c10e';
    String appHost = 'https://api2.bmob.cn';
    Bmob.init(appHost, appId, apiKey);
  }

  void setLocalFile(String path) {
    this.localPath = path;
  }

  Map<String, dynamic> getOperateInfo() {
    return {'hasError': _hasError, 'msg': _msg};
  }

  Future<FileOperateStatus> upload() async {
    this._status = FileStatus.OPERATING;
    try {
      BmobFile file = await FileHelper.uploadFile(localPath);
      this.remoteFile = file;
      this._status = FileStatus.COMPLETED;
      return FileOperateStatus.SUCCESS;
    } catch (e) {
      setError(e);
      this._status = FileStatus.COMPLETED;
      return FileOperateStatus.FAILURE;
    }
    ;
  }

  Future<FileOperateStatus> delete() async {
    this._status = FileStatus.OPERATING;
    if (remoteFile == null || remoteFile.url == "") {
      String e = "No file to delete at all";
      setError(e);
      this._status = FileStatus.COMPLETED;
      return FileOperateStatus.FAILURE;
    }
    try {
      BmobHandled handled = await FileHelper.deleteFile(remoteFile.url);
      setMsg(handled.msg);
      this.remoteFile = BmobFile();
      this._status = FileStatus.COMPLETED;
      return FileOperateStatus.SUCCESS;
    } catch (e) {
      setError(e);
      this._status = FileStatus.COMPLETED;
      return FileOperateStatus.FAILURE;
    }
  }

  Future<FileOperateStatus> download() async {
    this._status = FileStatus.OPERATING;
    try {
      remoteData = await FileHelper.downloadFile(remoteFile.url, null);
      this._status = FileStatus.COMPLETED;
      return FileOperateStatus.SUCCESS;
    } catch (e) {
      setError(e);
      this._status = FileStatus.COMPLETED;
      return FileOperateStatus.FAILURE;
    }
  }

  void setMsg(String msg){this._msg =msg;}
  void setError(e) {
    _hasError = true;
    setMsg(e.toString());
  }

  void dismissError() {
    _hasError = false;
    setMsg("");
  }

  bool get hasError => _hasError;

  set hasError(bool value) {
    _hasError = value;
  }

  String get msg => _msg;

  set msg(String value) {
    _msg = value;
  }
}
