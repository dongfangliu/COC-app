abstract class VCodeEvent {}

class VerifyButtonPressed extends VCodeEvent {
  String phone;

  VerifyButtonPressed(this.phone);
}

class Tick extends VCodeEvent {
  final int duration;

  Tick(this.duration);

  @override
  String toString() => "Tick { duration: $duration }";
}

