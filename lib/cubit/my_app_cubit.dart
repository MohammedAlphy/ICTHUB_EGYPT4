import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
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
      await FirebaseFirestore.instance.collection('Users').doc(uid).get();
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
      print(e);
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
          emit(LoginDoneState());
        }
      });
    } catch (e) {
      emit(LoginErrorState(e.toString()));
    }

  }

  Future<void> signup({
    required String email,
    required String password,
    required String phone,
    required String name,}) async {

      try {
        emit(CreateAccLoadingState());
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email,
            password: password
        ).then((value) {
          if (value.user != null) {
            saveUserData(
              email: email,
              password: password,
              name: name,
              phone: phone,
              uid: value.user!.uid,

            ).then((value) {
              if (value)
              {
                emit(CreateAccDoneState());
              }
              else
                {
                  emit(CreateAccErrorState('SaveUserData Error'));

                }
            } );
          }
        });
      } catch (e) {
        emit(CreateAccErrorState(e.toString()));

      }

  }


  Future<bool> saveUserData({
    required String email,
    required String password,
    required String phone,
    required String name,
    required String uid,
  }) async {
    try {
      FirebaseFirestore.instance.collection('Users').doc(uid).set({

        'email': email,
        'password': password,
        'phone': phone,
        'name': name,
        'uid': uid,
        'image': '',
      },
          SetOptions(merge: true)
      );
      return true;

    } catch (error) {
      return false;
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


  ImagePicker picker = ImagePicker();

  File? img ;

  Future<void> pickImage() async{
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
if(image != null ){
  img = File(image.path);
  uploadImageToUserData(
    File(image.path
      )
  );
  emit(PickImageState());
} else {
  print('null image');
}

  }


  Future<void> uploadImageToUserData(File image) async{

    try{
      emit(UploadLoadingState());
      String uid = FirebaseAuth.instance.currentUser!.uid;
      final ref = FirebaseStorage.instance.ref().child('UsersImages').child('${DateTime.now()}.jpg');
await ref.putFile(File(image.path));

String? url ;

url = await ref.getDownloadURL();

await FirebaseFirestore.instance.collection('Users').doc(uid).update(
  {
    'image' : url,
  },

);

    }catch(e){

    }


  }

}
