import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:local_v8/models/user_model.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

class UpdateUser extends StatefulWidget {
  const UpdateUser({super.key, required this.user});
  final UserModel user;

  @override
  State<UpdateUser> createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  late TextEditingController nameController;
  late TextEditingController ageController;
  late TextEditingController emailController;

  @override
  void initState() {
    nameController = TextEditingController(text: widget.user.name);
    ageController = TextEditingController(text: widget.user.age.toString());
    emailController = TextEditingController(text: widget.user.email);
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
                      widget.user.name = nameController.text;
                      widget.user.email = emailController.text;
                      widget.user.age = int.parse(ageController.text);
                      widget.user.image =
                          "https://i.pinimg.com/originals/d0/43/87/d04387bc7b0f772d1f925cebacf21cb5.jpg";
                      userProvider.updateUser(widget.user);
                      Navigator.pop(context);
                    }, "Update User"),
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
