import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:realtime_chat/helpers/mostrar_alerta.dart';
import 'package:realtime_chat/services/auth_services.dart';
import 'package:realtime_chat/services/socket_services.dart';
import 'package:realtime_chat/widgets/widgets.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF2F2F2),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Logo(
                    faIcon: FontAwesomeIcons.comments,
                    label: 'Registro',
                    primaryColor: Colors.blue,
                  ),
                  _FormState(),
                  const Labels(
                    label1: '¿Ya tienes una cuenta?',
                    label2: 'Iniciar',
                    colorLabel1: Colors.black54,
                    colorLabel2: Colors.blue,
                    ruta: 'login',
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    child: const Text(
                      "Terminos y condiciones de uso",
                      style: TextStyle(fontWeight: FontWeight.w200),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

class _FormState extends StatefulWidget {
  @override
  State<_FormState> createState() => _FormStateState();
}

class _FormStateState extends State<_FormState> {
  final nameCtrl = TextEditingController();
  final dateCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthServices>(context);
    final socketService = Provider.of<SocketService>(context);
    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          CustonInput(
            icon: FontAwesomeIcons.user,
            placeholder: 'Nombre',
            textController: nameCtrl,
            keyboardType: TextInputType.text,
          ),
          CustonInput(
            icon: Icons.mail_outline,
            placeholder: 'Correo',
            textController: emailCtrl,
            keyboardType: TextInputType.emailAddress,
          ),
          CustonInput(
            icon: Icons.key,
            placeholder: 'Contraseña',
            textController: passCtrl,
            isPasswords: true,
            // keyboardType: TextInputType.,
          ),
          CustomBtn(
            label: 'Registrarse',
            color: Colors.blue,
            onPressed: (!authService.autenticando
                ? () async {
                    FocusScope.of(context).unfocus();
                    final registro = await authService.registro(
                        (nameCtrl.text).trim(),
                        (emailCtrl.text).trim(),
                        (passCtrl.text).trim());
                    if (registro == true) {
                      socketService.connect();
                      Navigator.pushReplacementNamed(context, 'usuarios');
                    } else {
                      mostrarAlerta(context, 'Registro Incorrecto', registro);
                    }
                  }
                : null),
          )
        ],
      ),
    );
  }
}
