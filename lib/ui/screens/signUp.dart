import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehtjydtkuyiifykudrthag/cubit/my_app_cubit.dart';
import 'package:rehtjydtkuyiifykudrthag/cubit/my_app_state.dart';
import 'package:rehtjydtkuyiifykudrthag/ui/screens/RealLogin.dart';
import 'package:rehtjydtkuyiifykudrthag/ui/screens/homepage3.dart';

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
              const Text('Welcome back! Glad\nto see you, Again!',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight:FontWeight.w700,
                ),
              ),
              const SizedBox(height: 50,),
              TextFormField(
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 20
                        ,horizontal: 20),
                    hintText: 'Enter your email',
                    hintStyle: const TextStyle(
                      color: Color(0xFF8391A1),
                    ),
                    fillColor: Color(0xFFF7F8F9),
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color:Color(0xFFDADADA),
                      ),
                    )

                ),
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

              TextFormField(
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 20
                        ,horizontal: 20),
                    hintText: 'Enter your name',
                    hintStyle: const TextStyle(
                      color: Color(0xFF8391A1),
                    ),
                    fillColor: Color(0xFFF7F8F9),
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color:Color(0xFFDADADA),
                      ),
                    )

                ),
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

              TextFormField(
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 20
                        ,horizontal: 20),
                    hintText: 'Enter your phone',
                    hintStyle: const TextStyle(
                      color: Color(0xFF8391A1),
                    ),
                    fillColor: Color(0xFFF7F8F9),
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color:Color(0xFFDADADA),
                      ),
                    )

                ),
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

              TextFormField(
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 20
                        ,horizontal: 20),
                    hintText: 'Enter your password',
                    hintStyle: const TextStyle(
                      color: Color(0xFF8391A1),
                    ),
                    fillColor: Color(0xFFF7F8F9),
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color:Color(0xFFDADADA),
                      ),
                    )

                ),
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
                child: BlocConsumer<AppCubitA, AppStateA>(
                  listener: (context, state) {
                    if (state is CreateAccErrorState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            state.error,
                          ),
                        ),
                      );
                    } else if (state is CreateAccDoneState){
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) {
                                return const MyHomePage3();
                              },),);
                    }
                  },
                  builder: (context, state) {
                    return ElevatedButton(
                        style:
                        ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF8391A1),
                          minimumSize: const Size(double.infinity, 60),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          textStyle: const TextStyle(fontSize: 20,),
                        ),
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          await context.read<AppCubitA>().signup(
                                email: emailC.text,
                                password: passwordC.text,
                                phone: phoneC.text,
                                name: nameC.text,
                              );
                        }
                      },
                      child: state is CreateAccLoadingState ?
                        const Center(
                        child : CircularProgressIndicator(
                        color: Colors.white,
                    )
                        ) : const Text('Sign Up')
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
