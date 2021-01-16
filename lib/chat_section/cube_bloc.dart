import 'package:connectycube_sdk/connectycube_chat.dart';
import 'package:rxdart/rxdart.dart';

class CubeBloc {
  static final CubeBloc _bloc = CubeBloc._();

  factory CubeBloc() => _bloc;

  CubeBloc._();

  final BehaviorSubject<Stream<CubeMessage>> _subject = BehaviorSubject();

  Stream<Stream<CubeMessage>> get cubeStream => _subject.stream;

  updateCube(Stream<CubeMessage> cubeStream){
    _subject.add(cubeStream);
  }
}

final cubeBloc = CubeBloc();