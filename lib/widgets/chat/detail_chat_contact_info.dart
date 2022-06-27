import 'package:flutter/material.dart';
import 'package:pet_integrated/common/empty_widget.dart';

import 'package:pet_integrated/utils/theme.dart';

class DetailContactInfo extends StatefulWidget {
  var chat;
  var post;
  var user;
  var sendMessage;

  bool isOwner;
  DetailContactInfo(
      {Key? key,
      required this.chat,
      required this.post,
      required this.user,
      required this.sendMessage,
      required this.isOwner})
      : super(key: key);

  @override
  State<DetailContactInfo> createState() => _DetailContactInfoState();
}

class _DetailContactInfoState extends State<DetailContactInfo> {
  String _btnMessage = '';
  String? _adoptStatus;
  bool _loading = true;
  bool _isOwner = false;

  _submitAdoptButton({String? option}) {
    //  'DEFAULT_MESSAGE',
    //  'CONFIRM_ADOPT',
    //  'REQUEST_ADOPT',
    //  'CANCEL_REQUEST_ADOPT',
    //  'REJECT_ADOPT',

    var computedButtonMessagesOwner = {
      "Idle": "DEFAULT_MESSAGE",
      "Cancel confirm": "CANCEL_CONFIRM",
      "Confirm adopt": "CONFIRM_ADOPT",
      "Reject adopt": "REJECT_ADOPT",
    };

    var computedButtonMessagesGuest = {
      "Request adopt": "REQUEST_ADOPT",
      "Cancel confirm": "CANCEL_CONFIRM",
      "Cancel request": "CANCEL_REQUEST_ADOPT",
    };
    String messageType;
    print(widget.isOwner);
    print(computedButtonMessagesOwner[_btnMessage]);
    if (widget.isOwner) {
      messageType = computedButtonMessagesOwner[_btnMessage]!;
    } else {
      messageType = computedButtonMessagesGuest[_btnMessage]!;
    }

    if (option != null) {
      messageType = option;
    }
    if (_btnMessage != "Idle") {
      widget.sendMessage(messageType);
    }

    var computedAdoptStatusState = {
      "Idle": "IDLE",
      "Cancel confirm": "IDLE",
      "Confirm adopt": "CONFIRMED",
      "Reject adopt": "IDLE",
      "Request adopt": "REQUESTED",
      "Cancel request": "IDLE",
    };

    setState(() {
      _adoptStatus = computedAdoptStatusState[_btnMessage.toString()];
    });
    _computedActionButton();
  }

  _computedActionButton() async {
    setState(() {
      _loading = true;
    });
    // print(_loading);
    var computedButtonMessagesOwner = {
      "IDLE": "Idle",
      "CONFIRMED": "Cancel confirm",
      "REQUESTED": "Options",
    };
    var computedButtonMessagesGuest = {
      "IDLE": "Request adopt",
      "CONFIRMED": "Request to cancel confirm",
      "REQUESTED": "Cancel request",
    };

    if (widget.chat != null) {
      if (widget.isOwner) {
        setState(() {
          _btnMessage = computedButtonMessagesOwner[_adoptStatus].toString();
        });
      } else {
        setState(() {
          _btnMessage = computedButtonMessagesGuest[_adoptStatus].toString();
        });
      }
    } else {
      if (widget.isOwner) {
        setState(() {
          _btnMessage = 'Idle';
        });
      } else {
        setState(() {
          _btnMessage = 'Request adopt';
        });
      }
    }

    // print(_adoptStatus);
    // print(_btnMessage);
    setState(() {
      _loading = false;
    });
    //  print(_loading);
  }

  _initialData() {
    _isOwner = widget.isOwner;
    _adoptStatus = widget.chat?['adoptStatus'];
    _loading = false;
    _computedActionButton();
  }

  @override
  void initState() {
    super.initState();
    _initialData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return !_loading
        ? Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: _getImageComputed(),
                ),
                Flexible(
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 4),
                              child: Text("${widget.post['petName']}",
                                  style: AppTheme.style.titleFontStyle
                                      .copyWith(color: Colors.white)),
                            ),
                            _buttonComputed()
                          ],
                        ),
                        Row(
                          children: [
                            _getAvatarComputed(),
                            Flexible(
                              child: Container(
                                margin: EdgeInsets.only(left: 4),
                                child: Text(
                                  widget.user?['firstName'],
                                  style: AppTheme.style.primaryFontStyle,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
              // children: [Text('${message.name}')],
            ),
          )
        : Container();
  }

  _buttonComputed() {
    if (widget.isOwner && _btnMessage == 'Options') {
      return _buildOptionButtonForOwner();
    }
    return Container(
      padding: EdgeInsets.only(right: 8, left: 8, top: 4, bottom: 4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: AppTheme.colors.pink),
      child: GestureDetector(
          onTap: () {
            _submitAdoptButton();
          },
          child: Text(
            _btnMessage,
            style:
                AppTheme.style.primaryFontStyle.copyWith(color: Colors.white),
          )),
    );
  }

  _buildOptionButtonForOwner() {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(right: 8, left: 8, top: 4, bottom: 4),
          padding: EdgeInsets.only(right: 8, left: 8, top: 4, bottom: 4),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppTheme.colors.pink),
          child: GestureDetector(
              onTap: () {
                _submitAdoptButton(option: "Confirm adopt");
              },
              child: Text(
                _btnMessage,
                style: AppTheme.style.primaryFontStyle
                    .copyWith(color: Colors.white),
              )),
        ),
        Container(
          padding: EdgeInsets.only(right: 8, left: 8, top: 4, bottom: 4),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppTheme.colors.pink),
          child: GestureDetector(
              onTap: () {
                _submitAdoptButton(option: "Reject adopt");
              },
              child: Text(
                _btnMessage,
                style: AppTheme.style.primaryFontStyle
                    .copyWith(color: Colors.white),
              )),
        ),
      ],
    );
  }

  _getImageComputed() {
    if (widget.post?['images']?[0] == null) {
      return Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Image.asset(
          AppTheme.src.astroCat,
          width: 60,
          height: 60,
        ),
      );
    }
    return Image.network(
      widget.post?['images']?[0],
      width: 60,
      height: 60,
    );
  }

  _getAvatarComputed() {
    if (widget.user?['imageUrl'] != null) {
      return CircleAvatar(
        radius: 12,
        backgroundImage: NetworkImage("${widget.user?['imageUrl']}"),
        backgroundColor: Colors.white,
      );
    }
    return CircleAvatar(
      radius: 12,
      child: Icon(
        Icons.person,
        size: 16,
        color: AppTheme.colors.darkFontColor,
      ),
      backgroundColor: AppTheme.colors.notWhite,
    );
  }
}
