import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehtjydtkuyiifykudrthag/cubit/my_app_cubit.dart';
import 'package:rehtjydtkuyiifykudrthag/cubit/my_app_state.dart';
import 'package:rehtjydtkuyiifykudrthag/ui/screens/Login.dart';
import 'package:rehtjydtkuyiifykudrthag/ui/screens/homepage3.dart';

import '../../main.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  TextEditingController emailC = TextEditingController();

  TextEditingController passwordC = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BlocConsumer<AppCubitA, AppStateA>(
                    listener: (context, state) {
                      if (state is LoginErrorState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              state.error,
                            ),
                          ),
                        );
                      } else if (state is LoginDoneState) {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return const MyHomePage3();
                        }));
                      }
                    },
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            context
                                .read<AppCubitA>()
                                .login(emailC.text, passwordC.text);
                          }
                        },
                        child: state is LoginLoadingState
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : const Text('Login'),
                      );
                    },
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return SignUp();
                        }));
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
