import 'package:connectycube_sdk/connectycube_chat.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'utils/api_utils.dart';

class ChatListBloc {
  static final ChatListBloc _bloc = ChatListBloc._();

  factory ChatListBloc() {return _bloc;}

  ChatListBloc._();

  BehaviorSubject<List<ListItem<CubeDialog>>> _subject  = BehaviorSubject();

  Stream<List<ListItem<CubeDialog>>> get chatList => _subject.stream;

  fetchList() async{
    var dialogs  = await getDialogs();
    print('initList $dialogs');
    var list = dialogs.items.map((dialog) => ListItem(dialog)).toList();
    _subject.add(list);
  }
}

