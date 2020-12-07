
import 'package:asistencia/src/bloc/provider.dart';
import 'package:asistencia/src/page/home_page.dart';
import 'package:asistencia/src/page/login_page.dart';
import 'package:asistencia/src/page/prueba.dart';
import 'package:asistencia/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:flutter/material.dart';

void main() async {
  
WidgetsFlutterBinding.ensureInitialized();

final prefs = new PreferenciasUsuario();

await prefs.initPrefs();

if(prefs.token!=''){
  LoginPage.routeName = 'home';
  print(prefs.token);
  print("======================================");
  print(prefs.usuRut);
}else{
  LoginPage.routeName = 'login';
}
  
runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {      
       
     return Provider(
      child: MaterialApp(
      title: 'Asistencia RRHH',
      debugShowCheckedModeBanner: false,
      initialRoute: LoginPage.routeName,
      routes: {
        LoginPage.routeName   :  (BuildContext context)  => LoginPage(),
        HomePage.routeName    :  (BuildContext context)  => HomePage(),
        PruebaPage.routeName  :  (BuildContext context)  => PruebaPage(),
              },
              theme: ThemeData(
                primaryColor: Colors.purple
              ),
              
            )
            );
              
               
                
          }
        }
        
       