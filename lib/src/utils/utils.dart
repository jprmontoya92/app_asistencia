import 'package:asistencia/src/page/custom_dialog.dart';
import 'package:flutter/material.dart';





void mostrarAlerta(BuildContext context, String mensaje, String titulo, String pathImagen){

  showDialog(

    context: context,
    builder: (BuildContext context)=> CustomDialog(
      titulo: titulo,
      descripcion: mensaje,
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