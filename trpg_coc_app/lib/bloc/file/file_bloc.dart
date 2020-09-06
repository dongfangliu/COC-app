import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:trpgcocapp/bloc/common/timecost_op/timecost_operation_bloc.dart';
import 'package:trpgcocapp/bloc/common/timecost_op/timecost_operation_event.dart';
import 'package:trpgcocapp/bloc/common/timecost_op/timecost_operation_state.dart';
import 'package:trpgcocapp/bloc/file/file_helper.dart';
import 'package:trpgcocapp/bloc/file/file_repository.dart';
import 'file_bloc_event.dart';

class FileBloc extends TimecostOperationBloc{
  FileRepository<BmobFileHelper> repository = new FileRepository<BmobFileHelper>();
  FileBloc(){
    repository.init();
    operator.addEventActionPair(UploadFile(), repository.upload);
    operator.addEventActionPair(DeleteFile(), repository.delete);
    operator.addEventActionPair(DownloadFile(), repository.download);

  }
  @override
  TimecostOperationState get initialState => ReadyToOperate();
  @override
  Future<void> close() {
    return super.close();
  }
}
