import 'package:asistencia/src/page/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';





void mostrarAlerta(BuildContext context, String mensaje, String titulo, String pathImagen){

  showDialog(

    context: context,
    builder: (BuildContext context)=> CustomDialog(
      titulo: titulo,
      descripcion: mensaje == 'null' ? 'null':mensaje,
      buttonText: "OK",
      pathImagen: pathImagen,
    )
  );

}
/* void mostrarAlerta(BuildContext context, String mensaje, String titulo){

  showDialog(

    context: context,
    builder: (context){
      return AlertDialog(
        title: Text(titulo),
        content: Text(mensaje),
        actions: <Widget>[
          FlatButton(
            child: Text('OK'),
            onPressed: ()=>Navigator.of(context).pop(),
          )
        ],
      );
    }
  );

}
 */


 mostrarAlertaCircular(BuildContext context, String mensaje, String titulo){

  showDialog(

    context: context,
    builder: (context){
      return AlertDialog(
        title: Text(titulo),
        content: Text(mensaje),
        actions: <Widget>[
        Center(child: CircularProgressIndicator())
        ],
      );
    }
  );

}

ProgressDialog progressIndicator(BuildContext context, String mensaje){
  
  ProgressDialog pr;

   pr = new ProgressDialog(context);
   //For normal dialog
   pr = new ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);

   pr.style(
        message: mensaje,
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
          color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
          color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600)
      );

      return pr;
}