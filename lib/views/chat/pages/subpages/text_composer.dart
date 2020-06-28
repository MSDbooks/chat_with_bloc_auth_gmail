import 'package:chat/views/chat/bloc/chat_bloc.dart';
import 'package:chat/views/chat/bloc/chat_event.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TextComposer extends StatefulWidget {

  final ChatBloc bloc;
  const TextComposer({Key key, @required this.bloc}) : super(key: key);

  @override
  _TextComposerState createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {

  TextEditingController _controller;
  
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    
  }

   @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    
  }

  void sendMessage(String text){
    if(text != null && text.length > 3){
      _controller.text = '';
      widget.bloc..add(SendMessage(message: text));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.photo_camera),
              onPressed: () async {
                var _imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
                if(_imageFile != null ){
                  widget.bloc..add(SendMessage(file: _imageFile));
                }
              },
            ),
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: InputDecoration.collapsed(
                  hintText: 'Digite sua mensagem'
                ),
                onSubmitted:(text){
                  sendMessage(text);
                },
              ),
            ),
            IconButton(
              icon: Icon(Icons.send), 
              onPressed:(){
                sendMessage(_controller.text);
              },
            )
          ],
        ),
        
      ),
    );
  }
}