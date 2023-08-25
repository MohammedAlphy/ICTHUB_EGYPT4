import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehtjydtkuyiifykudrthag/cubit/my_app_cubit.dart';
import 'package:rehtjydtkuyiifykudrthag/cubit/my_app_state.dart';
import 'package:rehtjydtkuyiifykudrthag/network/network%20request.dart';
import 'package:rehtjydtkuyiifykudrthag/ui/screens/RealLogin.dart';

class Profile extends StatelessWidget {
  Profile({super.key});

  //@override
  //void initState() {
  //if (NetworkRequest.isLoadingProfile) {
  //   Future.delayed(Duration.zero, () async {
  //    var data = await NetworkRequest.getDataFromFirebase() ;
  //   setState(() {
  //     NetworkRequest.userData = data;
  //    NetworkRequest.isLoadingProfile = false;
  //   });
  //  });
  // }
  // super.initState();
  // }
  Future<bool> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AppCubitA, AppStateA>(
        builder: (context, state) {
          if (context.read<AppCubitA>().userData != null) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                      onPressed: () async {
                        await signOut().then((value) {
                          if (value) {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                              return LoginScreen();
                            }));
                          }
                        });
                      },
                      icon: const Icon(Icons.logout)),
                ),
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 80,
                        backgroundImage: context
                            .read<AppCubitA>()
                            .userData!
                            .image ==
                            ''
                            ? const NetworkImage(
                            'https://cdn-icons-png.flaticon.com/512/3135/3135715.png')
                            : NetworkImage(
                            context.read<AppCubitA>().userData!.image),
                      ),
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(90)),
                          child: IconButton(
                              onPressed: () {
                                context.read<AppCubitA>().pickImage();
                              },
                              icon: const Icon(
                                Icons.camera_alt_outlined,
                              )),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ListTile(
                    style: ListTileStyle.list,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: const BorderSide(color: Colors.black),
                    ),
                    title: Text(
                      context.read<AppCubitA>().userData!.email,
                      textAlign: TextAlign.center,
                    ),
                    leading: const Icon(Icons.email),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    style: ListTileStyle.list,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: const BorderSide(color: Colors.black),
                    ),
                    title: Text(
                      context.read<AppCubitA>().userData!.name,
                      textAlign: TextAlign.center,
                    ),
                    leading: const Icon(Icons.person),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    style: ListTileStyle.list,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: const BorderSide(color: Colors.black),
                    ),
                    title: Text(
                      context.read<AppCubitA>().userData!.phone,
                      textAlign: TextAlign.center,
                    ),
                    leading: const Icon(Icons.phone),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    style: ListTileStyle.list,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: const BorderSide(color: Colors.black),
                    ),
                    title: Text(
                      context.read<AppCubitA>().userData!.password,
                      textAlign: TextAlign.center,
                    ),
                    leading: const Icon(Icons.lock),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    style: ListTileStyle.list,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: const BorderSide(color: Colors.black),
                    ),
                    title: Text(
                      context.read<AppCubitA>().userData!.uid,
                      textAlign: TextAlign.center,
                    ),
                    leading: const Icon(Icons.file_copy),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text('Error'));
          }
        },
      ),
    );
  }
}
