import 'dart:io';

class Environment {
  static String apiUrl = Platform.isAndroid ? '192.168.58.19' : 'localhost';
  static String socketUrl = Platform.isAndroid ? '192.168.58.19' : 'localhost';
}
