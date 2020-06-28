
//import 'dart:html';

import 'dart:async';
import 'dart:io';

import 'package:chat/modules/share/FirestoreProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';


class ChatProvider {

  static final ChatProvider _instance = ChatProvider._internal(); 
  static final FirestoreProvider _firestoreProvider = FirestoreProvider();

  factory ChatProvider(){
    return _instance;
  }
  ChatProvider._internal(); 


  Future<void> setDocument(Map<String, dynamic> _document, String _pathCollection) async {

    _firestoreProvider.firestore
      .collection(_pathCollection)
      .document()
      .setData(
        _document, 
        merge: true
      );

  }

  Future<String> setFile(File _file) async {

    var _task = FirebaseStorage.instance.ref().child(
      DateTime.now().millisecondsSinceEpoch.toString(),
    ).putFile(_file);

    var _storageSnapshot = await _task.onComplete;
    String _url = await _storageSnapshot.ref.getDownloadURL();   
    return _url;

  }

  Future<Map<String, dynamic>> getDocument(String _pathDocument) async {

    Map<String, dynamic> _document; 

    await _firestoreProvider.firestore
            .document(_pathDocument)
            .get()
            .then((document) {
              _document = document.data;
            });

    return _document;
  }

   Future<Stream<QuerySnapshot>> geSnapshot(String _pathCollection)  async {
     var _snap = _firestoreProvider.firestore
                  .collection(_pathCollection)
                  .snapshots();

     return _snap;
  }

}