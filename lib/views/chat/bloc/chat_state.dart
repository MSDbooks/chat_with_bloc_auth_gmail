import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:chat/views/shared/defaultStates.dart';

class SendMessageLoaded extends DefaultState {

  @override
  String toString() => 'SendMessageLoaded';
}

class StartStreamChatLoaded extends DefaultState {

  Stream<QuerySnapshot> stream;
  StartStreamChatLoaded({@required this.stream}) : super();

  @override
  String toString() => 'StartStreamChatLoaded';
}