import 'package:flutter/material.dart';
import 'package:realtime_chat/global/environment.dart';
import 'package:realtime_chat/services/auth_services.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { Online, Offline, Connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  late IO.Socket _socket;

  ServerStatus get serverStatus => _serverStatus;

  IO.Socket get socket => _socket;
  Function get emit => _socket.emit;

  void enviarMensaje() {
    // _socket.emit('mensaje-personal', mensaje);
    _socket.emit('mensaje-personal', {'msg': 'Hola mensaje de dairo'});
  }

  // void connect() async {
  //   final token = await AuthServices.getToken();

  //   IO.Socket socket = IO.io(
  //       Environment.socketUrl,
  //       IO.OptionBuilder()
  //           .setTransports(['websocket'])
  //           .disableAutoConnect()
  //           .setExtraHeaders({'x-token': token})
  //           .build());

  //   // socket.connect();
  //   _socket = socket;
  //   enviarMensaje();
  //   // _serverStatus = ServerStatus.Online;
  //   socket.on('connect', (data) async {
  //     print(data);
  //     print('Connected');
  //     _serverStatus = ServerStatus.Online;
  //     notifyListeners();
  //   });

  //   _socket.on('disconnect', (_) {
  //     _serverStatus = ServerStatus.Offline;
  //     notifyListeners();
  //   });
  // }

  void connect() async {
    final token = await AuthServices.getToken();

    // Dart client
    _socket = IO.io(Environment.socketUrl, {
      'transports': ['websocket'],
      'autoConnect': true,
      'forceNew': true,
      'extraHeaders': {'x-token': token}
    });

    _socket.on('connect', (_) {
      print('conectado');
      _serverStatus = ServerStatus.Online;
      notifyListeners();
    });

    _socket.on('disconnect', (_) {
      _serverStatus = ServerStatus.Offline;
      notifyListeners();
    });
  }

  void disconnect() {
    _socket.disconnect();
  }
}
