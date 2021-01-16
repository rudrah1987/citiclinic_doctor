import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:city_clinic_doctor/chat_section/widgets/full_photo.dart';
import 'package:city_clinic_doctor/new/utils/prefrence_helper.dart';
import 'package:connectycube_sdk/connectycube_calls.dart';
import 'package:connectycube_sdk/connectycube_chat.dart';
import 'package:connectycube_sdk/connectycube_pushnotifications.dart';
import 'package:connectycube_sdk/connectycube_storage.dart';
import 'package:connectycube_sdk/src/chat/models/message_status_model.dart';
import 'package:connectycube_sdk/src/chat/models/typing_status_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../network/result_state.dart';
import 'call_screen.dart';
import 'chat_details_screen.dart';
import 'utils/consts.dart';
import 'widgets/common.dart';

var _darkTheme = true;


class ChatDialogScreen extends StatefulWidget {
  final CubeUser _cubeUser;
  CubeDialog _cubeDialog;
  bool fromSearch;
  String name;


  ChatDialogScreen(this._cubeUser, this._cubeDialog, this.fromSearch, this.name);

  @override
  _ChatDialogScreenState createState() => _ChatDialogScreenState();
}

class _ChatDialogScreenState extends State<ChatDialogScreen> {
  P2PClient _callClient;

  P2PSession _currentCall;

  Set<int> _selectedUsers;
  String background;

  @override
  void initState() {
    _selectedUsers = {};
    _initCustomMediaConfigs();
    _initCalls();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color _backgroundColor = Colors.transparent;

    if (widget._cubeDialog.occupantsIds.last == widget._cubeUser.id) {
      _selectedUsers.add(widget._cubeDialog.occupantsIds.first);
    } else {
      _selectedUsers.add(widget._cubeDialog.occupantsIds.last);
    }

    print("_openDialog   ${widget._cubeDialog.occupantsIds.last}");
    print(_selectedUsers);
    print('FullName ${widget.name}');
    print('FullName ${widget._cubeDialog.name}');

    String opponantName = widget.fromSearch ? (widget.name!=null? widget.name:'') : (widget._cubeDialog.name!=null? widget._cubeDialog.name:widget.name);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.fromSearch ? (widget.name!=null? widget.name:'') : (widget._cubeDialog.name!=null? widget._cubeDialog.name:widget.name),
        ),
        centerTitle: false,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back)),
        actions: <Widget>[
          widget._cubeDialog.type == 2
              ? Container()
              : IconButton(
                  onPressed: () =>
                      _startCall(CallType.VIDEO_CALL, _selectedUsers,opponantName),
                  icon: Icon(
                    Icons.videocam,
//                    color: Colors.white,
                  ),
                ),
          widget._cubeDialog.type == 2
              ? Container()
              : IconButton(
                  onPressed: () =>
                      _startCall(CallType.AUDIO_CALL, _selectedUsers,opponantName),
                  icon: Icon(
                    Icons.call,
//                    color: Colors.white,
                  ),
                ),
        ],
      ),
      body: SafeArea(
        child: Container(
            decoration: BoxDecoration(
              color: _backgroundColor,
              image: (background!=null && background.contains('/'))
                  ? DecorationImage(
                image: FileImage(File(background)),
                fit: BoxFit.fill,
              )
                  : null,
            ),
            child: ChatScreen(widget._cubeUser, widget._cubeDialog)
        ),
      ),
    );
  }

  _chatDetails(BuildContext context) async {
    log("_chatDetails= ${widget._cubeDialog}");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ChatDetailsScreen(widget._cubeUser, widget._cubeDialog),
      ),
    );
  }

  void _initCalls() {
    _callClient = P2PClient.instance;

    _callClient.init();

    _callClient.onReceiveNewSession = (callSession) {
      if (_currentCall != null &&
          _currentCall.sessionId != callSession.sessionId) {
        print('1111111111stoopup11111111111reject');
        print(callSession.callerId);
        print(callSession.sessionId);
        print('aaa ${callSession.sessionId}');
        callSession.reject();
        return;
      }

      Map<String, String> userInfo = callSession.cubeSdp.userInfo;
      var name = userInfo["name"];
      print('useInfo $userInfo');
      print('useInfo $name');

      _showIncomingCallScreen(callSession,name);
    };

    _callClient.onSessionClosed = (callSession) {
      if (_currentCall != null &&
          _currentCall.sessionId == callSession.sessionId) {
        _currentCall = null;
      }
    };
  }

  void _startCall(int callType, Set<int> opponents,String opponantName) {
    if (opponents.isEmpty) return;

    Map<String, String> userInfo = {};
    userInfo.putIfAbsent('name', () => '${widget._cubeUser.fullName}');


    P2PSession callSession = _callClient.createCallSession(callType, opponents);
    _currentCall = callSession;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ConversationCallScreen(callSession, false,opponantName,userInfo),
      ),
    );
    sendRingerPushNotification(widget._cubeUser.fullName, "Incoming Call");
  }

  void sendRingerPushNotification(String userName, String message) {
    bool isProduction = bool.fromEnvironment('dart.vm.product');

    CreateEventParams params = CreateEventParams();
    params.parameters = {
      'message': message, // 'message' field is required
      'click_action': "FLUTTER_NOTIFICATION_CLICK",
      'body': userName,
      'isVideo': '1',
      'ios_voip': 1 // to send VoIP push notification to iOS
      //more standard parameters you can found by link https://developers.connectycube.com/server/push_notifications?id=universal-push-notifications
    };

    int _selectedUsers;
    if (widget._cubeDialog.occupantsIds.last == widget._cubeUser.id) {
      _selectedUsers = widget._cubeDialog.occupantsIds.first;
    } else {
      _selectedUsers = widget._cubeDialog.occupantsIds.last;
    }

    params.notificationType = NotificationType.PUSH;
    params.environment =
        isProduction ? CubeEnvironment.PRODUCTION : CubeEnvironment.DEVELOPMENT;
    params.usersIds = [widget._cubeUser.id, _selectedUsers];

    createEvent(params.getEventForRequest())
        .then((cubeEvent) {})
        .catchError((error) {});
  }

  void _showIncomingCallScreen(P2PSession callSession,String name) {
    // print(callSession.callerId);
    // print(callSession.sessionId);

    navigatorKey.currentState.push(
      MaterialPageRoute(
        builder: (context) => IncomingCallScreen(callSession,name),
      ),
    );
  }

  void _initCustomMediaConfigs() {
    RTCMediaConfig mediaConfig = RTCMediaConfig.instance;
    mediaConfig.minHeight = 720;
    mediaConfig.minWidth = 1280;
    mediaConfig.minFrameRate = 30;
  }
}

class ChatScreen extends StatefulWidget {
  static const String TAG = "_CreateChatScreenState";
  final CubeUser _cubeUser;
  final CubeDialog _cubeDialog;

  ChatScreen(this._cubeUser, this._cubeDialog);

  @override
  State createState() => ChatScreenState(_cubeUser, _cubeDialog);
}

class ChatScreenState extends State<ChatScreen> {
  final CubeUser _cubeUser;
  final CubeDialog _cubeDialog;
  final Map<int, CubeUser> _occupants = Map();

  File imageFile;
  final picker = ImagePicker();
  bool isLoading;
  String imageUrl;
  List<CubeMessage> listMessage;
  Timer typingTimer;
  bool isTyping = false;
  String userStatus = '';

  final TextEditingController textEditingController = TextEditingController();
  final ScrollController listScrollController = ScrollController();
  final FocusNode focusNode = FocusNode();
  final ChatMessagesManager chatMessagesManager =
      CubeChatConnection.instance.chatMessagesManager;

  final MessagesStatusesManager statusesManager =
      CubeChatConnection.instance.messagesStatusesManager;

  final TypingStatusesManager typingStatusesManager =
      CubeChatConnection.instance.typingStatusesManager;

  StreamSubscription<CubeMessage> msgSubscription;
  StreamSubscription<MessageStatus> deliveredSubscription;
  StreamSubscription<MessageStatus> readSubscription;
  StreamSubscription<TypingStatus> typingSubscription;

  ChatScreenState(this._cubeUser, this._cubeDialog);

  @override
  void initState() {
    super.initState();
    focusNode.addListener(onFocusChange);
    msgSubscription =
        chatMessagesManager.chatMessagesStream.listen(onReceiveMessage);
    deliveredSubscription =
        statusesManager.deliveredStream.listen(onDeliveredMessage);
    readSubscription = statusesManager.readStream.listen(onReadMessage);
    typingSubscription =
        typingStatusesManager.isTypingStream.listen(onTypingMessage);

    isLoading = false;
    imageUrl = '';
  }

  @override
  void dispose() {
    msgSubscription.cancel();
    deliveredSubscription.cancel();
    readSubscription.cancel();
    typingSubscription.cancel();
    textEditingController.dispose();
    super.dispose();
  }

  void onFocusChange() {
    if (focusNode.hasFocus) {}
  }

  void openGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile == null) return;
    setState(() {
      isLoading = true;
    });
    imageFile = File(pickedFile.path);
    uploadImageFile();
  }

  Future uploadImageFile() async {
    uploadFile(imageFile, true).then((cubeFile) {
      var url = cubeFile.getPublicUrl();
      onSendChatAttachment(url);
    }).catchError((ex) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(msg: 'This file is not an image');
    });
  }

  void onReceiveMessage(CubeMessage message) {
    log("onReceiveMessage message= $message");
    if (message.dialogId != _cubeDialog.dialogId ||
        message.senderId == _cubeUser.id) return;
    _cubeDialog.readMessage(message);
    addMessageToListView(message);
  }

  void onDeliveredMessage(MessageStatus status) {
    log("onDeliveredMessage message= $status");
    updateReadDeliveredStatusMessage(status, false);
  }

  void onReadMessage(MessageStatus status) {
    log("onReadMessage message= ${status.messageId}");
    updateReadDeliveredStatusMessage(status, true);
  }

  void onTypingMessage(TypingStatus status) {
    log("TypingStatus message= ${status.userId}");
    if (status.userId == _cubeUser.id ||
        (status.dialogId != null && status.dialogId != _cubeDialog.dialogId))
      return;
    userStatus = _occupants[status.userId]?.fullName ??
        _occupants[status.userId]?.login ??
        '';
    if (userStatus.isEmpty) return;
    userStatus = "$userStatus is typing ...";

    if (isTyping != true) {
      setState(() {
        isTyping = true;
      });
    }
    startTypingTimer();
  }

  startTypingTimer() {
    typingTimer?.cancel();
    typingTimer = Timer(Duration(milliseconds: 900), () {
      setState(() {
        isTyping = false;
      });
    });
  }

  void onSendChatMessage(String content) {
    if (content.trim() != '') {
      final message = createCubeMsg();
      message.body = content.trim();
      onSendMessage(message);
    } else {
      Fluttertoast.showToast(msg: 'Nothing to send');
    }
  }

  void onSendChatAttachment(String url) async {
    var decodedImage = await decodeImageFromList(imageFile.readAsBytesSync());

    final attachment = CubeAttachment();
    attachment.id = imageFile.hashCode.toString();
    attachment.type = CubeAttachmentType.IMAGE_TYPE;
    attachment.url = url;
    attachment.height = decodedImage.height;
    attachment.width = decodedImage.width;
    final message = createCubeMsg();
    message.body = "Attachment";
    message.attachments = [attachment];
    onSendMessage(message);
  }

  CubeMessage createCubeMsg() {
    var message = CubeMessage();
    message.dateSent = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    message.markable = true;
    message.saveToHistory = true;
    return message;
  }

  void onSendMessage(CubeMessage message) async {
    log("onSendMessage message= $message");
    textEditingController.clear();
    await _cubeDialog.sendMessage(message);
    message.senderId = _cubeUser.id;
    addMessageToListView(message);
    listScrollController.animateTo(0.0,
        duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    sendPushNotification(_cubeUser.fullName, message.body);
  }

  updateReadDeliveredStatusMessage(MessageStatus status, bool isRead) {
    CubeMessage msg = listMessage.firstWhere(
        (msg) => msg.messageId == status.messageId,
        orElse: () => null);
    if (msg == null) return;
    if (isRead)
      msg.readIds == null
          ? msg.readIds = [status.userId]
          : msg.readIds?.add(status.userId);
    else
      msg.deliveredIds == null
          ? msg.deliveredIds = [status.userId]
          : msg.deliveredIds?.add(status.userId);
    setState(() {});
  }

  addMessageToListView(message) {
    setState(() {
      isLoading = false;
      listMessage.insert(0, message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            // List of messages
            buildListMessage(),
            //Typing content
            buildTyping(),
            // Input content
            buildInput(),
          ],
        ),

        // Loading
        buildLoading()
      ],
    // return Container(
    //   child: Stack(
    //     children: <Widget>[
    //       Column(
    //         children: <Widget>[
    //           // List of messages
    //           buildListMessage(),
    //           //Typing content
    //           buildTyping(),
    //           // Input content
    //           buildInput(),
    //         ],
    //       ), // Loading
    //       buildLoading()
    //     ],
    //   ),
    );
  }

  Widget buildItem(int index, CubeMessage message) {
    markAsReadIfNeed() {
      var isOpponentMsgRead =
          message.readIds != null && message.readIds.contains(_cubeUser.id);
      print(
          "markAsReadIfNeed message= ${message}, isOpponentMsgRead= $isOpponentMsgRead");
      if (message.senderId != _cubeUser.id && !isOpponentMsgRead) {
        if (message.readIds == null)
          message.readIds = [_cubeUser.id];
        else
          message.readIds.add(_cubeUser.id);
        _cubeDialog.readMessage(message);
      }
    }

    Widget getReadDeliveredWidget() {
      bool messageIsRead() {
        if (_cubeDialog.type == CubeDialogType.PRIVATE)
          return message.readIds != null &&
              (message.recipientId == null ||
                  message.readIds.contains(message.recipientId));
        return message.readIds != null &&
            message.readIds.any((int id) => _occupants.keys.contains(id));
      }

      bool messageIsDelivered() {
        if (_cubeDialog.type == CubeDialogType.PRIVATE)
          return message.deliveredIds?.contains(message.recipientId) ?? false;
        return message.deliveredIds != null &&
            message.deliveredIds.any((int id) => _occupants.keys.contains(id));
      }

      if (messageIsRead())
        return Stack(children: <Widget>[
          Icon(
            Icons.check,
            size: 15.0,
            color: blueColor,
          ),
          Padding(
            padding: EdgeInsets.only(left: 8),
            child: Icon(
              Icons.check,
              size: 15.0,
              color: blueColor,
            ),
          )
        ]);
      else if (messageIsDelivered()) {
        return Stack(children: <Widget>[
          Icon(
            Icons.check,
            size: 15.0,
            color: greyColor,
          ),
          Padding(
            padding: EdgeInsets.only(left: 8),
            child: Icon(
              Icons.check,
              size: 15.0,
              color: greyColor,
            ),
          )
        ]);
      } else {
        return Icon(
          Icons.check,
          size: 15.0,
          color: greyColor,
        );
      }
    }

    Widget getDateWidget() {
      return Text(
        DateFormat('HH:mm').format(
            DateTime.fromMillisecondsSinceEpoch(message.dateSent * 1000)),
        style: TextStyle(
            color: Colors.black,
            fontSize: 12.0,
            fontStyle: FontStyle.italic),
      );
    }

    Widget getHeaderDateWidget() {
      return Container(
        alignment: Alignment.center,
        child: Text(
          DateFormat('dd MMMM').format(
              DateTime.fromMillisecondsSinceEpoch(message.dateSent * 1000)),
          style: TextStyle(
              color:  Colors.black, fontSize: 18.0, fontStyle: FontStyle.italic),
        ),
        margin: EdgeInsets.all(10.0),
      );
    }

    bool isHeaderView() {
      int headerId = int.parse(DateFormat('ddMMyyyy').format(
          DateTime.fromMillisecondsSinceEpoch(message.dateSent * 1000)));
      if (index >= listMessage.length - 1) {
        return false;
      }
      var msgPrev = listMessage[index + 1];
      int nextItemHeaderId = int.parse(DateFormat('ddMMyyyy').format(
          DateTime.fromMillisecondsSinceEpoch(msgPrev.dateSent * 1000)));
      var result = headerId != nextItemHeaderId;
      return result;
    }

    if (message.senderId == _cubeUser.id) {
      // Right (own message)
      return Column(
        children: <Widget>[
          isHeaderView() ? getHeaderDateWidget() : SizedBox.shrink(),
          Row(
            children: <Widget>[
              message.attachments?.isNotEmpty ?? false
                  // Image
                  ? Container(
                      child: FlatButton(
                        child: Material(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                CachedNetworkImage(
                                  placeholder: (context, url) => Container(
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          themeColor),
                                    ),
                                    width: 150.0,
                                    height: 150.0,
                                    padding: EdgeInsets.all(70.0),
                                    decoration: BoxDecoration(
                                      color: greyColor2,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(8.0),
                                      ),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Material(
                                    child: Image.asset(
                                      'images/img_not_available.jpeg',
                                      width: 150.0,
                                      height: 150.0,
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8.0),
                                    ),
                                    clipBehavior: Clip.hardEdge,
                                  ),
                                  imageUrl: message.attachments.first.url,
                                  width: 150.0,
                                  height: 150.0,
                                  fit: BoxFit.cover,
                                ),
                                getDateWidget(),
                                getReadDeliveredWidget(),
                              ]),
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          clipBehavior: Clip.hardEdge,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FullPhoto(
                                      url: message.attachments.first.url)));
                        },
                        padding: EdgeInsets.all(0),
                      ),
                      margin: EdgeInsets.only(
                          bottom: isLastMessageRight(index) ? 20.0 : 10.0,
                          right: 10.0),
                    )
                  : message.body != null && message.body.isNotEmpty
                      // Text
                      ? Flexible(
                          child: Container(
                            padding:
                                EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                            decoration: BoxDecoration(
                                color: greyColor2,
                                borderRadius: BorderRadius.circular(8.0)),
                            margin: EdgeInsets.only(
                                bottom: isLastMessageRight(index) ? 20.0 : 10.0,
                                right: 10.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    message.body,
                                    style: TextStyle(color: primaryColor),
                                  ),
                                  Text(
                                    DateFormat('HH:mm').format(
                                        DateTime.fromMillisecondsSinceEpoch(message.dateSent * 1000)),
                                    style: TextStyle(
                                        color: primaryColor,
                                        fontSize: 12.0,
                                        fontStyle: FontStyle.italic),
                                  ),
                                  // getDateWidget(),
                                  getReadDeliveredWidget(),
                                ]),
                          ),
                        )
                      : Container(
                          child: Text(
                            "Empty",
                            style: TextStyle(color: primaryColor),
                          ),
                          padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                          width: 200.0,
                          decoration: BoxDecoration(
                              color: greyColor2,
                              borderRadius: BorderRadius.circular(8.0)),
                          margin: EdgeInsets.only(
                              bottom: isLastMessageRight(index) ? 20.0 : 10.0,
                              right: 10.0),
                        ),
            ],
            mainAxisAlignment: MainAxisAlignment.end,
          ),
        ],
      );
    } else {
      // Left (opponent message)
      markAsReadIfNeed();
      return Container(
        child: Column(
          children: <Widget>[
            isHeaderView() ? getHeaderDateWidget() : SizedBox.shrink(),
            Row(
              children: <Widget>[
                Material(
                  child: CircleAvatar(
                    backgroundImage:
                        _occupants[message.senderId].avatar != null &&
                                _occupants[message.senderId].avatar.isNotEmpty
                            ? NetworkImage(_occupants[message.senderId].avatar)
                            : null,
                    backgroundColor: greyColor2,
                    radius: 25,
                    child: getAvatarTextWidget(
                      _occupants[message.senderId].avatar != null &&
                          _occupants[message.senderId].avatar.isNotEmpty,
                      _occupants[message.senderId]
                          .fullName
                          .substring(0, 2)
                          .toUpperCase(),
                    ),
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(25.0),
                  ),
                  clipBehavior: Clip.hardEdge,
                ),
                message.attachments?.isNotEmpty ?? false
                    ? Container(
                        child: FlatButton(
                          child: Material(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CachedNetworkImage(
                                    placeholder: (context, url) => Container(
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                themeColor),
                                      ),
                                      width: 200.0,
                                      height: 200.0,
                                      padding: EdgeInsets.all(70.0),
                                      decoration: BoxDecoration(
                                        color: greyColor2,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8.0),
                                        ),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Material(
                                      child: Image.asset(
                                        'images/img_not_available.jpeg',
                                        width: 200.0,
                                        height: 200.0,
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(8.0),
                                      ),
                                      clipBehavior: Clip.hardEdge,
                                    ),
                                    imageUrl: message.attachments.first.url,
                                    width: 200.0,
                                    height: 200.0,
                                    fit: BoxFit.cover,
                                  ),
                                  getDateWidget(),
                                ]),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            clipBehavior: Clip.hardEdge,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FullPhoto(
                                        url: message.attachments.first.url)));
                          },
                          padding: EdgeInsets.all(0),
                        ),
                        margin: EdgeInsets.only(left: 10.0),
                      )
                    : message.body != null && message.body.isNotEmpty
                        ? Flexible(
                            child: Container(
                              padding:
                                  EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                              decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(8.0)),
                              margin: EdgeInsets.only(left: 10.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      message.body,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      DateFormat('HH:mm').format(
                                          DateTime.fromMillisecondsSinceEpoch(message.dateSent * 1000)),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.0,
                                          fontStyle: FontStyle.italic),
                                    ),
                                    // getDateWidget(),
                                  ]),
                            ),
                          )
                        : Container(
                            child: Text(
                              "Empty",
                              style: TextStyle(color: primaryColor),
                            ),
                            padding:
                                EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                            width: 200.0,
                            decoration: BoxDecoration(
                                color: greyColor2,
                                borderRadius: BorderRadius.circular(8.0)),
                            margin: EdgeInsets.only(
                                bottom: isLastMessageRight(index) ? 20.0 : 10.0,
                                right: 10.0),
                          ),
              ],
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        margin: EdgeInsets.only(bottom: 10.0),
      );
    }
  }

  bool isLastMessageLeft(int index) {
    if ((index > 0 &&
            listMessage != null &&
            listMessage[index - 1].id == _cubeUser.id) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }

  bool isLastMessageRight(int index) {
    if ((index > 0 &&
            listMessage != null &&
            listMessage[index - 1].id != _cubeUser.id) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }

  Widget buildLoading() {
    return Positioned(
      child: isLoading ? CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(themeColor),
      ) : Container(),
    );
  }

  Widget buildTyping() {
    return Visibility(
      visible: isTyping,
      child: Container(
        child: Text(
          userStatus,
          style: TextStyle(color: _darkTheme ? Colors.white : Colors.black,),
        ),
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.all(16.0),
      ),
    );
  }

  Widget buildInput() {
    return Container(
      child: Row(
        children: <Widget>[
          // Button send image
          Material(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 1.0),
              child: IconButton(
                icon: Icon(Icons.image),
                onPressed: () {
                  openGallery();
                },
                color: primaryColor,
              ),
            ),
            color: Colors.white,
          ),

          // Edit text
          Flexible(
            child: Container(
              child: TextField(
                style: TextStyle(color: primaryColor, fontSize: 15.0),
                controller: textEditingController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Type your message...',
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintStyle: TextStyle(color: greyColor),
                  // contentPadding: const EdgeInsets.symmetric(vertical: 40.0),
                ),
                focusNode: focusNode,
                onChanged: (text) {
                  _cubeDialog.sendIsTypingStatus();
                },
              ),
            ),
          ),

          // Button send message
          Material(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: () => onSendChatMessage(textEditingController.text),
                color: primaryColor,
              ),
            ),
            color: Colors.white,
          ),
        ],
      ),
      width: double.infinity,
      height: 50.0,
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: greyColor2, width: 0.5)),
          color: Colors.white),
    );
  }

  Widget buildListMessage() {
    getWidgetMessages(listMessage) {
      return ListView.builder(
        padding: EdgeInsets.all(10.0),
        itemBuilder: (context, index) => buildItem(index, listMessage[index]),
        itemCount: listMessage.length,
        reverse: true,
        controller: listScrollController,
      );
    }

    if (listMessage != null && listMessage.isNotEmpty) {
      return Flexible(child: getWidgetMessages(listMessage));
    }

    return Flexible(
      child: StreamBuilder(
        stream: getAllItems().asStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(themeColor)));
          } else {
            listMessage = snapshot.data;
            return getWidgetMessages(listMessage);
          }
        },
      ),
    );
  }

  Future<List<CubeMessage>> getAllItems() async {
    Completer<List<CubeMessage>> completer = Completer();
    List<CubeMessage> messages;
    var params = GetMessagesParameters();
    params.sorter = RequestSorter(SORT_DESC, '', 'date_sent');
    try {
      await Future.wait<void>([
        getMessages(_cubeDialog.dialogId, params.getRequestParameters())
            .then((result) => messages = result.items),
        getAllUsersByIds(_cubeDialog.occupantsIds.toSet()).then((result) =>
            _occupants.addAll(Map.fromIterable(result.items,
                key: (item) => item.id, value: (item) => item)))
      ]);
      completer.complete(messages);
    } catch (error) {
      completer.completeError(error);
    }
    return completer.future;
  }

  Future<bool> onBackPress() {
    Navigator.of(context).popUntil(ModalRoute.withName("/SelectDialogScreen"));
    return Future.value(false);
  }

  void sendPushNotification(String userName, String message) {
    bool isProduction = bool.fromEnvironment('dart.vm.product');

    CreateEventParams params = CreateEventParams();
    params.name = userName;
    params.parameters = {
      'message':"$message from $userName", // 'message' field is required
      'click_action': "FLUTTER_NOTIFICATION_CLICK",
      'body': userName,
      'isVideo': '0',
      'ios_voip': 1,
      'ios_sound':"lounge.wav",
      "ios_badge": 1,
      "title":userName,
      // to send VoIP push notification to iOS
      //more standard parameters you can found by link https://developers.connectycube.com/server/push_notifications?id=universal-push-notifications
    };

    int _selectedUsers;
    if (widget._cubeDialog.occupantsIds.last == widget._cubeUser.id) {
      _selectedUsers = widget._cubeDialog.occupantsIds.first;
    } else {
      _selectedUsers = widget._cubeDialog.occupantsIds.last;
    }

    params.notificationType = NotificationType.PUSH;
    params.environment =
        isProduction ? CubeEnvironment.PRODUCTION : CubeEnvironment.DEVELOPMENT;
    params.usersIds = [_cubeUser.id, _selectedUsers];

    createEvent(params.getEventForRequest())
        .then((cubeEvent) {})
        .catchError((error) {});
  }
}
