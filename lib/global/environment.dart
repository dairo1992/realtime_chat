import 'dart:io';

class Environment {
  static String apiUrl = Platform.isAndroid ? '192.168.58.19' : 'localhost';

  // LocalHost
  // static String socketUrl =
  // Platform.isAndroid ? '192.168.52.14:3000' : 'localhost';

  //Raywall
  static String socketUrl = 'chatserver-production-b1fb.up.railway.app';

  //Heroku
  // static String socketUrl = 'chatserver-flutter.herokuapp.com';
}
