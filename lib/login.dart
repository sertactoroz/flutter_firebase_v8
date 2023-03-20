import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController(text: "msertactoroz@gmail.com");
    passwordController = TextEditingController(text: "12345678");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(22.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22.0),
            child: _textfield(usernameController, "Username"),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22.0),
            child: _textfield(passwordController, "Password"),
          ),
          Padding(
            padding: const EdgeInsets.all(22.0),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: _button(() async {
                    FirebaseAuth auth = FirebaseAuth.instance;
                    try {
                      UserCredential credential =
                          await auth.signInWithEmailAndPassword(
                              email: usernameController.text,
                              password: passwordController.text);
                      print(credential);
                    } catch (e) {
                      print(e.toString());
                    }
                  }, "Login"),
                ),
                SizedBox(width: 3),
                Expanded(
                  flex: 1,
                  child: _button(() {
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  const RegisterPage(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            const begin = Offset(0.0, 1.0);
                            const end = Offset.zero;
                            final tween = Tween(begin: begin, end: end);
                            final offsetAnimation = animation.drive(tween);

                            return SlideTransition(
                              position: offsetAnimation,
                              child: child,
                            );
                          },
                        ));
                  }, "Register"),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  Widget _textfield(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
    );
  }

  Widget _button(Function() onPressed, String text) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
      style: ElevatedButton.styleFrom(
          minimumSize: Size(50, 75) // put the width and height you want
          ),
    );
  }
}
