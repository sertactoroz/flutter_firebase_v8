import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';
import 'package:local_v8/models/user_model.dart';
import 'package:local_v8/view/update_user.dart';
import 'package:local_v8/widgets/are_you_sure.dart';
import 'package:provider/provider.dart';

import 'login.dart';
import '../providers/user_provider.dart';
import 'package:flutter/material.dart';

import 'new_user_page.dart';

class HomePage extends StatelessWidget {
  final FirebaseAuth auth;
  const HomePage({super.key, required this.auth});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'App Users',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const NewUserPage()));
            },
            icon: const Icon(Icons.add),
            color: Colors.black,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            iconSize: 30,
          ),
          IconButton(
            onPressed: () {
              auth.signOut();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const LoginPage()));
            },
            icon: const Icon(Icons.exit_to_app),
            color: Colors.black,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: userProvider.getUsersList.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final user = userProvider.getUsersList[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 3),

                        // ROW içerisinde CARD kullanılabilir
                        child: GestureDetector(
                          child: ListTile(
                            dense: true,
                            visualDensity:
                                VisualDensity(vertical: 4), // to compact

                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                user.image,
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),

                              // Text(user.name.substring(0, 1).toUpperCase()),
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user.name.toUpperCase(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Pacifico-Regular',
                                    fontSize: 18,
                                  ),
                                ),
                                Text(user.email),
                                Text(user.age.toString() + ' yaşında'),
                              ],
                            ),
                            trailing: Container(
                              height: 80,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InkWell(
                                    splashColor: Colors.amber,
                                    borderRadius: BorderRadius.circular(50),
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.delete,
                                          size: 25,
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return BackdropFilter(
                                            filter: ImageFilter.blur(
                                                sigmaX: 5, sigmaY: 5),
                                            child: AlertDialog(
                                              title: Text("Confirmation"),
                                              content: Text("Are you sure?"),
                                              actions: [
                                                TextButton(
                                                  child: Text("Yes"),
                                                  onPressed: () {
                                                    userProvider.deleteUserbyId(
                                                        user.id.toString());
                                                    // Handle yes button action
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                                TextButton(
                                                  child: Text("No"),
                                                  onPressed: () {
                                                    // Handle no button action
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                  InkWell(
                                    splashColor: Colors.amber,
                                    borderRadius: BorderRadius.circular(50),
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Icon(
                                        Icons.edit,
                                        size: 28,
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                UpdateUser(user: user)),
                                      );
                                      // userProvider.setSingleUser(int index)
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
