import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:city_clinic_doctor/new/utils/prefrence_helper.dart';
import 'package:connectycube_sdk/connectycube_sdk.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'chat_dialog_screen.dart';
import 'chat_list_bloc.dart';
import 'cube_bloc.dart';
import 'new_dialog_screen.dart';
import 'utils/api_utils.dart';
import 'utils/consts.dart';


class SelectDialogScreen extends StatelessWidget {
  static const String TAG = "SelectDialogScreen";

  SelectDialogScreen();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyLayout(),
    );
  }
}

class BodyLayout extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BodyLayoutState();
  }
}

class _BodyLayoutState extends State<BodyLayout> {
  static const String TAG = "_BodyLayoutState";
  CubeUser currentUser;
  List<ListItem<CubeDialog>> dialogList = [];
  StreamSubscription<CubeMessage> msgSubscription;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(bottom: 16, top: 16),
        child: msgSubscription == null
            ? Container(
                margin: EdgeInsets.all(40),
                alignment: FractionalOffset.center,
                child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(themeColor),),
              )
            : _getDialogsList(context),
      ),
      // floatingActionButton: FloatingActionButton(
      //   heroTag: "New dialog",
      //   child: Icon(
      //     Icons.chat,
      //     color: Colors.white,
      //   ),
      //   backgroundColor: Colors.blue,
      //   onPressed: () => _createNewDialog(context),
      // ),
    );
  }

  void _createNewDialog(BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateChatScreen(currentUser),
      ),
    ).then((value) => refresh());
  }

  void _processGetDialogError(exception) {
    log("GetDialog error $exception", TAG);
    if (mounted)
      // setState(() {
      //   _isDialogContinues = false;
      // });
    showDialogError(exception, context);
  }

  bool firstTimeNavigating = true;
  bool isFirstTime = true;

  Widget _getDialogsList(BuildContext context) {
    print('_getDialogsList  $dialogList');
      return dialogList.isEmpty
          ? Center(child: Text("No Chats Yet"))
          : AnimatedList(
            initialItemCount: dialogList.length,
            // itemCount: dialogList.length,
            itemBuilder: (ctx, index, anim) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: _getListItemTile(ctx, index),
              );
            },
      );
  }

  Widget _getListItemTile(BuildContext context, int index) {
    getDialogIcon() {
      var dialog = dialogList[index].data;
      if (dialog.type == CubeDialogType.PRIVATE)
        return Icon(
          Icons.person,
          size: 40.0,
          color: greyColor,
        );
      else {
        return Icon(
          Icons.group,
          size: 40.0,
          color: greyColor,
        );
      }
    }

    getDialogAvatarWidget() {
      var dialog = dialogList[index].data;
      if (dialog.photo == null) {
        return CircleAvatar(
            radius: 25, backgroundColor: greyColor3, child: getDialogIcon());
      } else {
        return CachedNetworkImage(
          placeholder: (context, url) => Container(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(themeColor),
            ),
            width: 40.0,
            height: 40.0,
            padding: EdgeInsets.all(70.0),
            decoration: BoxDecoration(
              color: greyColor2,
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
          ),
          imageUrl: dialogList[index].data.photo,
          width: 45.0,
          height: 45.0,
          fit: BoxFit.cover,
        );
      }
    }

    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300),borderRadius: BorderRadius.circular(8)),
      child: FlatButton(
        child: Row(
          children: <Widget>[
            Material(
              child: getDialogAvatarWidget(),
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
              clipBehavior: Clip.hardEdge,
            ),
            Flexible(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Text(
                        '${dialogList[index].data.name ?? 'Not available'}',
                        style: TextStyle(
                            fontSize: 17.0),
                      ),
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 5.0),
                    ),
                    Container(
                      child: Text(
                        '${dialogList[index].data.lastMessage ?? 'Not available'}',
                        style: TextStyle(
                            fontSize: 14.0),
                      ),
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                    ),
                  ],
                ),
                margin: EdgeInsets.only(left: 20.0),
              ),
            ),
            Visibility(
              child: IconButton(
                iconSize: 25.0,
                icon: Icon(
                  Icons.delete,
                  color: themeColor,
                ),
                onPressed: () {
                  // _deleteDialog(context, dialogList[index].data, index);
                },
              ),
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              // visible: dialogList[index].isSelected,
              visible: false,
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    '${dialogList[index].data.lastMessageDateSent != null ? DateFormat('MMM dd').format(DateTime.fromMillisecondsSinceEpoch(dialogList[index].data.lastMessageDateSent * 1000)) : 'Not available'}',
                    style: TextStyle(
                      color:  Colors.black54,
                      fontSize: 14
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        onLongPress: () {
          setState(() {
            dialogList[index].isSelected = !dialogList[index].isSelected;
          });
        },
        onPressed: () {
          print('DIalogLIST--$dialogList');
          if(currentUser!=null){
            _openDialog(context, dialogList[index].data);
          }else Fluttertoast.showToast(msg: 'Please wait');

        },
        color:
            dialogList[index].isSelected ? Colors.black54 : Colors.transparent,
        padding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
      margin: EdgeInsets.only(left: 5.0, right: 5.0),
    );
  }

  void _deleteDialog(BuildContext context, CubeDialog dialog, index) async {
    log("_deleteDialog= $dialog");
    // Fluttertoast.showToast(msg: 'Coming soon');
    bool force =
        false; // true - to delete everywhere, false - to delete for himself

    deleteDialog(dialog.dialogId, force)
        .then((voidResult) {})
        .catchError((error) {});

    setState(() {
      dialogList.removeAt(index);
    });
    // ChatListBloc().fetchList();
  }

  _openDialog(BuildContext context, CubeDialog dialog) {
    log("_openDialog= $dialog");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatDialogScreen(currentUser, dialog,false,""),
      ),
    );
  }

  void refresh() {
    // setState(() {
    //   _isDialogContinues = true;
    // });
  }

  @override
  void initState() {
    super.initState();

    PreferenceHelper.getCUser().then((value) {
      setState(() {
        currentUser = value;
      });
    });

    cubeBloc.cubeStream.listen((event) {
      print('sssssss');
      ChatListBloc().chatList.listen((event) {
        print('AAA ${dialogList.length}');
        if (mounted)
          setState(() {
            print('AAA ${dialogList.length}');
            dialogList = event;
          });
      });
      msgSubscription = event.listen((onReceiveMessage));
      ChatListBloc().fetchList();
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    msgSubscription.cancel();
    super.dispose();
  }

  void onReceiveMessage(CubeMessage message) {
    log("onReceiveMessage global message= $message");
    ChatListBloc().fetchList();
    updateDialog(message);
  }

  updateDialog(CubeMessage msg) {
    ListItem<CubeDialog> dialogItem = dialogList.firstWhere(
        (dlg) => dlg.data.dialogId == msg.dialogId,
        orElse: () => null);
    if (dialogItem == null) return;
    dialogItem.data.lastMessage = msg.body;
    setState(() {
      dialogItem.data.lastMessage = msg.body;
      dialogList.insert(0, dialogItem);
      dialogList.remove(dialogItem);
    });
  }

  void _createDialog(BuildContext context, Set<int> users, bool isGroup,bool fromSearch,String name) async {
    log("_createDialog with users= $users");
    CubeDialog newDialog =
        CubeDialog(CubeDialogType.PRIVATE, occupantsIds: users.toList());
    createDialog(newDialog).then((createdDialog) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatDialogScreen(currentUser, createdDialog,fromSearch,name),
          ),
        );
    }).catchError(_processCreateDialogError);
  }

  void _processCreateDialogError(exception) {
    log("Login error $exception", TAG);
  }
}
