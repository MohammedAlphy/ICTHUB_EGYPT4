
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rehtjydtkuyiifykudrthag/ui/screens/Login.dart';

import '../../main.dart';

class LoginScreen extends StatefulWidget {
   LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<LoginScreen> {
  TextEditingController emailC = TextEditingController();

  TextEditingController passwordC = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> login(String email,
      String password,) async {
    if (formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email,
            password: password
        ).then((value) {
          if (value.user != null) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) {
                      return const MyHomePage3();
                    })
            );
          }
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.toString()))
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('email'),
              TextFormField(
                controller: emailC,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'the email must not be empty';
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              const Text('password'),
              TextFormField(
                controller: passwordC,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'the password must not be empty';
                  } else if (value.length < 6) {
                    return 'password must be 6 numbers or more';
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment:MainAxisAlignment.spaceEvenly ,
                children: [
                  ElevatedButton(
                      onPressed: () async{
                        await    login(
                          emailC.text,
                          passwordC.text,
                        );
                      },
                      child: const Text('Login')),
                  ElevatedButton(
                      onPressed: () async{
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) {
                                  return SignUp();
                                })
                        );
                      },
                      child: const Text('Create account')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
