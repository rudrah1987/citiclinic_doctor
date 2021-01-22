import 'package:city_clinic_doctor/chat_section/utils/api_utils.dart';
import 'package:connectycube_sdk/connectycube_chat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'chat_dialog_screen.dart';
import 'new_group_dialog_screen.dart';
import 'utils/consts.dart';
import 'widgets/common.dart';

class CreateChatScreen extends StatefulWidget {
  final CubeUser _cubeUser;

  @override
  State<StatefulWidget> createState() {
    return _CreateChatScreenState(_cubeUser);
  }

  CreateChatScreen(this._cubeUser);
}

class _CreateChatScreenState extends State<CreateChatScreen> {
  static const String TAG = "_CreateChatScreenState";
  final CubeUser currentUser;

  _CreateChatScreenState(this.currentUser);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () => _onBackPressed(context),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text(
            'Logged in as ${currentUser.login}',
          ),
        ),
        body: BodyLayout(currentUser),
      ),
    );
  }

  Future<bool> _onBackPressed(BuildContext context) {
    Navigator.pop(context);
    return Future.value(false);
  }
}

class BodyLayout extends StatefulWidget {
  final CubeUser currentUser;

  BodyLayout(this.currentUser);

  @override
  State<StatefulWidget> createState() {
    return _BodyLayoutState(currentUser);
  }
}

class _BodyLayoutState extends State<BodyLayout> {
  static const String TAG = "_BodyLayoutState";

  final CubeUser currentUser;
  List<CubeUser> userList = [];
  Set<int> _selectedUsers = {};
  var _isUsersContinues = false;
  var _isPrivateDialog = true;
  String userToSearch;
  String userMsg = " ";
  TextEditingController _searchController = TextEditingController();
  List<CubeUser> selectedUserList = [];

  bool _isDialogContinues = false;
  var _darkTheme = true;

  _BodyLayoutState(this.currentUser);

  _searchUser(value) {
    log("searchUser _user= $value");
    if (value != null)
      setState(() {
        userToSearch = value;
        _isUsersContinues = true;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
          child: Column(
            children: [
              _buildTextFields(),
              _buildDialogButton(),
              Container(
                margin: EdgeInsets.only(left: 8),
                child: Visibility(
                  maintainSize: false,
                  maintainAnimation: false,
                  maintainState: false,
                  visible: _isUsersContinues,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                ),
              ),
              Expanded(
                child: _getUsersList(context),
              ),
            ],
          )),
      floatingActionButton: new Visibility(
        visible: !_isPrivateDialog,
        child: FloatingActionButton(
          heroTag: "New dialog",
          child: Icon(
            Icons.check,
            color: Colors.white,
          ),
          backgroundColor: Colors.blue,
          onPressed: () {
            print('GROUPUSER_float $_selectedUsers');
            if (_selectedUsers.length < 2) {
              Fluttertoast.showToast(msg: 'Please select atleast 2 users');
            } else {
              _createDialog(context, _selectedUsers, true, "");
            }
          },
        ),
      ),
    );
  }

  Widget _buildTextFields() {
    return new Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: new Container(
              // width: 300,
              margin: EdgeInsets.only(top: 15),
              child: new TextField(
                  controller: _searchController,
                  textInputAction: TextInputAction.search,
                  decoration:
                      new InputDecoration(labelText: 'Search Neighbors'),
                  onSubmitted: (value) {
                    _searchUser(value.trim());
                  }),
            ),
          ),
          InkWell(
            onTap: () {
              _searchUser(_searchController.text.trim());
            },
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 10, top: 5),
              child: Icon(
                Icons.search,
                size: 30,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDialogButton() {
    getIcon() {
      if (_isPrivateDialog) {
        return Icons.person;
      } else {
        return Icons.people;
      }
    }

    getDescription() {
      if (_isPrivateDialog) {
        return "Create group chat";
      } else {
        return "Create private chat";
      }
    }

    return new Container(
      alignment: Alignment.centerLeft,
      child: FlatButton.icon(
        icon: Icon(
          getIcon(),
          size: 25.0,
          color: themeColor,
        ),
        onPressed: () {
          setState(() {
            _isPrivateDialog = !_isPrivateDialog;
          });
        },
        label: Text(getDescription()),
      ),
    );
  }

  Widget _getUsersList(BuildContext context) {
    clearValues() {
      _isUsersContinues = false;
      userToSearch = null;
      userMsg = " ";
      userList.clear();
    }

    if (_isUsersContinues) {
      if (userToSearch != null && userToSearch.isNotEmpty) {
        getUsersByFullName(userToSearch).then((users) {
          log("getusers: $users", TAG);
          setState(() {
            clearValues();
            userList.addAll(users.items);
          });
        }).catchError((onError) {
          log("getusers catchError: $onError", TAG);
          setState(() {
            clearValues();
            userMsg = "Couldn't find user";
          });
        });
      }
    }
    if (userList.isEmpty)
      return Center(
        child: Container(
          child: Text(
            userMsg,
            style: TextStyle(fontSize: 20),
          ),
        ),
      );
    else
      return ListView.builder(
        shrinkWrap: true,
        itemCount: userList.length,
        itemBuilder: _getListItemTile,
      );
  }

  Widget _getListItemTile(BuildContext context, int index) {
    getPrivateWidget() {
      return Container(
        child: FlatButton(
          child: Row(
            children: <Widget>[
              Material(
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    backgroundImage: userList[index].avatar != null &&
                            userList[index].avatar.isNotEmpty
                        ? NetworkImage(userList[index].avatar)
                        : null,
                    radius: 25,
                    child: getAvatarTextWidget(
                        userList[index].avatar != null &&
                            userList[index].avatar.isNotEmpty,
                        userList[index].fullName.substring(0, 2).toUpperCase()),
                  ),
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(40.0),
                ),
                clipBehavior: Clip.hardEdge,
              ),
              Flexible(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Text(
                          '${userList[index].fullName}',
                          style: TextStyle(color: Colors.black),
                        ),
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 5.0),
                      ),
                    ],
                  ),
                  margin: EdgeInsets.only(left: 20.0),
                ),
              ),
              Container(
                child: Icon(
                  Icons.arrow_forward,
                  size: 25.0,
                  color: themeColor,
                ),
              ),
            ],
          ),
          onPressed: () {
            String fullName = userList[index].fullName;
            _createDialog(context, {userList[index].id}, false, fullName);
          },
          // color: greyColor2,
          color: _darkTheme ? greyColor3 : greyColor2,
          padding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        margin: EdgeInsets.only(bottom: 10.0, left: 5.0, right: 5.0),
      );
    }

    getGroupWidget() {
      return Container(
        child: FlatButton(
          child: Row(
            children: <Widget>[
              Material(
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    backgroundImage: userList[index].avatar != null &&
                            userList[index].avatar.isNotEmpty
                        ? NetworkImage(userList[index].avatar)
                        : null,
                    radius: 25,
                    child: getAvatarTextWidget(
                        userList[index].avatar != null &&
                            userList[index].avatar.isNotEmpty,
                        userList[index].fullName.substring(0, 2).toUpperCase()),
                  ),
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(40.0),
                ),
                clipBehavior: Clip.hardEdge,
              ),
              Flexible(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Text(
                          '${userList[index].fullName}',
                          style: TextStyle(color: primaryColor),
                        ),
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 5.0),
                      ),
                    ],
                  ),
                  margin: EdgeInsets.only(left: 20.0),
                ),
              ),
              Container(
                child: Checkbox(
                  value: _selectedUsers.contains(userList[index].id),
                  onChanged: ((checked) {
                    setState(() {
                      if (checked) {
                        _selectedUsers.add(userList[index].id);
                        selectedUserList.add(userList[index]);
                      } else {
                        _selectedUsers.remove(userList[index].id);
                        selectedUserList.remove(userList[index]);
                      }
                      print('GROUPUSER $_selectedUsers');
                      print('GROUPUSER $selectedUserList');
                    });
                  }),
                ),
              ),
            ],
          ),
          onPressed: () {
            setState(() {
              print('sunish_prssed');
              if (_selectedUsers.contains(userList[index].id)) {
                _selectedUsers.remove(userList[index].id);
                selectedUserList.remove(userList[index]);
              } else {
                _selectedUsers.add(userList[index].id);
                selectedUserList.add(userList[index]);
              }
            });
          },
          // color: greyColor2,
          color: _darkTheme ? greyColor3 : greyColor2,
          padding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        margin: EdgeInsets.only(bottom: 10.0, left: 2.0, right: 2.0),
      );
    }

    getItemWidget() {
      if (_isPrivateDialog) {
        return getPrivateWidget();
      } else {
        return getGroupWidget();
      }
    }

    return getItemWidget();
  }

  void _createDialog(
      BuildContext context, Set<int> users, bool isGroup, String name) async {
    log("_createDialog with users= $users");
    if (isGroup) {
      CubeDialog newDialog =
          CubeDialog(CubeDialogType.GROUP, occupantsIds: users.toList());
      List<CubeUser> usersToAdd = users
          .map((id) => selectedUserList.firstWhere((user) => user.id == id,
              orElse: () => null))
          .toList();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              NewGroupDialogScreen(currentUser, newDialog, usersToAdd),
        ),
      );
    } else {
      _isDialogContinues = true;
      CubeDialog newDialog =
          CubeDialog(CubeDialogType.PRIVATE, occupantsIds: users.toList());
      createDialog(newDialog).then((createdDialog) {
        print('Nameuser ${createdDialog.name}');
        print('Nameuser ${createdDialog.id}');

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ChatDialogScreen(currentUser, createdDialog, false, name),
          ),
        );
        // ApiBaseHelper _api = ApiBaseHelper();
        // _api.chatByUser('${users.first}',createdDialog.dialogId).then((value) {
        // }).catchError((e) {
        // });
      }).catchError(_processCreateDialogError);
    } // setLoading();
  }

  void _processCreateDialogError(exception) {
    log("Login error $exception", TAG);
    setState(() {
      _isDialogContinues = false;
    });
    showDialogError(exception, context);
  }

  @override
  void initState() {
    super.initState();
    log("initState");
  }
}
