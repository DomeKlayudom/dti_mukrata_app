// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_final_fields, sort_child_properties_last

import 'dart:io';

import 'package:dti_mukrata_app/views/show_pay_bill_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:sau_mukratha_app/views/show_pay_bill_ui.dart';

class CalculatePayBillUI extends StatefulWidget {
  const CalculatePayBillUI({super.key});

  @override
  State<CalculatePayBillUI> createState() => _CalculatePayBillUIState();
}

class _CalculatePayBillUIState extends State<CalculatePayBillUI> {
  String _memberTypeSelected = 'ไม่เป็นสมาชิก';

  List<String> _memberType = [
    'ไม่เป็นสมาชิก',
    'สมาชิก Silver Member ลด 5%',
    'สมาชิก Gold Member ลด 10%',
    'สมาชิก Platinum Member ลด 20%',
  ];

  //สร้างเมธอดแสดง WarningMessage
  showWarningMessage(context, msg) async {
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'คำเตือน',
          textAlign: TextAlign.center,
        ),
        content: Text(
          msg,
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'ตกลง',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepOrange,
            ),
          ),
        ],
      ),
    );
  }

  //ตัวแปร
  File? _imageFromCamera;
  bool _adultStatus = false;
  bool _childStatus = false;

  TextEditingController _adultCtrl = new TextEditingController(text: '0');
  TextEditingController _childCtrl = new TextEditingController(text: '0');
  TextEditingController _cokeCtrl = new TextEditingController(text: '0');
  TextEditingController _plainCtrl = new TextEditingController(text: '0');

  bool _waterSelected = false;

  Future getImageFromCamera() async {
    final image = await ImagePicker().pickImage(
        source: ImageSource.camera, preferredCameraDevice: CameraDevice.front);

    if (image == null) return;
    setState(() {
      _imageFromCamera = File(image.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text(
          'คิดเงิน',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      */
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.085,
              vertical: MediaQuery.of(context).size.height * 0.05,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    getImageFromCamera();
                  },
                  child: Align(
                    alignment: Alignment.center,
                    child: _imageFromCamera == null
                        ? Image.asset(
                            'assets/images/camera.jpg',
                            width: MediaQuery.of(context).size.width * 0.35,
                          )
                        : Image.file(
                            _imageFromCamera!,
                            width: MediaQuery.of(context).size.width * 0.35,
                            height: MediaQuery.of(context).size.height * 0.35,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Text(
                  'จำนวนคน',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.height * 0.02,
                  ),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _adultStatus,
                      onChanged: (paramValue) {
                        setState(() {
                          if (paramValue == false) {
                            _adultCtrl.text = '0';
                          }
                          ;

                          _adultStatus = paramValue!;
                        });
                      },
                    ),
                    Text(
                      'ผู้ใหญ่ 299 บาท/คน จำนวน  ',
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.15,
                      child: TextField(
                        controller: _adultCtrl,
                        enabled: _adultStatus,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        maxLength: 3,
                        decoration: InputDecoration(
                          suffix: Text(
                            'คน',
                          ),
                          counter: Offstage(),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _childStatus,
                      onChanged: (paramValue) {
                        if (paramValue == false) {
                          _childCtrl.text = '0';
                        }
                        setState(() {
                          _childStatus = paramValue!;
                        });
                      },
                    ),
                    Text(
                      'เด็ก 69 บาท/คน จำนวน  ',
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.15,
                      child: TextField(
                        controller: _childCtrl,
                        enabled: _childStatus,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        maxLength: 3,
                        decoration: InputDecoration(
                          suffix: Text(
                            'คน',
                          ),
                          counter: Offstage(),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),
                Text(
                  'บุปเฟต์น้ำดื่ม',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.height * 0.02,
                  ),
                ),
                Row(
                  children: [
                    Radio(
                      value: true,
                      groupValue: _waterSelected,
                      onChanged: (paramValue) {
                        setState(() {
                          if (paramValue == true) {
                            _cokeCtrl.text = '0';
                            _plainCtrl.text = '0';
                          }
                          _waterSelected = paramValue!;
                        });
                      },
                    ),
                    Text(
                      'รับ 25 บาท/หัว',
                    ),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: false,
                      groupValue: _waterSelected,
                      onChanged: (paramValue) {
                        setState(() {
                          _waterSelected = paramValue!;
                        });
                      },
                    ),
                    Text(
                      'ไม่รับ',
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                    ),
                    Text(
                      '  โค้ก 20 บาท/ขวด จำนวน  ',
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.15,
                      child: TextField(
                        controller: _cokeCtrl,
                        enabled: !_waterSelected,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        maxLength: 3,
                        decoration: InputDecoration(
                          suffix: Text(
                            'ขวด',
                          ),
                          counter: Offstage(),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                    ),
                    Text(
                      '  น้ำเปล่า 15 บาท/ขวด จำนวน  ',
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.15,
                      child: TextField(
                        controller: _plainCtrl,
                        enabled: !_waterSelected,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        maxLength: 3,
                        decoration: InputDecoration(
                          suffix: Text(
                            'ขวด',
                          ),
                          counter: Offstage(),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),
                Text(
                  'ประเภทสมาชิก',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.height * 0.02,
                  ),
                ),
                DropdownButton(
                  value: _memberTypeSelected,
                  isExpanded: true,
                  onChanged: (paramValue) {
                    setState(() {
                      _memberTypeSelected = paramValue!;
                    });
                  },
                  items: _memberType
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(
                              e,
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.033,
                              ),
                            ),
                          ))
                      .toList(),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.035,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 2,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          if (_imageFromCamera == null) {
                            showWarningMessage(context, 'ถ่ายรูปด้วย...');
                            return;
                          } else if (_adultStatus == false &&
                              _childStatus == false) {
                            showWarningMessage(context,
                                'เลือกผู้ใหญ่และหรือเด็กที่มากินด้วย...');
                            return;
                          } else if (_adultStatus == true &&
                                  _adultCtrl.text == '0' ||
                              _adultCtrl.text.trim().length == 0) {
                            showWarningMessage(
                                context, 'ตรวจสอบจำนวนผู้ใหญ่ด้วย...');
                            return;
                          } else if (_childStatus == true &&
                                  _childCtrl.text == '0' ||
                              _childCtrl.text.trim().length == 0) {
                            showWarningMessage(
                                context, 'ตรวจสอบจำนวนเด็กด้วย...');
                            return;
                          }

                          int adultNum = int.parse(_adultCtrl.text);
                          int childNum = int.parse(_childCtrl.text);
                          int cokeNum = int.parse(_cokeCtrl.text);
                          int plainNum = int.parse(_plainCtrl.text);

                          double payBill = 0;

                          int waterBuffet = _waterSelected == true
                              ? (adultNum + childNum) * 25
                              : 0;

                          payBill = (adultNum * 299) +
                              (childNum * 69) +
                              waterBuffet +
                              (cokeNum - 20) +
                              (plainNum * 15);
                          if (_memberTypeSelected == 'ไม่เป็นสมาชิค') {
                            payBill = payBill;
                          } else if (_memberTypeSelected ==
                              'สมาชิค Silver Member ลด 5%') {
                            payBill = payBill - (payBill * 5 / 100);
                          } else if (_memberTypeSelected ==
                              'สมาชิค Gold Member ลด 5%') {
                            payBill = payBill - (payBill * 10 / 100);
                          } else {
                            payBill = payBill - (payBill * 20 / 100);
                          }

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShowPayBillUI(
                                imageFromCamera: _imageFromCamera,
                                adult: _adultCtrl.text,
                                child: _childCtrl.text,
                                waterSelected:
                                    _waterSelected == true ? 'รับ' : 'ไม่รับ',
                                memberType: _memberTypeSelected,
                                payBill: payBill.toStringAsFixed(2),
                                coke: _cokeCtrl.text,
                                plain: _plainCtrl.text,
                              ),
                            ),
                          );
                        },
                        icon: Icon(
                          FontAwesomeIcons.moneyBill1Wave,
                          color: Colors.white,
                        ),
                        label: Text(
                          'คำนวณเงิน',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepOrange,
                          padding: EdgeInsets.symmetric(
                            vertical: 12.0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Expanded(
                      flex: 1,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            _imageFromCamera = null;
                            _adultStatus = false;
                            _adultCtrl.text = '0';
                            _childStatus = false;
                            _childCtrl.text = '0';
                            _cokeCtrl.text = '0';
                            _plainCtrl.text = '0';
                            _waterSelected = false;
                            _memberTypeSelected = 'ไม่เป็นสมาชิก';
                          });
                        },
                        icon: Icon(
                          FontAwesomeIcons.moneyBill1Wave,
                          color: Colors.white,
                        ),
                        label: Text(
                          'ยกเลิก',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[800],
                          padding: EdgeInsets.symmetric(
                            vertical: 12.0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
