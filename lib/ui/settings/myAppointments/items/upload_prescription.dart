import 'dart:io';

import 'package:city_clinic_doctor/modal/apointmentList/apointmentListResponse.dart';
import 'package:city_clinic_doctor/network/api_provider.dart';
import 'package:city_clinic_doctor/new/constants/string_constants.dart';
import 'package:city_clinic_doctor/utils/Colors.dart';
import 'package:city_clinic_doctor/utils/Constant.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import '../../NotificationPage.dart';

class UploadPrescriptionPage extends StatefulWidget {
  final Patient patient;
  UploadPrescriptionPage(this.patient);

  @override
  _UploadPrescriptionPageState createState() => _UploadPrescriptionPageState();
}

TextEditingController _medicalDetailsCon = TextEditingController();
TextEditingController _otherDetailsCon = TextEditingController();
File _prescriptionFile;
final _formKey = GlobalKey<FormState>();
bool isSubmitting = false;

class _UploadPrescriptionPageState extends State<UploadPrescriptionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: kPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(14),
            ),
          ),
          title: Text("Upload Prescription"),
          elevation:
              defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
          centerTitle: false,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.notifications_none,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => NotificationPage()));
              },
            )
          ]),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 20),
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.network(
                        "$PROFILE_IMG_TESTING_BASE_PATH${widget.patient.profileImage}",
                        errorBuilder: (_, __, ___) {
                          return CircleAvatar(
                            radius: 30.0,
                            backgroundColor: kPrimaryColor,
                            child: Text(
                              "${widget.patient?.name[0]}",
                            ),
                          );
                        },
                        loadingBuilder: (_, __, ___) {
                          return CircleAvatar(
                            radius: 30.0,
                            backgroundColor: kPrimaryColor,
                            child: Text(
                              "${widget.patient?.name[0]}",
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.patient?.name ?? ''}',
                          style: TextStyle(fontFamily: tFontPoppins),
                        ),
                        Text(
                          'Age: ${getAge(widget.patient?.dob) ?? ''}',
                          style: TextStyle(
                              fontFamily: tFontPoppins, color: Colors.grey),
                        ),
                        Text(
                          'Gender: ${widget.patient?.gender ?? ''}',
                          style: TextStyle(
                              fontFamily: tFontPoppins, color: Colors.grey),
                        ),
                        Text(
                          'Mob No: ${widget.patient?.phoneNumber ?? ''}',
                          style: TextStyle(
                              fontFamily: tFontPoppins, color: Colors.grey),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    padding: EdgeInsets.only(left: 10, bottom: 5),
                    child: Text(
                      'Medical Details',
                      style: TextStyle(fontFamily: tFontPoppins),
                    )),
                TextFormField(
                  controller: _medicalDetailsCon,
                  keyboardType: TextInputType.multiline,
                  minLines: 6,
                  maxLines: null,
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                  decoration: const InputDecoration(
                    hintText: 'Type your message....',
                    contentPadding: EdgeInsets.all(12),
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(16.0),
                      ),
                    ),
                  ),
                  validator: (v) {
                    if (v.isEmpty) {
                      return 'Message is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Container(
                    padding: EdgeInsets.only(left: 10, bottom: 5),
                    child: Text('Other Details',
                        style: TextStyle(fontFamily: tFontPoppins))),
                TextFormField(
                  controller: _otherDetailsCon,
                  keyboardType: TextInputType.multiline,
                  minLines: 6,
                  maxLines: null,
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(12),
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(16.0),
                      ),
                    ),
                  ),
                  validator: (v) {
                    if (v.isEmpty) {
                      return 'Message is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Container(
                    padding: EdgeInsets.only(left: 10, bottom: 5),
                    child: Text('Upload any pdf or Image file',
                        style: TextStyle(fontFamily: tFontPoppins))),
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(8))),
                      context: context,
                      builder: (_) => ImageSelector(
                        onDone: (File pickedFile) {
                          Navigator.pop(context);
                          setState(() {
                            _prescriptionFile = pickedFile;
                            print("Image is selected $_prescriptionFile");
                            // _profileBloc.uploadProfileImage(_profileImage);
                          });
                        },
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    height: 100,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(20)),
                    child: _prescriptionFile==null?Icon(Icons.download_rounded):Text(_prescriptionFile.parent.path.toString()),
                  ),
                ),
                SizedBox(height: 20),
                FlatButton(
                  minWidth: double.infinity,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0)),
                  color: kPrimaryColor,
                  onPressed: () {

                    if (_formKey.currentState.validate()) {
                      setState(() {
                        isSubmitting=true;
                      });
                      ApiProvider()
                          .uploadPrescriptions(_otherDetailsCon.text,
                              _medicalDetailsCon.text, _prescriptionFile)
                          .then((value) {
                            setState(() {
                              isSubmitting=false;
                              Fluttertoast.showToast(msg: value);                            });
                      });
                    } else {
                      setState(() {
                        isSubmitting=false;
                      });
                      Fluttertoast.showToast(msg: 'Please fill the form');
                    }
                    // Fluttertoast.showToast(
                    //     msg: "Task is still Pending",
                    //     toastLength: Toast.LENGTH_SHORT,
                    //     gravity: ToastGravity.BOTTOM,
                    //     timeInSecForIos: 1, // also possible "TOP" and "CENTER"
                    //     backgroundColor: kBackgroundColor,
                    //     textColor: Colors.white);
                  },
                  height: 50,
                  child: isSubmitting
                      ? CircularProgressIndicator(
                          valueColor:
                              new AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                      : Text(
                          "Submit",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  String getAge(String dob){
    var _dataTime=DateTime.now().year-DateTime.parse(dob).year;
    return _dataTime.toString();
  }
}

class ImageSelector extends StatelessWidget {
  final VoidCallback onClose;
  final Function(File file) onDone;
  final picker = ImagePicker();
  ImageSelector({Key key, this.onClose, this.onDone}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 8,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "SELECT IMAGE FROM",
                  style: Theme.of(context).textTheme.subtitle2.copyWith(
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.normal,
                      fontSize: 12),
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(24),
                  onTap: () => Navigator.pop(context),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.close,
                      size: 16,
                    ),
                  ),
                )
              ],
            ),
          ),
          Divider(
            height: 1,
          ),
          ListTile(
            dense: true,
            onTap: () {
              getImage(ImageSource.camera);
            },
            leading: Icon(Icons.camera_alt_outlined),
            title: Text("Camera"),
          ),
          ListTile(
            onTap: () {
              getImage(ImageSource.gallery);
            },
            dense: true,
            title: Text("Gallery"),
            leading: Icon(Icons.photo_camera_back),
          ),
        ],
      ),
    );
  }

  Future getImage(ImageSource imageSource) async {
    final pickedFile = await picker.getImage(source: imageSource);
    if (pickedFile != null) {
      onDone(File(pickedFile.path));
    } else {
      print('No image selected.');
    }
  }
}
