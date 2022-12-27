import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtime_chat/routes/routes.dart';
import 'package:realtime_chat/services/auth_services.dart';
import 'package:wakelock/wakelock.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Wakelock.enable();
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthServices())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'RealTime Chat',
        initialRoute: 'loading',
        routes: appRoutes,
      ),
    );
  }
}
