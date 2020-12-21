
import 'package:asistencia/src/bloc/login_bloc.dart';
import 'package:asistencia/src/bloc/provider.dart';
import 'package:asistencia/src/bloc/registro_bloc.dart';
import 'package:asistencia/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:asistencia/src/providers/usuario_provider.dart';
import 'package:asistencia/src/utils/const.dart';
import 'package:asistencia/src/utils/utils.dart';
import 'package:flutter/material.dart';

class RegistroPage extends StatelessWidget {
  
static  String routeName = 'registro';


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
  final blocReg = Provider.ofreg(context);
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
              Text("Registro", style: TextStyle(fontSize: 20.0),),
              _crearInputRut(blocReg),
              SizedBox(height: 10.0 ,),
              _crearInputNombre(blocReg,'Nombre'),
              SizedBox(height: 10.0,),
              _crearInputApellidoP(blocReg,'Apellido Paterno'),
              SizedBox(height: 10.0,),
              _crearInputApellidoM(blocReg,'Apellido Materno'),
              SizedBox(height: 10.0,),
              _crearInputEmail1(blocReg),
              SizedBox(height: 10.0,),
               _crearInputEmail2(blocReg),
               SizedBox(height: 10.0,),
               _crearInputFono(blocReg),
              SizedBox(height: 10.0,),
              _crearInputPassword(blocReg),
              SizedBox(height: 30.0,),
              _crearBoton(blocReg),
              FlatButton(
               child: Text('Ya tienes una cuenta? Login', style: TextStyle(color:Colors.purple),),
               onPressed: ()=> Navigator.pushReplacementNamed(context, 'login'),
              ),
            ],
          ),
        )

      ],
    ),

  );

}

Widget _crearInputRut(RegistroBloc bloc){

  return StreamBuilder(
    stream: bloc.rutStream,
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
           // icon: Icon(Icons.supervised_user_circle,color: Colors.deepPurple,),
            hintText: '123456789-0',
            labelText: 'Rut',
           // counterText: snapshot.data,
            errorText: snapshot.error
          ),
          onChanged: bloc.changedRut,
        ),
      );
    }
  );
  
}

Widget _crearInputPassword(RegistroBloc bloc){

  return StreamBuilder(
    stream: bloc.passwordStream,
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          obscureText: true,
          decoration: InputDecoration(
            //icon: Icon(Icons.supervised_user_circle, color: Colors.deepPurple,),
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

Widget _crearInputNombre(RegistroBloc bloc, String labelText){

  return StreamBuilder(
    stream: bloc.nombreStream,
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            //icon: Icon(Icons.supervised_user_circle, color: Colors.deepPurple,),
            labelText: labelText,
            //counterText: snapshot.data,
            errorText: snapshot.error
          ),
          onChanged: bloc.changedNombre,
        ),
      );
    }
  );
}
Widget _crearInputApellidoP(RegistroBloc bloc, String labelText){

  return StreamBuilder(
    stream: bloc.apellidopStream,
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            //icon: Icon(Icons.supervised_user_circle, color: Colors.deepPurple,),
            labelText: labelText,
            //counterText: snapshot.data,
            errorText: snapshot.error
          ),
          onChanged: bloc.changedApellidop,
        ),
      );
    }
  );
}

Widget _crearInputApellidoM(RegistroBloc bloc, String labelText){

  return StreamBuilder(
    stream: bloc.apellidomStream,
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            //icon: Icon(Icons.supervised_user_circle, color: Colors.deepPurple,),
            labelText: labelText,
            //counterText: snapshot.data,
            errorText: snapshot.error
          ),
          onChanged: bloc.changedApellidom,
        ),
      );
    }
  );
}

Widget _crearInputEmail1(RegistroBloc bloc){

  return StreamBuilder(
    stream: bloc.email1Stream,
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            //icon: Icon(Icons.supervised_user_circle, color: Colors.deepPurple,),
            labelText: 'Correo Institucional',
            //counterText: snapshot.data,
            errorText: snapshot.error
          ),
          onChanged: bloc.changedEmail1,
        ),
      );
    }
  );
}

Widget _crearInputEmail2(RegistroBloc bloc){

  return StreamBuilder(
    stream: bloc.email2Stream,
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            //icon: Icon(Icons.supervised_user_circle, color: Colors.deepPurple,),
            labelText: 'Correo Personal',
            //counterText: snapshot.data,
            errorText: snapshot.error
          ),
          onChanged: bloc.changedEmail2,
        ),
      );
    }
  );
}

Widget _crearInputFono(RegistroBloc bloc){

  return StreamBuilder(
    stream: bloc.fonoStream,
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            //icon: Icon(Icons.supervised_user_circle, color: Colors.deepPurple,),
            labelText: 'Fono Contacto',
            hintText: '912131415',
            //counterText: snapshot.data,
            errorText: snapshot.error
          ),
          onChanged: bloc.changedFono,
        ),
      );
    }
  );
}

Widget _crearBoton(RegistroBloc bloc){

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
        onPressed:snapshot.hasData ? ()=> _registro(bloc,context): null
      );
    }
  );
 }

 _registro(RegistroBloc bloc , BuildContext context) async{

       progressIndicator(context, 'Registrando usuario....').show();

      Map info = await usuarioProvider.registro(bloc.rut,bloc.nombre,bloc.apellidoP, bloc.aprellidoM,bloc.email1,bloc.email2, bloc.password, bloc.fono);

        if(info['error']){
          progressIndicator(context, '').hide();
          mostrarAlerta(context, info['mensaje'],'Informacion Incorrecta',Consts.incorrecto);
      
        }else{
            //mostrarAlerta(context, info['message'],'Registro',Consts.correcto);

            Map info2 = await usuarioProvider.login(bloc.rut, bloc.password);

            if(info2['error']){
              
              progressIndicator(context, '').hide();
              mostrarAlerta(context, info2['mensaje'],'Informacion Incorrecta',Consts.incorrecto);
          
            }else{
              progressIndicator(context, '').hide();
              prefs.token = info2['token'].toString();
              prefs.usuRut = info2['usuRut'].toString();
              Navigator.pushReplacementNamed(context, 'home');
            }

          
        }
   }

}

  
 
