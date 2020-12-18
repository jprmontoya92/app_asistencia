
import 'package:asistencia/src/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';

class RegistroBloc with Validators{

  final _nombreController    = BehaviorSubject<String>();
  final _apellidoPController = BehaviorSubject<String>();
  final _apellidoMController = BehaviorSubject<String>();
  final _emailController     = BehaviorSubject<String>();
  final _rutController       = BehaviorSubject<String>();
  final _passwordController  = BehaviorSubject<String>();




    Stream<String> get nombreStream    => _nombreController.stream.transform(validarFullName);
    Stream<String> get apellidopStream => _apellidoPController.stream.transform(validarFullName);
    Stream<String> get apellidomStream => _apellidoMController.stream.transform(validarFullName);
    Stream<String> get emailStream     => _emailController.stream.transform(validarEmail);
    Stream<String> get rutStream       => _rutController.stream.transform(validarRut);
    Stream<String> get passwordStream  => _passwordController.stream.transform(validarPassword);

    Stream<bool> get formValidStram =>
      Observable.combineLatest6(nombreStream, apellidopStream, apellidomStream, emailStream, rutStream, passwordStream, (a,b,c,d,e,f) => true);

    Function (String) get changedNombre    => _nombreController.sink.add;
    Function (String) get changedApellidop => _apellidoPController.sink.add;
    Function (String) get changedApellidom => _apellidoMController.sink.add;
    Function (String) get changedEmail     => _emailController.sink.add;
    Function (String) get changedRut       => _rutController.sink.add;
    Function (String) get changedPassword  => _passwordController.add;

      //obtener ultimo valor ingresado en los stream 

    String get nombre      => _nombreController.value;
    String get apellidoP   => _apellidoPController.value;
    String get aprellidoM  => _apellidoMController.value;
    String get email       => _emailController.value;
    String get rut         => _rutController.value;
    String get password    => _passwordController.value;


    dispose(){
    _nombreController?.close();
    _apellidoPController?.close();
    _apellidoMController?.close();
    _rutController?.close();
    _emailController?.close();
    _passwordController?.close();
  }
  

}