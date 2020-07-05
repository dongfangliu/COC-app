import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:trpgcocapp/bloc/file/file_repository.dart';
import '../bloc.dart';
import 'file_bloc_state.dart';

class FileBloc extends Bloc<FileBlocEvent, FileBlocState> {
  FileRepository repository = new FileRepository();
  FileBloc(){repository.init();}

  @override
  FileBlocState get initialState => FileReady();

  @override
  Stream<FileBlocState> mapEventToState(
    FileBlocEvent event,
  ) async* {
    if (state is FileReady) {
      yield* _mapForReadyState(event);
    }else if(state is FileOperationFailure){
      if(event is FileOperationResultGot){
        yield FileReady();
      }
    }else if(state is FileOperationSuccess) {
      if(event is FileOperationResultGot){
        yield FileReady();
      }
    }
  }

  Stream<FileBlocState> _mapForReadyState(FileBlocEvent event) async* {
    if ((event is UploadFile) ||
        (event is DeleteFile) ||
        (event is DownloadFile)) {
      FileOperateStatus status;
      yield FileOperating();
      if (event is UploadFile) {
        status = await repository.upload();
      }
      if (event is DeleteFile) {
        status = await repository.delete();
      }
      if (event is DownloadFile) {
        status = await repository.download();
      }
      if (status == FileOperateStatus.SUCCESS) {
        yield FileOperationSuccess();
      } else {
        yield FileOperationFailure(repository.msg);
      }
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
