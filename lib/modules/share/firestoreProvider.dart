import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreProvider {
  final Firestore firestore = Firestore.instance;

  static final FirestoreProvider _instance = FirestoreProvider._internal();

  factory FirestoreProvider(){
      return _instance;
  }
  FirestoreProvider._internal();

}