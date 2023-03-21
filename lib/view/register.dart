import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
        appBar: AppBar(),
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
                padding: EdgeInsets.all(22),
                child: Row(children: [
                  Expanded(
                    flex: 1,
                    child: _button(() async {
                      FirebaseAuth auth = FirebaseAuth.instance;
                      try {
                        UserCredential credential =
                            await auth.createUserWithEmailAndPassword(
                                email: usernameController.text,
                                password: passwordController.text);
                        print(credential);
                      } catch (e) {
                        print(e.toString());
                      }
                    }, "Register"),
                  ),
                ]),
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
          minimumSize: Size(100, 75) // put the width and height you want
          ),
    );
  }
}
