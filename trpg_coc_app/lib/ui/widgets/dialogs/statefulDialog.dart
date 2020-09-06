import 'package:flutter/material.dart';
void showStatefulDialog(BuildContext context,Widget childBuildCallback(BuildContext context,StateSetter setState)){
  showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return Dialog(
            child: childBuildCallback(context, setState),
            backgroundColor: Colors.transparent,
          );
        });
      });
}