
import 'dart:convert' as convert;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:rehtjydtkuyiifykudrthag/model/Products.dart';
import 'package:http/http.dart' as http;
import 'package:rehtjydtkuyiifykudrthag/main.dart';



class NetworkRequest {


  static bool isLoading = true ;
  static bool isLoadingProfile = true ;

  static Future<DocumentSnapshot?> getDataFromFirebase()async{
    try{
      String uid = FirebaseAuth.instance.currentUser!.uid;
      return await FirebaseFirestore.instance.collection('Users').doc(uid).get();
    }catch(e){
      print(e.toString());
      return null;
    }
  }
  static DocumentSnapshot? userData ;


}






