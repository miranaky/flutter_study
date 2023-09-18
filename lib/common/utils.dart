import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void showFirebaseErrorSnack(BuildContext context, Object? error) {
  final snack = SnackBar(
    showCloseIcon: true,
    content:
        Text((error as FirebaseException).message ?? "Something went wrong"),
  );
  ScaffoldMessenger.of(context).showSnackBar(snack);
}
