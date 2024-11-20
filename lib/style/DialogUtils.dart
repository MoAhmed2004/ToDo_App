import 'package:flutter/material.dart';

class DialogUtils{
  static void ShowLoading(BuildContext context){
  showDialog(context: context, builder: (context) =>AlertDialog(
  content: SizedBox(
  height: MediaQuery.of(context).size.height*0.1,
  child: Center(
  child: CircularProgressIndicator(),
  ),
  ),
  ) ,);
}

static void ShowMessage(
    BuildContext context,
    {required String message,
      String? OKButton,
      void Function()? onOKPressed,
      String? NoButton,
      void Function()? onNoPressed,
    }){
  showDialog(context: context, builder:(context) => AlertDialog(
    content: Text(message),
    actions: [
      if(OKButton!=null)
      TextButton(
          onPressed:onOKPressed,
          child: Text(OKButton)),
      if(NoButton!=null)
        TextButton(
            onPressed:onNoPressed,
            child: Text(NoButton))
    ],
  ),);
}

}