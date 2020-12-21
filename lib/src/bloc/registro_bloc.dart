
import 'package:asistencia/src/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';

class RegistroBloc with Validators{

  final _nombreController    = BehaviorSubject<String>();
  final _apellidoPController = BehaviorSubject<String>();
  final _apellidoMController = BehaviorSubject<String>();
  final _email1Controller     = BehaviorSubject<String>();
  final _email2Controller     = BehaviorSubject<String>();
  final _rutController       = BehaviorSubject<String>();
  final _passwordController  = BehaviorSubject<String>();
  final _fonoController  = BehaviorSubject<String>();




    Stream<String> get nombreStream    => _nombreController.stream.transform(validarNombre);
    Stream<String> get apellidopStream => _apellidoPController.stream.transform(validarApellidop);
    Stream<String> get apellidomStream => _apellidoMController.stream.transform(validarApellidom);
    Stream<String> get email1Stream    => _email1Controller.stream.transform(validarEmail1);
    Stream<String> get email2Stream    => _email2Controller.stream.transform(validarEmail2);
    Stream<String> get rutStream       => _rutController.stream.transform(validarRut);
    Stream<String> get passwordStream  => _passwordController.stream.transform(validarPassword);
    Stream<String> get fonoStream      => _fonoController.stream.transform(validarFono);

    Stream<bool> get formValidStram =>
      Observable.combineLatest8(nombreStream, apellidopStream, apellidomStream, email1Stream,email2Stream, rutStream, passwordStream, fonoStream, (a,b,c,d,e,f,g,h) => true);

    Function (String) get changedNombre    => _nombreController.sink.add;
    Function (String) get changedApellidop => _apellidoPController.sink.add;
    Function (String) get changedApellidom => _apellidoMController.sink.add;
    Function (String) get changedEmail1    => _email1Controller.sink.add;
    Function (String) get changedEmail2    => _email2Controller.sink.add;
    Function (String) get changedRut       => _rutController.sink.add;
    Function (String) get changedPassword  => _passwordController.sink.add;
    Function (String) get changedFono      => _fonoController.sink.add;

      //obtener ultimo valor ingresado en los stream 

    String get nombre      => _nombreController.value;
    String get apellidoP   => _apellidoPController.value;
    String get aprellidoM  => _apellidoMController.value;
    String get email1      => _email1Controller.value;
    String get email2      => _email2Controller.value;
    String get rut         => _rutController.value;
    String get password    => _passwordController.value;
    String get fono        => _fonoController.value;


    dispose(){
    _nombreController?.close();
    _apellidoPController?.close();
    _apellidoMController?.close();
    _rutController?.close();
    _email1Controller?.close();
    _email2Controller?.close();
    _passwordController?.close();
    _fonoController?.close();
  }
  

}