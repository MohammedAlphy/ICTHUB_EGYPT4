import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:rehtjydtkuyiifykudrthag/cubit/my_app_state.dart';
import 'package:rehtjydtkuyiifykudrthag/model/user_data_model.dart';
import '../model/Products.dart';
import 'dart:convert' as convert;


class AppCubitA extends Cubit<AppStateA> {
  AppCubitA() : super(MyAppInitial());

  List <Products> products = [];

  UserDataModel? userData;


  Future<void> getData() async {
    try {
      emit(LoadingState());
      final response = await http.get(
          Uri.parse('https://dummyjson.com/products'));


      if (response.statusCode == 200) {
        var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
        for (var item in jsonResponse['products']) {
          products.add(Products.fromJson(item));
        }
      }
      emit(DoneState());
    } catch (e) {
      emit(ErrorState());
    }
  }

  Future<void> getDataFromFirebase() async {
    try {
      emit(GetDatLoadingState());
      String? uid = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot userA =
      await FirebaseFirestore.instance.collection('users').doc(uid).get();
      userData = UserDataModel(
          name: userA['name'],
          password: userA['password'],
          phone: userA['phone'],
          email: userA['email'],
          uid: userA['uid'],
          image: userA['image']);
      emit(GetDatDoneState());
    } catch (e) {
      emit(GetDatErrorState(e.toString()));
    }
  }

  Future<void> login(
      String email,
      String password,
      ) async {
    try {
      emit(LoginLoadingState());
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      ).then((value) {
        if (value.user != null) {
          emit(LoginLoadingState());
        }
      });
    } catch (e) {
      emit(LoginErrorState(e.toString()));
    }

  }




  double sum = 0;
  final TextEditingController input1Controller = TextEditingController();
  final TextEditingController input2Controller = TextEditingController();

  void getSum() {

      sum = double.parse(input1Controller.text) +
          double.parse(input2Controller.text);
emit(GetSum());
  }

}
