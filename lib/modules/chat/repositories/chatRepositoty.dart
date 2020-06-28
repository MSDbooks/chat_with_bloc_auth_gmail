import 'dart:async';
import 'dart:io';

import 'package:chat/modules/chat/providers/chatProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRepository {

  final ChatProvider _provider = ChatProvider();

  Future<void> setDocument(Map<String, dynamic> _document, String _pathCollection) async{
    return _provider.setDocument(_document, _pathCollection);
  }

  Future<Map<String, dynamic>> getDocument(String pathDocument) async{
    return _provider.getDocument(pathDocument);
  }

  Future<String> setFile(File file) async{
    return _provider.setFile(file);
  }

   Future<Stream<QuerySnapshot>> openSnapshot(String _pathCollection) async {
    return _provider.geSnapshot(_pathCollection);
  }

}