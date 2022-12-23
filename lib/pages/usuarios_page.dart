import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:realtime_chat/models/usuario.dart';

class UsuariosPage extends StatefulWidget {
  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  final List<Usuario> usuarios = [
    Usuario(uid: '1', email: 'test1@test.com', nombre: 'Dairo', online: true),
    Usuario(uid: '2', email: 'test2@test.com', nombre: 'Wen', online: true),
    Usuario(uid: '3', email: 'test3@test.com', nombre: 'Dayana', online: false),
    Usuario(uid: '4', email: 'test4@test.com', nombre: 'Taty', online: false),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'nombre usuario',
            style: TextStyle(color: Colors.black54),
          ),
          elevation: 1,
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: (() {}),
              color: Colors.black54,
              icon: Icon(FontAwesomeIcons.arrowRightToBracket)),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 10),
              child: Icon(FontAwesomeIcons.circleCheck, color: Colors.green),
            )
          ],
        ),
        body: SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          onRefresh: _cargarUsuarios,
          header: WaterDropHeader(
            complete: Icon(Icons.check, color: Colors.green),
            waterDropColor: Colors.green,
          ),
          child: _listViewUsuarios(),
        ));
  }

  ListView _listViewUsuarios() {
    return ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int i) =>
            _usuarioListTile(usuarios[i]),
        itemCount: usuarios.length,
        separatorBuilder: (BuildContext context, int i) => Divider());
  }

  ListTile _usuarioListTile(Usuario usuario) {
    return ListTile(
      title: Text(usuario.nombre),
      subtitle: Text(usuario.email),
      leading: CircleAvatar(
          backgroundColor: Colors.blue[400],
          child: Text(
            usuario.nombre.substring(0, 2),
            style: TextStyle(color: Colors.white),
          )),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: usuario.online ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }

  _cargarUsuarios() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}
