import 'package:firebase_auth/firebase_auth.dart';
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
      appBar: AppBar(
        title: const Text('ICTHUB'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.black,
        leading: IconButton(
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
        centerTitle: true,
        titleTextStyle: const TextStyle(
            fontSize: 40, color: Colors.black, fontWeight: FontWeight.bold),
        actions: const [
          Icon(Icons.menu),
        ],
      ),
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            getPage(index);
          },
          backgroundColor: Colors.white,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_filled), label: 'home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.calculate_outlined), label: 'Counter'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ]),
    );
  }
}
