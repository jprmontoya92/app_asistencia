
import 'package:asistencia/src/bloc/login_bloc.dart';
import 'package:asistencia/src/bloc/provider.dart';
import 'package:asistencia/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:asistencia/src/providers/usuario_provider.dart';
import 'package:asistencia/src/utils/const.dart';
import 'package:asistencia/src/utils/utils.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  
static  String routeName = 'login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final usuarioProvider =  new UsuarioProvider();

  final prefs           =  new PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          crearFondo(context),
          _loginForm(context),// cuando se trabja con cajas de texto, es recomendable ponerlos dentro de un scroll para que no se opaquen o oculten con el teclado 
        ],
      ),
    );
  }

  Widget crearFondo(BuildContext context) {

    //para obtener el 40% de la pantalla 
    final size = MediaQuery.of(context).size;

    final fondoMorado = Container(
      height: size.height * 0.4,
      width: double.infinity, // todo el ancho
      decoration: BoxDecoration( // para decorar el espacio
        gradient: LinearGradient(
          colors: <Color>[
            Color.fromRGBO(63, 63, 156, 1.0),
            Color.fromRGBO(90, 70, 178, 1.0)
          ]
        )

      ),
    );
    
    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
         borderRadius: BorderRadius.circular(100.0),
         color: Color.fromRGBO(255, 255, 255, 0.05)
      ),
    );

    return Stack(
      children: <Widget>[
        fondoMorado,
        Positioned(top:  90.0, left:  30.0, child:circulo),
        Positioned(top: -40.0, right: -30.0, child:circulo),
        Positioned(top:  50.0, right: -10.0, child:circulo),
        Positioned(top: 120.0, right:  20.0, child:circulo),
        Positioned(top: -50.0, left: -20.0, child:circulo),
        Container(
          padding: EdgeInsets.only(top: 80.0),
          child: Column(
            children: <Widget>[
              Icon(Icons.person_pin_circle, color: Colors.white, size: 100.0,),
              //el double infinity me ocpara todo el ancho y por defecto lo centrara
              SizedBox(height: 10.0, width: double.infinity),
              Text("Servicio de Salud Araucania Sur", style: TextStyle(color: Colors.white, fontSize:25.0 ),)
            ],
          ),
        )
      ],
    );
  }

Widget _loginForm(BuildContext context){
  final bloc = Provider.of(context);
  final size = MediaQuery.of(context).size;

// va a permitir hacer scroll dependiendo el largo del hijo (child)
  return SingleChildScrollView(
    child: Column(
      children: <Widget>[
        SafeArea(
          child: Container(
            height: 180.0,
          ),
        ),

        Container(
          width: size.width * 0.85,
          // cpn respecto al ancho, este va a ser dinamico ya que va a depender de los alementos internos 
          //separacion de la caja con el texto de arriba (Usuario)
          margin: EdgeInsets.symmetric(vertical: 30.0),
          padding: EdgeInsets.symmetric(vertical: 50.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0),
            boxShadow: <BoxShadow>[ // para dar sombreado 
              BoxShadow(
                color: Colors.black26,
                blurRadius: 3.0,
                //mas notorio el sombreado
                offset: Offset(0.0, 5.0),
                //con mas blur la sombra
                spreadRadius: 3.0
              )
            ]
          ),
          child: Column(
            children: <Widget>[
              Text("Ingreso", style: TextStyle(fontSize: 20.0),),
              SizedBox(height: 60.0,),
              _crearEmail(bloc),
              SizedBox(height: 30.0 ,),
              _crearPassword(bloc),
              SizedBox(height: 30.0,),
              _crearBoton(bloc)
            ],
          ),
        )

      ],
    ),

  );

}

Widget _crearEmail(LoginBloc bloc){

  return StreamBuilder(
    stream: bloc.rutStream,
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            icon: Icon(Icons.supervised_user_circle,color: Colors.deepPurple,),
            hintText: '1234567890',
            labelText: 'Rut',
            counterText: snapshot.data,
            errorText: snapshot.error
          ),
          onChanged: bloc.changedRut,
        ),
      );
    }
  );
  
}

Widget _crearPassword(LoginBloc bloc){

  return StreamBuilder(
    stream: bloc.passwordStream,
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          obscureText: true,
          decoration: InputDecoration(
            icon: Icon(Icons.supervised_user_circle, color: Colors.deepPurple,),
            labelText: 'Contraseña',
            counterText: snapshot.data,
            errorText: snapshot.error
          ),
          onChanged: bloc.changedPassword,
        ),
      );
    }
  );
}


Widget _crearBoton(LoginBloc bloc){

  return StreamBuilder(
    stream: bloc.formValidStram,
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      return RaisedButton(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
          child: Text("Ingesar"),
        ),
        //para el efecto del redondeado
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0)
        ),
        //para quitarle el efcto de la sombra
        elevation: 0.0,
        color: Colors.deepPurple,
        textColor: Colors.white,
        onPressed:snapshot.hasData ? ()=> _login(bloc,context): null
      );
    }
  );
 }

 _login(LoginBloc bloc , BuildContext context) async{

   
      Map info = await usuarioProvider.login(bloc.rut, bloc.password);

        if(info['error']){
          
          mostrarAlerta(context, info['message'],'Informacion Incorrecta',Consts.incorrecto);
      
        }else{
          prefs.token = info['token'].toString();
          prefs.usuRut = info['usuRut'].toString();
          Navigator.pushReplacementNamed(context, 'home');
          
        }
   }

  
 
}