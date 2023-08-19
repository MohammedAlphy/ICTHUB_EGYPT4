import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rehtjydtkuyiifykudrthag/network/network%20request.dart';

class Profile extends StatefulWidget {
  Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    if (NetworkRequest.isLoadingProfile) {
      Future.delayed(Duration.zero, () async {
        var data = await NetworkRequest.getDataFromFirebase() ;
        setState(() {
          NetworkRequest.userData = data;
          NetworkRequest.isLoadingProfile = false;
        });
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NetworkRequest.isLoadingProfile?
      const Center(
        child: CircularProgressIndicator(),
      )
      :Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ListTile(
              style: ListTileStyle.list,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                side: const BorderSide(color: Colors.black),
              ),
              title:Text(
                  NetworkRequest.userData!['email'],
               textAlign:TextAlign.center,
                 ),
                leading: const Icon(Icons.email),
              ),
            const SizedBox(height: 10,),
            ListTile(
              style: ListTileStyle.list,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: const BorderSide(color: Colors.black),
              ),
              title:Text(
                NetworkRequest.userData!['name'],
                textAlign:TextAlign.center,
              ),
              leading: const Icon(Icons.person),
            ),
            const SizedBox(height: 10,),
            ListTile(
              style: ListTileStyle.list,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: const BorderSide(color: Colors.black),
              ),
              title:Text(
                NetworkRequest.userData!['phone'],
                textAlign:TextAlign.center,
              ),
              leading: const Icon(Icons.phone),
            ),
            const SizedBox(height: 10,),
            ListTile(
              style: ListTileStyle.list,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: const BorderSide(color: Colors.black),
              ),
              title:Text(
                NetworkRequest.userData!['password'],
                textAlign:TextAlign.center,
              ),
              leading: const Icon(Icons.lock),
            ),
            const SizedBox(height: 10,),
            ListTile(
              style: ListTileStyle.list,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: const BorderSide(color: Colors.black),
              ),
              title:Text(
                NetworkRequest.userData!['uid'],
                textAlign:TextAlign.center,
              ),
              leading: const Icon(Icons.file_copy),
            ),


          ],
        ),
      ),
    );
  }
}
