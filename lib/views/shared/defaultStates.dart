import 'package:meta/meta.dart';

class DefaultState {}

class Initial extends DefaultState {
  @override
  String toString() => 'Initial';
}

class Loading extends DefaultState {
  final String eventString;
  Loading({this.eventString}) : super();
  @override
  String toString() => 'Loading';
}

class Empty extends DefaultState {
  @override
  String toString() => 'Empty';
}

class Success extends DefaultState {
  @override
  String toString() => 'Success';

}

class Error extends DefaultState {

  final String error;
  Error({@required this.error}) : super();
  @override
  String toString() => 'Error { errorMessage: $error }';

}