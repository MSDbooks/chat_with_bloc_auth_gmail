

import 'package:chat/views/chat/bloc/chat_bloc.dart';
import 'package:chat/views/chat/bloc/chat_event.dart';
import 'package:chat/views/chat/bloc/chat_state.dart';
import 'package:chat/views/chat/pages/subpages/text_composer.dart';
import 'package:chat/views/shared/defaultStates.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ChatHomeBody extends StatefulWidget {
  
  @override
  _ChatHomeBodyState createState() => _ChatHomeBodyState();
}

class _ChatHomeBodyState extends State<ChatHomeBody> {
  
  final _bloc = ChatBloc();

  @override
  void dispose() {
    super.dispose();
    _bloc.close();

  }

  @override
  void initState() {
    super.initState();
    _bloc..add(StartStreamChat());
  }
  @override
  Widget build(BuildContext context) {
      return Column(
         children: <Widget>[
            Container(
              child: BlocBuilder<ChatBloc, DefaultState>(
              bloc: _bloc,
              builder: (context, state) {
                if (state is Loading || state is Initial) {
                       
                  return Container(
                    child: Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child:CircularProgressIndicator(),
                      )
                    )
                  );
                      
                  }
                  if(state is  StartStreamChatLoaded){
                    return list(stream: state.stream);
                  }
                  return Container();
              },
            ),
          ), 
          TextComposer(bloc: _bloc),
         ],
      );

  }

  Widget list({Stream<QuerySnapshot> stream}){
    return Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: stream,
              builder: (context, snapshot) {
                return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  reverse: true,
                  itemBuilder: (context, index){
                    return chatMessage(snapshot.data.documents[index]);
                  },
                );
              },
            ),
    );

  }

  Widget chatMessage(DocumentSnapshot data){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: Row(
        children: <Widget>[
          _bloc.getUidCurrentUser == data['uid'] ?
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(data['senderPhotoUrl']),
            ),
          ) : Container(),
          Expanded(
            child: Column(
              crossAxisAlignment: _bloc.getUidCurrentUser != data['uid'] ? CrossAxisAlignment.end  : CrossAxisAlignment.start,
              children: <Widget>[
                data['imgUrl'] != null 
                  ? Image.network(data['imgUrl'])
                  : Text(data['text'], style: TextStyle(fontSize: 16)),
                Text(
                  data['senderName'],
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500
                  ),
                ),
              ],
            ),
          ),
          _bloc.getUidCurrentUser != data['uid'] ?
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(data['senderPhotoUrl']),
            ),
          ) : Container(),

        ]
      ),
    );

  }
}