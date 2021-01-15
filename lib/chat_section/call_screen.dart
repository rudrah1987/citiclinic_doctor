import 'package:flutter/material.dart';

import 'package:connectycube_sdk/connectycube_sdk.dart';

import '../main.dart';

class IncomingCallScreen extends StatelessWidget {
  static const String TAG = "IncomingCallScreen";
  final P2PSession _callSession;
  String name;

  IncomingCallScreen(this._callSession,this.name);

  @override
  Widget build(BuildContext context) {
    _callSession.onSessionClosed = (callSession) {
      log("_onSessionClosed", TAG);
      Navigator.pop(context);
    };
    return WillPopScope(
        onWillPop: () => _onBackPressed(context),
        child: Scaffold(
            body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(36),
                child: Text(_getCallTitle(), style: TextStyle(fontSize: 28)),
              ),
              // Padding(
              //   padding: EdgeInsets.only(top: 36, bottom: 8),
              //   child: Text("Members:", style: TextStyle(fontSize: 20)),
              // ),
              Padding(
                padding: EdgeInsets.only(bottom: 86),
                child: Text(name??_callSession.opponentsIds,
                    style: TextStyle(fontSize: 18)),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 36),
                    child: FloatingActionButton(
                      heroTag: "RejectCall",
                      child: Icon(
                        Icons.call_end,
                        color: Colors.white,
                      ),
                      backgroundColor: Colors.red,
                      onPressed: () => _rejectCall(context, _callSession),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 36),
                    child: FloatingActionButton(
                      heroTag: "AcceptCall",
                      child: Icon(
                        Icons.call,
                        color: Colors.white,
                      ),
                      backgroundColor: Colors.green,
                      onPressed: () => _acceptCall(context, _callSession,name),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )));
  }

  _getCallTitle() {
    String callType;

    switch (_callSession.callType) {
      case CallType.VIDEO_CALL:
        callType = "Video";
        break;
      case CallType.AUDIO_CALL:
        callType = "Audio";
        break;
    }

    return "Incoming $callType call";
  }

  void _acceptCall(BuildContext context, P2PSession callSession,String name) {
    Map<String, String> userInfo = {};
    userInfo.putIfAbsent('name', () => name);


    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ConversationCallScreen(callSession, true,"",userInfo),
      ),
    );
  }

  void _rejectCall(BuildContext context, P2PSession callSession) {
    callSession.reject();
  }


  Future<bool> _onBackPressed(BuildContext context) {
    return Future.value(false);
  }
}

class ConversationCallScreen extends StatefulWidget {
  final P2PSession _callSession;
  final bool _isIncoming;
  final String opponantName;
  final Map<String, String> userInfo;



  @override
  State<StatefulWidget> createState() {
    return _ConversationCallScreenState(_callSession, _isIncoming);
  }

  ConversationCallScreen(this._callSession, this._isIncoming, this.opponantName,this.userInfo);
}

class _ConversationCallScreenState extends State<ConversationCallScreen>
    implements RTCSessionStateCallback<P2PSession> {
  static const String TAG = "_ConversationCallScreenState";
  P2PSession _callSession;
  bool _isIncoming;
  bool _isCameraEnabled = true;
  bool _isSpeakerEnabled = true;
  bool _isMicMute = false;
  String name;

  Map<int, RTCVideoRenderer> streams = {};

  _ConversationCallScreenState(this._callSession, this._isIncoming);

  @override
  void initState() {
    super.initState();

    _callSession.onLocalStreamReceived = _addLocalMediaStream;
    _callSession.onRemoteStreamReceived = _addRemoteMediaStream;
    _callSession.onSessionClosed = _onSessionClosed;

    Map<String, String> userInfo = widget.userInfo;
    name = userInfo["name"];

    // print('userinfo11 ${widget.userInfo}');
    _callSession.setSessionCallbacksListener(this);
    if (_isIncoming) {
      _callSession.acceptCall(widget.userInfo);
    } else {
      _callSession.startCall(widget.userInfo);
    }
  }

  @override
  void dispose() {
    super.dispose();
    streams.forEach((opponentId, stream) async {
      log("[dispose] dispose renderer for $opponentId", TAG);
      await stream.dispose();
    });
  }

  void _addLocalMediaStream(MediaStream stream) {
    log("_addLocalMediaStream", TAG);
    _onStreamAdd(CubeChatConnection.instance.currentUser.id, stream);
  }

  void _addRemoteMediaStream(session, int userId, MediaStream stream) {
    log("_addRemoteMediaStream for user $userId", TAG);
    _onStreamAdd(userId, stream);
  }

  void _removeMediaStream(callSession, int userId) {
    log("_removeMediaStream for user $userId", TAG);
    RTCVideoRenderer videoRenderer = streams[userId];
    if (videoRenderer == null) return;

    videoRenderer.srcObject = null;
    videoRenderer.dispose();

    setState(() {
      streams.remove(userId);
    });
  }

  void _onSessionClosed(session) {
    log("_onSessionClosed", TAG);
    _callSession.removeSessionCallbacksListener();

    navigatorKey.currentState.pop();
  }

  void _onStreamAdd(int opponentId, MediaStream stream) async {
    log("_onStreamAdd for user $opponentId", TAG);

    RTCVideoRenderer streamRender = RTCVideoRenderer();
    await streamRender.initialize();
    streamRender.srcObject = stream;
    setState(() => streams[opponentId] = streamRender);
  }

  List<Widget> renderStreamsGrid(Orientation orientation) {
    List<Widget> streamsExpanded = streams.entries
        .map(
          (entry) => Expanded(
            child: RTCVideoView(
              entry.value,
              objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
              mirror: true,
            ),
          ),
        )
        .toList();
    if (streams.length > 2) {
      List<Widget> rows = [];

      for (var i = 0; i < streamsExpanded.length; i += 2) {
        var chunkEndIndex = i + 2;

        if (streamsExpanded.length < chunkEndIndex) {
          chunkEndIndex = streamsExpanded.length;
        }

        var chunk = streamsExpanded.sublist(i, chunkEndIndex);

        rows.add(
          Expanded(
            child: orientation == Orientation.portrait
                ? Row(children: chunk)
                : Column(children: chunk),
          ),
        );
      }

      return rows;
    }

    return streamsExpanded;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onBackPressed(context),
      child: Stack(
        children: [
          Scaffold(
              body: _isVideoCall()
                  ? OrientationBuilder(
                      builder: (context, orientation) {
                        return Center(
                          child: Container(
                            child: orientation == Orientation.portrait
                                ? Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: renderStreamsGrid(orientation))
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: renderStreamsGrid(orientation)),
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(bottom: 24),
                            child: Text(
                              "Audio call",
                              style: TextStyle(fontSize: 28),
                            ),
                          ),
                          // Padding(
                          //   padding: EdgeInsets.only(bottom: 12),
                          //   child: Text(
                          //     "Members:",
                          //     style: TextStyle(
                          //         fontSize: 20, fontStyle: FontStyle.italic),
                          //   ),
                          // ),
                          Text(
                            widget.opponantName.isEmpty?name:widget.opponantName,
                            // _callSession.opponentsIds.join(", "),
                            // Application.cUser,
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    )),
          Align(
            alignment: Alignment.bottomCenter,
            child: _getActionsPanel(),
          ),
        ],
      ),
    );
  }

  Widget _getActionsPanel() {
    return Container(
      margin: EdgeInsets.only(bottom: 16, left: 8, right: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(32),
            bottomRight: Radius.circular(32),
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32)),
        child: Container(
          padding: EdgeInsets.all(4),
          color: Colors.black26,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 4),
                child: FloatingActionButton(
                  elevation: 0,
                  heroTag: "Mute",
                  child: Icon(
                    Icons.mic,
                    color: _isMicMute ? Colors.grey : Colors.white,
                  ),
                  onPressed: () => _muteMic(),
                  backgroundColor: Colors.black38,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 4),
                child: FloatingActionButton(
                  elevation: 0,
                  heroTag: "Speacker",
                  child: Icon(
                    Icons.volume_up,
                    color: _isSpeakerEnabled ? Colors.white : Colors.grey,
                  ),
                  onPressed: () => _switchSpeaker(),
                  backgroundColor: Colors.black38,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 4),
                child: FloatingActionButton(
                  elevation: 0,
                  heroTag: "SwitchCamera",
                  child: Icon(
                    Icons.switch_video,
                    color: _isVideoEnabled() ? Colors.white : Colors.grey,
                  ),
                  onPressed: () => _switchCamera(),
                  backgroundColor: Colors.black38,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 4),
                child: FloatingActionButton(
                  elevation: 0,
                  heroTag: "ToggleCamera",
                  child: Icon(
                    Icons.videocam,
                    color: _isVideoEnabled() ? Colors.white : Colors.grey,
                  ),
                  onPressed: () => _toggleCamera(),
                  backgroundColor: Colors.black38,
                ),
              ),
              Expanded(
                child: SizedBox(),
                flex: 1,
              ),
              Padding(
                padding: EdgeInsets.only(left: 0),
                child: FloatingActionButton(
                  child: Icon(
                    Icons.call_end,
                    color: Colors.white,
                  ),
                  backgroundColor: Colors.red,
                  onPressed: () => _endCall(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _endCall() {
    print("endCall");
    _callSession.hungUp();
    sendRingerPushNotification("Application.cUser","Missed ${_callSession.callType == CallType.VIDEO_CALL? "Video":"Audio"} Call");
  }

  void sendRingerPushNotification(String userName,String message) {
    bool isProduction = bool.fromEnvironment('dart.vm.product');
    print("endCall");

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
    if(_callSession.opponentsIds.last == _callSession.callerId){
      _selectedUsers=_callSession.opponentsIds.first;
    }else {
      _selectedUsers=_callSession.opponentsIds.last;
    }

    params.notificationType = NotificationType.PUSH;
    params.environment = isProduction ? CubeEnvironment.PRODUCTION : CubeEnvironment.DEVELOPMENT;
    params.usersIds = [_callSession.callerId, _selectedUsers];

    createEvent(params.getEventForRequest())
        .then((cubeEvent) {})
        .catchError((error) {});
  }

  Future<bool> _onBackPressed(BuildContext context) {
    return Future.value(false);
  }

  _muteMic() {
    setState(() {
      _isMicMute = !_isMicMute;
      _callSession.setMicrophoneMute(_isMicMute);
    });
  }

  _switchCamera() {
    if (!_isVideoEnabled()) return;

    _callSession.switchCamera();
  }

  _toggleCamera() {
    if (!_isVideoCall()) return;

    setState(() {
      _isCameraEnabled = !_isCameraEnabled;
      _callSession.setVideoEnabled(_isCameraEnabled);
    });
  }

  bool _isVideoEnabled() {
    return _isVideoCall() && _isCameraEnabled;
  }

  bool _isVideoCall() {
    return CallType.VIDEO_CALL == _callSession.callType;
  }

  _switchSpeaker() {
    setState(() {
      _isSpeakerEnabled = !_isSpeakerEnabled;
      _callSession.enableSpeakerphone(_isSpeakerEnabled);
    });
  }

  @override
  void onConnectedToUser(P2PSession session, int userId) {
    log("onConnectedToUser userId= $userId");
  }

  @override
  void onConnectionClosedForUser(P2PSession session, int userId) {
    log("onConnectionClosedForUser userId= $userId");
    _removeMediaStream(session, userId);
  }

  @override
  void onDisconnectedFromUser(P2PSession session, int userId) {
    log("onDisconnectedFromUser userId= $userId");
  }
}
