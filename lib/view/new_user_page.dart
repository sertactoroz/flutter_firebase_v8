import 'package:faker/faker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:local_v8/models/user_model.dart';
import 'package:local_v8/view/home.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

class NewUserPage extends StatefulWidget {
  const NewUserPage({super.key});

  @override
  State<NewUserPage> createState() => _NewUserPageState();
}

class _NewUserPageState extends State<NewUserPage> {
  var faker = new Faker();

  late TextEditingController nameController;
  late TextEditingController ageController;
  late TextEditingController emailController;

  @override
  void initState() {
    nameController = TextEditingController();
    ageController = TextEditingController();
    emailController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(22.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: _textfield("Name", nameController),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: _textfield("E-mail", emailController),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: _textfield("Age", ageController),
              ),
              Padding(
                padding: EdgeInsets.all(22),
                child: Row(children: [
                  Expanded(
                    flex: 1,
                    child: _button(() async {
                      UserModel _user = UserModel(
                          name: nameController.text,
                          email: emailController.text,
                          age: int.parse(ageController.text),
                          image: faker.image.image(
                            keywords: [
                              'people',
                            ],
                            random: true,
                          ));
                      userProvider.postUser(_user);
                      Navigator.pop(context);
                    }, "Add User"),
                  ),
                ]),
              ),
            ],
          ),
        ));
  }

  Widget _textfield(String label, TextEditingController controller) {
    return TextField(
      decoration: InputDecoration(labelText: label),
      controller: controller,
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
