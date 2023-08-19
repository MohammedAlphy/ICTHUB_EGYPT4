
import 'dart:convert' as convert;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:rehtjydtkuyiifykudrthag/model/Products.dart';
import 'package:http/http.dart' as http;
import 'package:rehtjydtkuyiifykudrthag/main.dart';



class NetworkRequest {

  static Future<List<Products>> getData() async{

    final response = await http.get(Uri.parse('https://dummyjson.com/products'));
    List<Products> ProductsList = [] ;

    if(response.statusCode == 200) {
      var jsonResponse =
      convert.jsonDecode(response.body) as Map<String, dynamic>;
      for (var item in jsonResponse['products']){
        ProductsList.add(Products.fromJson(item));
      }
    }
    return ProductsList;
  }

  static List <Products> products = [] ;
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






