

import 'dart:io';

class ChatEvent {}

class StartStreamChat extends ChatEvent {

  @override
  String toString() => 'StartStreamChat';
}

class SendMessage extends ChatEvent {

  final String message;
  final File file;
  SendMessage({this.message, this.file}) : super();

  @override
  String toString() => 'SendMessage';
}