import 'dart:io';

import 'package:data_plugin/utils/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trpgcocapp/bloc/common/timecost_operation_event.dart';
import 'package:trpgcocapp/bloc/common/timecost_operation_state.dart';
import 'package:trpgcocapp/bloc/common/timecost_operator_widget.dart';
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
    return Scaffold(
      appBar: AppBar(title: Text('FileBloc')),
      body: TimecostOpListenerWidget<FileBloc>(child:buildNormalPanel(context))
    );
  }

  Widget buildNormalPanel(BuildContext context ) {
    final FileBloc fileBloc = BlocProvider.of<FileBloc>(context);
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



}
