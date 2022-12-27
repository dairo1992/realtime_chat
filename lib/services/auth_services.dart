import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:realtime_chat/models/login_response.dart';
import 'package:realtime_chat/models/usuario.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

String _apiUrl = "192.168.58.19:3000";

class AuthServices with ChangeNotifier {
  late Usuario DataUsuario;
  bool _autenticando = false;
  final _storage = FlutterSecureStorage();

  bool get autenticando => _autenticando;

  set autenticando(bool value) {
    _autenticando = value;
    notifyListeners();
  }

  // Getters del token de forma statica
  static Future<String> getToken() async {
    const _storage = FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token!;
  }

  static Future<void> deleteToken() async {
    final _storage = FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

  Future<bool> login(String usuario, String password) async {
    autenticando = true;
    final data = {'usuario': usuario, 'password': password};
    final url = Uri.http(_apiUrl, "/api/login");

    final resp = await http.post(url,
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});
    autenticando = false;

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      DataUsuario = loginResponse.usuario;
      await _guardarToken(loginResponse.token);
      return true;
    } else {
      return false;
    }
  }

  Future registro(String nombre, String usuario, String password) async {
    autenticando = true;
    final data = {'nombre': nombre, 'usuario': usuario, 'password': password};
    final url = Uri.http(_apiUrl, "/api/login/new");
    final resp = await http.post(url,
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    autenticando = false;
    if (resp.statusCode == 200) {
      final registroResponse = loginResponseFromJson(resp.body);
      DataUsuario = registroResponse.usuario;
      await _guardarToken(registroResponse.token);
      return true;
    } else {
      final response = jsonDecode(resp.body);
      return response['msg'];
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: 'token');
    final url = Uri.http(_apiUrl, "/api/login/renew");

    final resp = await http.get(url,
        headers: {'Content-Type': 'application/json', 'x-token': token ?? ''});

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);

      DataUsuario = loginResponse.usuario;
      await _guardarToken(loginResponse.token);
      return true;
    } else {
      logout();
      return false;
    }
  }

  Future _guardarToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future logout() async {
    await _storage.delete(key: 'token');
  }
}
