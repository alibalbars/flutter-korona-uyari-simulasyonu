import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class crudMethods {
  bool isLoggedIn(){
    if(FirebaseAuth.instance.currentUser != null){
      return true;
    } else {
      return false;
    }
  }

  // Future<void> addData(carData) async {
  //   if(isLoggedIn()){
  //     Firestore.instance.collection('testcrud').add(carData).catchError((e){
  //       print(e);
  //     });
  //   }
  //   else {
  //     print("You need to be logged in");
  //   }
  // }

  addData() {

    Map<String,dynamic> demoData = {"name" : "The Growing Developer",
    "motto" : "Let's learn and grow together"};
    CollectionReference collectionReference = Firestore.instance.collection("path");
    collectionReference.add(demoData);
    print("Firebase ekleme işlemi tamamlandı!!!!!!!!!!!!!!!!!!!1");

  }
}