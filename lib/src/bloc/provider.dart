import 'package:asistencia/src/bloc/login_bloc.dart';
import 'package:asistencia/src/bloc/registro_bloc.dart';
import 'package:flutter/material.dart';

class Provider extends InheritedWidget{
  
  
  final loginBloc    = LoginBloc();
  final registroBloc = RegistroBloc();
  

  //constructor

  Provider({Key key, Widget child})
  :super(key:key, child:child);


// al actualizarse debe notificar a sus hijos
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
    // cuando use el provider, voy a ocupar la instancia de mi loginBloc, es decir que me regrese el estado de ese loginbloc 
    
    // estamos diciendo que este metodo se llame directamente
    static LoginBloc of (BuildContext context){

      // esta funcion va a buscar internamente en el arbol de wifget que viene en el context para que retorne la instancia del loginBloc

      // que vaya a buscar en el context cual es la instacia del Provider que tenemos definido
    return (context.dependOnInheritedWidgetOfExactType<Provider>()).loginBloc;

    //en resumen, el codigo toma el codigo, que es un arbol grande de widget y va a buscar un widget exactamente con el mismo tipo del provider
    }

     // estamos diciendo que este metodo se llame directamente
    static RegistroBloc ofreg (BuildContext context){

      // esta funcion va a buscar internamente en el arbol de wifget que viene en el context para que retorne la instancia del loginBloc

      // que vaya a buscar en el context cual es la instacia del Provider que tenemos definido
    return (context.dependOnInheritedWidgetOfExactType<Provider>()).registroBloc;

    //en resumen, el codigo toma el codigo, que es un arbol grande de widget y va a buscar un widget exactamente con el mismo tipo del provider
    }

  
    
  


}