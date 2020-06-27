import 'package:data_plugin/bmob/response/bmob_handled.dart';
import 'package:data_plugin/bmob/type/bmob_file.dart';
import 'file_helper.dart';
enum FileStatus{READY,OPERATING,COMPLETED}
enum FileOperateStatus{OPERATING,FAILURE,SUCCESS}
class FileRepository {
  String localPath=""; // currently use by local but can be not-uploaded
  dynamic remoteData = null; // downloaded remote file 's data..
  BmobFile remoteFile=BmobFile();

  FileStatus get status => _status;

  set status(FileStatus value) {
    _status = value;
  } // uploaded file's remote path
  FileStatus _status =FileStatus.READY;
  bool _hasError = false;
  String _msg = "";
  void setLocalFile(String path){this.localPath = path;}
  Map<String,dynamic> getOperateInfo(){return {'hasError':_hasError,'msg':_msg};}
  Future<FileOperateStatus> upload() async{
    this._status = FileStatus.OPERATING;
    try {
      BmobFile file = await FileHelper.uploadFile(localPath);
      this.remoteFile = file;

      this._status = FileStatus.COMPLETED;
      return FileOperateStatus.SUCCESS;
    }catch(e){
      setError(e);
      this._status = FileStatus.COMPLETED;
      return FileOperateStatus.FAILURE;
    };

  }
  Future<FileOperateStatus> delete() async{

    this._status = FileStatus.OPERATING;
    if(remoteFile==null || remoteFile.url==""){
      print("No file to delete at all");
      this._status = FileStatus.COMPLETED;
      return FileOperateStatus.FAILURE;
    }
    try{
      BmobHandled handled = await FileHelper.deleteFile(remoteFile.url);
      print(handled.msg);
      this.remoteFile=BmobFile();
      this._status = FileStatus.COMPLETED;
      return FileOperateStatus.SUCCESS;
    }catch(e){
      setError(e);
      this._status = FileStatus.COMPLETED;
      return FileOperateStatus.FAILURE;
    }
  }
  Future<FileOperateStatus> download() async{

    this._status = FileStatus.OPERATING;
    try{
      remoteData = await FileHelper.downloadFile(remoteFile.url, null);
      this._status = FileStatus.COMPLETED;
      return FileOperateStatus.SUCCESS;
    }catch(e){
      setError(e);
      this._status = FileStatus.COMPLETED;
      return FileOperateStatus.FAILURE;
    }
  }

  void setError(e){
    _hasError = true; _msg = e.toString();
  }
  void dismissError(){_hasError = false; _msg ="";}

  bool get hasError => _hasError;

  set hasError(bool value) {
    _hasError = value;
  }

  String get msg => _msg;

  set msg(String value) {
    _msg = value;
  }
}