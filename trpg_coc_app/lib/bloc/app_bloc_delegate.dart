import 'package:bloc/bloc.dart';

class AppBlocDelegate extends BlocDelegate {

  @override
  void onEvent(Bloc bloc, Object event) {
    //print("onEvent: " + event.toString());
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    //print("onTransition: " + transition.toString());
    super.onTransition(bloc, transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    print('$error, $stackTrace');
  }

}