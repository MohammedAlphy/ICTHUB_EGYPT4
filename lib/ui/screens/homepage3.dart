import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:rehtjydtkuyiifykudrthag/ui/screens/Home1.dart';
import 'package:rehtjydtkuyiifykudrthag/ui/screens/Profile.dart';
import 'package:rehtjydtkuyiifykudrthag/ui/screens/RealLogin.dart';
import 'package:rehtjydtkuyiifykudrthag/ui/screens/counter.dart';

class MyHomePage3 extends StatefulWidget {
  const MyHomePage3({super.key});

  @override
  State<MyHomePage3> createState() => _MyHomePage3State();
}

class _MyHomePage3State extends State<MyHomePage3> {
  int currentIndex = 0;

  void getPage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  List<Widget> screens = [
    const HomeScreen(),
    const Page2(input1: '120'),
    Profile(),
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: screens[currentIndex],
      // appBar: AppBar(
      //   elevation: 0,
      //   title: const Text('ICTHUB'),
      //   backgroundColor: const Color(0xFFFFFFFF),
      //   foregroundColor: Colors.black,
      //   leading: IconButton(
      //       onPressed: () async {
      //         await signOut().then((value) {
      //           if (value) {
      //             Navigator.pushReplacement(context,
      //                 MaterialPageRoute(builder: (context) {
      //               return LoginScreen();
      //             }));
      //           }
      //         });
      //       },
      //       icon: const Icon(Icons.logout)),
      //   centerTitle: true,
      //   titleTextStyle: const TextStyle(
      //       fontSize: 40, color: Colors.black, fontWeight: FontWeight.bold),
      //   actions: const [
      //     Icon(Icons.menu),
      //   ],
      // ),
      bottomSheet: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: const Color(0xFF787878)),
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        child: BottomNavigationBar(
          selectedItemColor: const Color(0xFFFFFFFF),
          unselectedItemColor: const Color(0xFF8091A1),
          backgroundColor: Colors.transparent,
          elevation: 0,
          currentIndex: currentIndex,
          onTap: (index) {
            getPage(index);
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_filled), label: 'home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.calculate_outlined),
              label: 'counter',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'profile',
            )
          ],
        ),
      ),
    );
  }
}
