abstract class VCodeState {
  final int duration;

  VCodeState(this.duration);
}

class VerifyEnabled extends VCodeState {
  VerifyEnabled(int duration) : super(duration){
    //print("In state: " + this.runtimeType.toString());
  }
}

class VerifyDisabled extends VCodeState {
  VerifyDisabled(int duration) : super(duration){
    //print("In state: " + this.runtimeType.toString() + ", duration: " + duration.toString());
  }
}

class SendSMSError extends VCodeState {
  String errorMsg;

  SendSMSError(this.errorMsg) : super(30);
}