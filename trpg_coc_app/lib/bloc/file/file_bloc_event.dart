import 'package:equatable/equatable.dart';

abstract class FileBlocEvent extends Equatable {
  const FileBlocEvent();
}
class UploadFile extends FileBlocEvent{

  @override
  // TODO: implement props
  List<Object> get props => null;

  UploadFile();
}
class DownloadFile extends FileBlocEvent{

  @override
  // TODO: implement props
  List<Object> get props => null;

  DownloadFile();
}
class DeleteFile extends FileBlocEvent{

  @override
  // TODO: implement props
  List<Object> get props => null;

  DeleteFile();
}
class FileOperationResultGot extends FileBlocEvent{
  @override
  // TODO: implement props
  List<Object> get props => [];

}
