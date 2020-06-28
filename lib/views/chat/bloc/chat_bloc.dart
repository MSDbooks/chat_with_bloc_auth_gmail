import 'package:chat/modules/chat/repositories/chatRepositoty.dart';
import 'package:chat/views/chat/bloc/chat_event.dart';
import 'package:chat/views/chat/bloc/chat_state.dart';
import 'package:chat/views/shared/defaultStates.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ChatBloc extends Bloc<ChatEvent, DefaultState> {

  FirebaseUser _firebaseUser;
  final GoogleSignIn _googleSignIng = GoogleSignIn();
  final ChatRepository _chatRepository = ChatRepository();
  
   
  String get getUidCurrentUser => _firebaseUser.uid; 

  @override
  DefaultState get initialState => Initial();


  ChatBloc(){
    FirebaseAuth.instance.onAuthStateChanged.listen((_user) {
      _firebaseUser = _user;
     });
  }

  @override
  Stream<DefaultState> mapEventToState(ChatEvent event) async* {


    var _currentUser = await _getUser();

    if(_currentUser == null){

    }

    switch (event.runtimeType) {

      case StartStreamChat:
        yield Loading();
        
        var _pathCollection = 'messages';
        var _stream = await _chatRepository.openSnapshot(_pathCollection);
        yield StartStreamChatLoaded(stream: _stream);

          // await _result.  forEach((snapshots) async { 
          //    var _list = List<Map<String, dynamic>>();
          //    await Future.forEach(snapshots.documents, (snapshot){
          //       _list.add(snapshot.data);
          //     });
          //     print('sink: ${_list.length}');
          //   });

        break;


      case SendMessage:
        var e = event as SendMessage;
        var _pathCollection = 'messages';

        if(e.file != null) {

          var _url = await _chatRepository.setFile(e.file);
          Map<String, dynamic> _map = {
            'uid': _currentUser.uid,
            'senderName': _currentUser.displayName,
            'senderPhotoUrl': _currentUser.photoUrl,
            'imgUrl': _url,
          };
          
          _chatRepository.setDocument(_map, _pathCollection);

        }else if(e.message != null){
           Map<String, dynamic> _map = {
            'uid': _currentUser.uid,
            'senderName': _currentUser.displayName,
            'senderPhotoUrl': _currentUser.photoUrl,
            'text': e.message,
          };
          
          _chatRepository.setDocument(_map, _pathCollection);

        }
        break;

    }

   

    
  }

   Future<FirebaseUser> _getUser() async {
    
    if(_firebaseUser != null){
      return _firebaseUser;
    }else{
      try{

        final GoogleSignInAccount _singIn = await _googleSignIng.signIn();
        final GoogleSignInAuthentication _auth = await _singIn.authentication;
        final AuthCredential _credential =GoogleAuthProvider.getCredential(
          idToken: _auth.idToken, 
          accessToken: _auth.accessToken
        );
        final AuthResult _result = await FirebaseAuth
                                                .instance
                                                .signInWithCredential(_credential);

        final FirebaseUser _user = _result.user;  

        return _user;                                                    

      }catch(e){
        return null;
      }

    }
  }

  

}