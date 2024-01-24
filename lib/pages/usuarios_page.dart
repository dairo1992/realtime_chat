import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:realtime_chat/models/usuario.dart';
import 'package:realtime_chat/services/auth_services.dart';
import 'package:realtime_chat/services/chat_service.dart';
import 'package:realtime_chat/services/socket_services.dart';
import 'package:realtime_chat/services/usuarios_service.dart';

class UsuariosPage extends StatefulWidget {
  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final usuarioService = UsuariosService();

  List<Usuario> usuarios = [];

  @override
  void initState() {
    _cargarUsuarios();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthServices>(context);
    final socketService = Provider.of<SocketService>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            authService.dataUsuario.nombre,
            style: TextStyle(color: Colors.black54),
          ),
          elevation: 1,
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: (() {
                socketService.disconnect();
                Navigator.pushReplacementNamed(context, 'login');
                AuthServices.deleteToken();
              }),
              color: Colors.black54,
              icon: const Icon(FontAwesomeIcons.arrowRightToBracket)),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 10),
              // child: Text(
              //   socketService.serverStatus.toString(),
              //   style: TextStyle(color: Colors.black),
              // )
              child: (socketService.serverStatus == ServerStatus.Online ||
                      socketService.serverStatus == ServerStatus.Connecting)
                  ? Icon(FontAwesomeIcons.circleCheck, color: Colors.green)
                  : Icon(Icons.offline_bolt, color: Colors.red),
            )
          ],
        ),
        body: SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          onRefresh: _cargarUsuarios,
          header: const WaterDropHeader(
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
      subtitle: Text(usuario.usuario),
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
      onTap: (() {
        final chatService = Provider.of<ChatService>(context, listen: false);
        chatService.usuarioPara = usuario;
        Navigator.pushNamed(context, 'chat');
      }),
    );
  }

  _cargarUsuarios() async {
    usuarios = await usuarioService.getusuarios();
    setState(() {});
    // await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}
