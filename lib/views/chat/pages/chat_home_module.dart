import 'package:chat/views/chat/bloc/chat_bloc.dart';
import 'package:chat/views/chat/bloc/chat_state.dart';
import 'package:chat/views/chat/pages/subpages/chat_home_body.dart';
import 'package:chat/views/shared/defaultStates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatHomeModule extends StatefulWidget {
  @override
  _ChatHomeModuleState createState() => _ChatHomeModuleState();
}

class _ChatHomeModuleState extends State<ChatHomeModule> {
  
  ChatBloc _bloc;

  @override
  void initState() {
    super.initState();
    
    if(_bloc == null){
      _bloc = BlocProvider.of<ChatBloc>(context);
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => SafeArea(
        top: false,
        bottom: false,
        child: BlocBuilder<ChatBloc, DefaultState>(
          bloc: BlocProvider.of<ChatBloc>(context),
          builder: (context, state){
            if (state is Initial || state is SendMessageLoaded) {
              return ChatHomeBody();
            }
            if (state is Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Container();
          },
        )
      ),
    );
  }
}