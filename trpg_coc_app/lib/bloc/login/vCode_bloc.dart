import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:trpgcocapp/bloc/login/login_result.dart';
import 'package:trpgcocapp/bloc/login/vCode_events.dart';
import 'package:trpgcocapp/bloc/login/vCode_states.dart';
import 'package:trpgcocapp/controller/Bmob/user_connector.dart';

class Ticker {
  static const int ticks = 30;

  Stream<int> tick(){
    return Stream.periodic(
      Duration(seconds: 1), (x) => ticks - x - 1
    ).take(ticks);
  }
}

class VCodeBloc extends Bloc<VCodeEvent, VCodeState> {
  final int _duration = 30;
  final Ticker _ticker = Ticker();
  StreamSubscription<int> _tickerSubscription;

  @override
  VCodeState get initialState => VerifyEnabled(_duration);

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  @override
  Stream<VCodeState> mapEventToState(VCodeEvent event) async* {
    if (event is VerifyButtonPressed) {
      LoginResultMsgs loginResultMsg = await UserConnector.sendSMS(event.phone);
      if (loginResultMsg == LoginResultMsgs.SMSSent) {
        yield VerifyDisabled(_duration);
        _tickerSubscription?.cancel();
        _tickerSubscription = _ticker.tick().listen(
          (duration) => add(Tick(duration))
        );
      }
      if (loginResultMsg == LoginResultMsgs.WrongPhoneFormat){
        yield VerifyEnabled(_duration);
        yield SendSMSError("Please check your phone number");
      }
      if (loginResultMsg == LoginResultMsgs.NetworkFailure) {
        yield VerifyEnabled(_duration);
        yield SendSMSError("Please check your network");
      }
      if (loginResultMsg == LoginResultMsgs.UnknownFailure) {
        yield VerifyEnabled(_duration);
        yield SendSMSError("Unknown error");
      }
    }
    if (event is Tick){
      yield event.duration > 0 ?
        VerifyDisabled(event.duration) : VerifyEnabled(_duration);
    }
  }
}