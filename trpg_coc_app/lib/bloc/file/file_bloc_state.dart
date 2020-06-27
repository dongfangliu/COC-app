import 'package:equatable/equatable.dart';
abstract class FileBlocState extends Equatable {
  const FileBlocState();
}

class FileReady extends FileBlocState {
  @override
  List<Object> get props => [];
}

class FileOperating  extends FileBlocState{
  @override
  // TODO: implement props
  List<Object> get props => [];

}
class FileOperationFailure extends FileBlocState{
  String msg;
  @override
  // TODO: implement props
  List<Object> get props => [msg];

  FileOperationFailure(this.msg);

}
class FileOperationSuccess extends FileBlocState{
  String msg="";
  @override
  // TODO: implement props
  List<Object> get props => [msg];

  FileOperationSuccess();

}
