import 'dart:io';

import 'package:data_plugin/utils/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trpgcocapp/bloc/file/file_bloc_event.dart';
import 'package:trpgcocapp/bloc/file/file_bloc_state.dart';

import 'file_bloc.dart';

class FileBlocDemo extends StatefulWidget  {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FileBlocDemoState();
  }
}

class FileBlocDemoState extends State<FileBlocDemo>{
  @override
  Widget build(BuildContext context) {
    final FileBloc fileBloc = BlocProvider.of<FileBloc>(context);
    return Scaffold(
      appBar: AppBar(title: Text('FileBloc')),
      body: BlocListener<FileBloc, FileBlocState>(
        listener: (BuildContext context, FileBlocState state) {
          if(state is FileOperating){
            showFileOperatingDialog(context);
          }else if(state is FileOperationSuccess){
            showFileOperationSuccessDialog(context);
          }else if(state is FileOperationFailure){
            showFileOperationFailDialog(context);
          }

        },
        condition:(prevState, currentState) {
          if ((prevState is FileOperating)){
            Navigator.pop(context);
          }
          return true;
        },
        child: buildNormalPanel(context, fileBloc),
      ),
    );
  }

  Widget buildNormalPanel(BuildContext context,FileBloc fileBloc ) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            child: Text("Current File: " + fileBloc.repository.localPath),
            padding: EdgeInsets.all(10),
          ),
          Padding(
            child: MaterialButton(
              color: Colors.blue,
              child: Text("Select File"),
              onPressed: () async {
                File f=
                await ImagePicker.pickImage(source: ImageSource.gallery);
                fileBloc.repository.setLocalFile(f.path);
                setState(() {

                });
              },
            ),
            padding: EdgeInsets.all(10),
          ),
          Padding(
            child: MaterialButton(
              color: Colors.blue,
              child: Text("Upload"),
              onPressed: () {
                fileBloc.add(UploadFile());
              },
            ),
            padding: EdgeInsets.all(10),
          ),
          Padding(
            child: MaterialButton(
              color: Colors.blue,
              child: Text("Delete"),
              onPressed: () {
                fileBloc.add(DeleteFile());
              },
            ),
            padding: EdgeInsets.all(10),
          ),
          Padding(
            child: MaterialButton(
              color: Colors.blue,
              child: Text("Download"),
              onPressed: () {
                fileBloc.add(DownloadFile());
              },
            ),

            padding: EdgeInsets.all(10),
          ),
        ],
      ),
    );
  }

  void showFileOperatingDialog(BuildContext context) {
    showDialog(context: context,barrierDismissible: false,
        builder: (context){
          return new AlertDialog(
            title: new Text("Operating.."),
            content:SizedBox(height: 100,width: 100,child: Center(child:CircularProgressIndicator()),)


          );
        }
    );
  }
  void showFileOperationSuccessDialog(BuildContext context) {
    final FileBloc fileBloc = BlocProvider.of<FileBloc>(context);
    showDialog(context: context,barrierDismissible: false,
        builder: (context){
          return new AlertDialog(
            title: new Text("Operation Success"),
            content:
            Icon(Icons.wb_sunny,color: Colors.yellow,size: 100,),
            actions: <Widget>[
              new FlatButton(
                child: new Text('OK'),
                onPressed: () {
                  fileBloc.add(FileOperationResultGot());
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }
    );
  }
  void showFileOperationFailDialog(BuildContext context) {
    final FileBloc fileBloc = BlocProvider.of<FileBloc>(context);
    showDialog(context: context,barrierDismissible: false,
        builder: (context){
          return new AlertDialog(
            title: new Text("Operation Failure"),
            content:Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(Icons.warning,color: fileBloc.repository.hasError?Colors.red:Colors.grey,size: 100,),
                  Text(fileBloc.repository.msg)
                ],
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('OK'),
                onPressed: () {
                  fileBloc.add(FileOperationResultGot());
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }
    );

  }


}
