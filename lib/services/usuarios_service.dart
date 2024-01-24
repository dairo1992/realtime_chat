import 'package:realtime_chat/global/environment.dart';
import 'package:realtime_chat/models/usuario.dart';
import 'package:http/http.dart' as http;
import 'package:realtime_chat/models/usuarios_response.dart';
import 'package:realtime_chat/services/auth_services.dart';

class UsuariosService {
  Future<List<Usuario>> getusuarios() async {
    try {
      final url = Uri.https(Environment.socketUrl, "/api/usuarios/");
      final resp = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'x-token': await AuthServices.getToken()
      });

      final usuariosResponse = usuariosResponseFromJson(resp.body);
      return usuariosResponse.usuarios;
    } catch (e) {
      return [];
    }
  }
}
