import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:realtime_chat/widgets/widgets.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
                    label: 'Messenger',
                    primaryColor: Colors.blue,
                  ),
                  _FormState(),
                  const Labels(
                    label1: '¿No tienes Cuenta?',
                    label2: 'Crear Cuenta',
                    colorLabel1: Colors.black54,
                    colorLabel2: Colors.blue,
                    ruta: 'register',
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
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
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
            label: 'Ingresar',
            color: Colors.blue,
            onPressed: (() {
              print(passCtrl.text);
            }),
          )
          // MaterialButton(
          //   elevation: 2,
          //   highlightElevation: 5,
          //   onPressed: () {
          //     print('Correo: ${emailCtrl.text} y Contraseña: ${passCtrl.text}');
          //   },
          //   color: Colors.blue,
          //   shape: const StadiumBorder(),
          //   child: Container(
          //     width: double.infinity,
          //     height: 50,
          //     child: Center(
          //       child: Text(
          //         'Ingresar',
          //         style: TextStyle(color: Colors.white, fontSize: 20),
          //       ),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}

// class _Labels extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         children: [
//           const Text("",
//               style: TextStyle(
//                   color: ,
//                   fontSize: 15,
//                   fontWeight: FontWeight.w300)),
//           const SizedBox(
//             height: 10,
//           ),
//           Text(,
//               style: TextStyle(
//                   color: ,
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold))
//         ],
//       ),
//     );
//   }
// }
