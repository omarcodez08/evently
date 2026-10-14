import 'package:flutter/material.dart';

abstract class DialogUtiles {
  static void showMessageDialog(
  {
    required BuildContext context,
    required String content,
}
      ){
    showDialog(context: context,
      barrierDismissible: false,
      builder: (context) =>
          AlertDialog(
            title:Text(content),
            content:Text("The account already exists for that email."),
            actions: [
              TextButton(onPressed: (){
                Navigator.of(context).pop();
              }, child:Text("Ok"))
            ],
          ),);
}
static void showLoadingDialog(BuildContext context){
showDialog(
     context: context,
     builder:(context) => AlertDialog(
       content: Column(
         mainAxisSize: MainAxisSize.min,
         children: [
           Row(
             children: [
               CircularProgressIndicator(),
               Text("Loading..."),
             ],
           ),
         ],
       ),
     ) ,);
}


}