import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trpgcocapp/bloc/common/timecost_operation_event.dart';
import 'package:trpgcocapp/bloc/common/timecost_operation_state.dart';
import 'package:trpgcocapp/bloc/common/timecost_operation_bloc.dart';

class TimecostOpListenerWidget<T extends TimecostOperationBloc> extends StatefulWidget  {

  Widget _child;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TimecostOpListenerState<T>();
  }

  TimecostOpListenerWidget({Widget child = null}){this._child =child;}
}

class TimecostOpListenerState<T extends TimecostOperationBloc> extends State<TimecostOpListenerWidget<T>>{
  @override
  Widget build(BuildContext context) {
    return BlocListener<T,TimecostOperationState>(
        listener: (context, state) {
          if(state is Operating){
            showOperatingDialog(context);
          }else if(state is OperationSuccess){
            showOpSuccessDialog(context);
          }else if(state is OperationFailure){
            showOpFailDialog(context);
          }

        },
        condition:(prevState, currentState) {
          if ((prevState is Operating)){
            Navigator.of(context).pop();
          }
          return true;
        },
        child: widget._child,
      );
  }

  void showOperatingDialog(BuildContext context) {
    showDialog(context: context,barrierDismissible: false,
        builder: (BuildContext context){
          return new AlertDialog(
              title: new Text("Operating.."),
              content:SizedBox(height: 100,width: 100,child: Center(child:CircularProgressIndicator()),)


          );
        }
    );
  }
  void showOpSuccessDialog(BuildContext context) {
    final T bloc =  BlocProvider.of<T>(context);
    showDialog(context: context,barrierDismissible: false,
        builder: (BuildContext context){
          return new AlertDialog(
            title: new Text("Operation Success"),
            content:
            Icon(Icons.wb_sunny,color: Colors.yellow,size: 100,),
            actions: <Widget>[
              new FlatButton(
                child: new Text('OK'),
                onPressed: () {
                  bloc.add(OperationResultGot());
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }
    );
  }
  void showOpFailDialog(BuildContext context) {
    final T bloc =  BlocProvider.of<T>(context);
    showDialog(context: context,barrierDismissible: false,
        builder: (BuildContext context){
          return new AlertDialog(
            title: new Text("Operation Failure"),
            content:Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(Icons.warning,color: Colors.grey,size: 100,),
                  Text( bloc.operator.lastResult.msg)
                ],
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('OK'),
                onPressed: () {
                  bloc.add(OperationResultGot());
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }
    );

  }


}
