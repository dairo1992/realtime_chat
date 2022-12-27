import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtime_chat/pages/login_page.dart';
import 'package:realtime_chat/pages/usuarios_page.dart';
import 'package:realtime_chat/services/auth_services.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return Center(
            child: Text('Espere.....'),
          );
        },
      ),
    );
  }

  Future checkLoginState(BuildContext context) async {
    final authService = Provider.of<AuthServices>(context, listen: false);
    final autenticado = await authService.isLoggedIn();
    print(autenticado);
    if (autenticado) {
      // conectar socket server
      // Navigator.pushReplacementNamed(context, 'usuarios');
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 0),
              pageBuilder: (_, __, ___) => UsuariosPage()));
    } else {
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 0),
              pageBuilder: (_, __, ___) => LoginPage()));
    }
  }
}
