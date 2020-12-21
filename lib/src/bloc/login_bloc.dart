// hago un mixin de validators
import 'package:asistencia/src/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators{
  
  // los streamcontrller no son conocidos en rxdart, por ende se cambian 

  final _rutController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();



  // recuperar los datos del Stream

  Stream<String> get rutStream => _rutController.stream.transform(validarRut);
  Stream<String> get passwordStream => _passwordController.stream.transform(validarPassword);

  //necesito combinar los stream 

  Stream<bool> get formValidStram =>
  Observable.combineLatest2(rutStream, passwordStream, (e,p) => true); // paso los dos stream ya pasados por el tranform y luego pregunto por la funcion si vienen con data

  //insertar valores al stream 

  Function (String) get changedRut => _rutController.sink.add;
  Function (String) get changedPassword => _passwordController.sink.add;

  //obtener ultimo valor ingresado en los stream 

  String get rut => _rutController.value;
  String get password =>_passwordController.value;


  // obligadamente necesito crear el metodo para cerra los StremaContrller cunado ya no los necesite

  dispose(){
    _rutController?.close();
    _passwordController?.close();
  }
}