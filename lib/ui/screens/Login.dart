import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rehtjydtkuyiifykudrthag/ui/screens/RealLogin.dart';

import '../../main.dart';

class SignUp extends StatefulWidget {
  SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailC = TextEditingController();

  TextEditingController passwordC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  TextEditingController nameC = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> signup({
      required String email,
      required String password,
      required String phone,
      required String name,}) async {
    if (formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email,
            password: password
        ).then((value) {
          if (value.user != null) {
            saveUserData(
                email: email,
                password: password,
                name: name,
                phone: phone,
                uid: value.user!.uid,

            ).then((value) {
              if (value)
              {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) {
                          return const MyHomePage3();
                        }));
              }
            } );
          }
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.toString()))
        );
      }
    }
  }

  Future<bool> saveUserData({
    required String email,
    required String password,
    required String phone,
    required String name,
    required String uid,
  }) async {
    try {
      FirebaseFirestore.instance.collection('Users').doc(uid).set({

        'email': email,
        'password': password,
        'phone': phone,
        'name': name,
        'uid': uid,
      },
          SetOptions(merge: true)
      );
      return true;

    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.toString())));
      return false;
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
              const Text('Name'),
              TextFormField(
                controller: nameC,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'the name must not be empty';
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              const Text('Phone'),
              TextFormField(
                controller: phoneC,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'the phone must not be empty';
                  } else if (value.length < 11) {
                    return 'phone must be 11 numbers';
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
              Center(
                child: ElevatedButton(
                    onPressed: () async {
                      await signup(

                        email: emailC.text,
                        password: passwordC.text,
                        phone: phoneC.text,
                          name: nameC.text,
                      );
                    },
                    child: const Text('sign up')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
