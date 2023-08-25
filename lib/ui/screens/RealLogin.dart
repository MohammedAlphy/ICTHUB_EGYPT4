import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rehtjydtkuyiifykudrthag/cubit/my_app_cubit.dart';
import 'package:rehtjydtkuyiifykudrthag/cubit/my_app_state.dart';
import 'package:rehtjydtkuyiifykudrthag/ui/screens/signUp.dart';
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
              const Text('Welcome back! Glad\nto see you, Again!',
              style: TextStyle(
                fontSize: 30,
                fontWeight:FontWeight.w700,
              ),
              ),
              const SizedBox(height: 50,),
              TextFormField(
                controller: emailC,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'the email must not be empty';
                  }
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 20
                  ,horizontal: 20),
                  hintText: 'Enter your Email',
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
              ),
              const SizedBox(
                height: 10,
              ),

              TextFormField(
                controller: passwordC,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'the password must not be empty';
                  } else if (value.length < 6) {
                    return 'password must be 6 numbers or more';
                  }
                },
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
              ),
               SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),


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
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),

              const Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: Color(0xFFE8ECF4),
                      thickness: 2,
                      endIndent: 10,
                    ),
                  ),
                  Text('Or login with',
                  style: TextStyle(
                    color: Color(0xFF6A707C),
                  ),),
                  Expanded(
                    child: Divider(
                      color: Color(0xFFE8ECF4),
                      thickness: 2,
                      indent: 10,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset('assets/facebook.svg'

                   ),
                  SvgPicture.asset('assets/google.svg'

                  ),
                  SvgPicture.asset('assets/apple.svg'

                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Dont have an account ?'),
                  TextButton(
                      onPressed: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                              return SignUp();
                            }));
                      },
                      child:const Text(
                        'Register now',
                        style: TextStyle(
                          color: Color(0xFFF14336)
                        ),
                      ), ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
