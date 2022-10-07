import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uppah_0_0_0/pages/home_page.dart';

class UserManagement {
  storeNewUser(user, context) async {
    var firebaseUser = await FirebaseAuth.instance.currentUser!;
    FirebaseFirestore.instance.collection('users').doc(firebaseUser.uid);
  }
}
