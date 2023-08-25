

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehtjydtkuyiifykudrthag/BlocObserver.dart';
import 'package:rehtjydtkuyiifykudrthag/cubit/my_app_cubit.dart';
import 'package:rehtjydtkuyiifykudrthag/ui/screens/Home1.dart';
import 'package:rehtjydtkuyiifykudrthag/ui/screens/signUp.dart';
import 'package:rehtjydtkuyiifykudrthag/ui/screens/Profile.dart';
import 'package:rehtjydtkuyiifykudrthag/ui/screens/RealLogin.dart';
import 'package:rehtjydtkuyiifykudrthag/ui/screens/homepage3.dart';

import 'package:rehtjydtkuyiifykudrthag/ui/screens/counter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(BlocProvider<AppCubitA>(
        create: (context) => AppCubitA()..getData()..getDataFromFirebase(),
      child: MyApp(),
    )
  );
}



class MyApp extends StatelessWidget {
   MyApp({super.key});

User? user = FirebaseAuth.instance.currentUser;



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner:false ,
      theme: ThemeData(bottomSheetTheme: const BottomSheetThemeData(
backgroundColor: Colors.transparent,
      )),
      home: user == null ? LoginScreen() : const MyHomePage3(),
    );
  }
}

//*************************************************************************************************



