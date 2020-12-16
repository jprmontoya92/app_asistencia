
import 'dart:async';

import 'package:asistencia/src/location/location_service.dart';
import 'package:asistencia/src/model/evento_model.dart';
import 'package:asistencia/src/model/userlocation_model.dart';
import 'package:asistencia/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:asistencia/src/providers/marcaje_provider.dart';
import 'package:asistencia/src/utils/const.dart';
import 'package:asistencia/src/utils/utils.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class HomePage extends StatefulWidget {
  
static  String routeName = 'home';
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


String _valorScann, _value='';
String _mesAppBar = 'NULL';
final eventoProvider = new MarcajeProvider();
final prefs          = new  PreferenciasUsuario();
final scaffoldKey = new GlobalKey<ScaffoldState>();


final String _tipoEntrada = 'Entrada';
final String _tipoSalida  = 'Salida';
bool _guardando = false;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
     
      body: _crearListado(),
      floatingActionButton:_crearBotones()      
    );
}
Widget _crearAppbar(String mes){

  return SliverAppBar(
    elevation: 2.0,
    backgroundColor: Colors.indigoAccent,
    expandedHeight: 200.0,
    floating: false,
    pinned: true,
    flexibleSpace: FlexibleSpaceBar(
      title: Text(
        mes, style: TextStyle(color: Colors.white, fontSize: 16.0),
      ),
      background: FadeInImage(
        image: NetworkImage('https://www.araucaniasur.cl/wp-content/uploads/2019/07/banner-principal-OK.jpg'),
        placeholder: AssetImage('assets/loading.gif'),
        fadeInDuration: Duration(microseconds: 5000),
        fit: BoxFit.cover,
      )
    ),
  );

  
}
  _crearBotones(){
  
            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FloatingActionButton(
                  heroTag: "btn1",
                    child: Icon(Icons.input),
                    backgroundColor: Colors.indigo,
                   onPressed: ()=> _scann(_tipoEntrada),
                ),
                SizedBox(height: 5.0,),
                Text('Entrada'),
                SizedBox(height: 10.0,),
                FloatingActionButton(
                  heroTag: "btn2",
                    child: Icon(Icons.directions_walk),
                    backgroundColor: Colors.green,
                   onPressed: () => _scann(_tipoSalida),
                ),
                SizedBox(height: 5.0,),
                Text('Salida'),
              ],
            );

  }

   _crearListado(){

    return  RefreshIndicator(
      onRefresh: refrescarLista,
          child: FutureBuilder(
        future: eventoProvider.cargarEventos(),
        builder: (BuildContext context, AsyncSnapshot<List<EventoModel>> snapshot){
          if (snapshot.hasData) {
           int index = 0;
           final eventos = snapshot.data;
            _mesAppBar = eventos[index].mes.toString();
            return CustomScrollView(
             slivers: <Widget>[
            _crearAppbar(_mesAppBar),
            SliverList(
              delegate: SliverChildBuilderDelegate((BuildContext context, int i ) => _crearItem(context, eventos[i]),
              childCount: eventos.length
              ),
              
            )
                       ],
            );

          } else {
            
          return CustomScrollView(
             slivers: <Widget>[
            _crearAppbar(_mesAppBar),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  SizedBox(height: 20.0,),
                  Center(child: CircularProgressIndicator(),),
                ]
              )
              
            )
                       ],
            );
             
          }
        }
  
      ),
    );
  }
  

  Widget _crearItem(BuildContext context, EventoModel eventos){
  
  
  return Column(
    children: <Widget>[
      Card(
        child: ListTile(
          leading: _iconMarca(eventos.tipoMarcaje),
          title:Text('${eventos.establecimiento} ${eventos.ubicacion} '),
          subtitle: Text('${eventos.fecha}'),
        ),
      )
    ]
  );
     
  }

  Widget _iconMarca(String marca){
      
      if(marca == 'Entrada'){
        return Icon(Icons.arrow_upward,color: Colors.green);
      }else{
        return Icon(Icons.arrow_downward,color: Colors.red);
      }
  }


  Future<Null> refrescarLista(){

    final duration = new Duration(seconds: 2);
    new Timer(duration, (){
      setState(() {
        _crearListado();
         _crearAppbar(_mesAppBar);
      });
    });
  
  return Future.delayed(duration);
  }

Future<void> _scann(String tipoMarca) async{

  try{
    String scan_cod = await BarcodeScanner.scan();
    _submit(tipoMarca, scan_cod);
  } on PlatformException catch (e){

    if(e.code == BarcodeScanner.CameraAccessDenied){
      mostrarAlerta(context, "Favor, verificar permisos de Camara!", 'Atención!', Consts.incorrecto);
    }else{
      mostrarAlerta(context, "Unknown error: $e", "Atención!", Consts.incorrecto);
    }
  }on FormatException{
    // presiona boton volver
  }catch(e){
    mostrarAlerta(context, "Unknown error: $e", "Atención!", Consts.incorrecto);
  }

}

_submit(String tipoMarca, String identificador) async {

  UserLocation coord;
  
  final locationService = new LocationService();
    _guardando = true;
    mostrarSnackBar("Guardando registro..",_guardando);


    coord = await locationService.getLocation();

    Map info = await eventoProvider.crearEvento(tipoMarca,identificador);

    if(info['error']){
      mostrarAlerta(context, info['mensaje'], 'Marcaje Guardado',Consts.incorrecto);
      mostrarSnackBar("", _guardando = false);
    }else{
      mostrarAlerta(context, info['mensaje'], 'Ups, hubo un inconveniente. Intentalo nuevamente',Consts.correcto);
      mostrarSnackBar("", _guardando = false);
    }
 

  setState(() {
    _crearListado();

  });

}


  void mostrarSnackBar(String mensaje, bool guardando){
    final snackbar = SnackBar(
      content: Text(mensaje),
    );
    if(guardando){   
    scaffoldKey.currentState.showSnackBar(snackbar);
  }else{
    scaffoldKey.currentState.hideCurrentSnackBar();
  }
    }
    
}