import 'dart:convert';
import 'dart:ffi';
import 'dart:io' show Platform;

import 'package:fabricio/components/pickerData.dart';
import 'package:fabricio/components/textField.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:intl/intl.dart';

class MainForm extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const MainForm({Key key, this.scaffoldKey}) : super(key: key);
  @override
  _MainFormState createState() => _MainFormState();
}

class _MainFormState extends State<MainForm> {
  bool _isIos = Platform.isIOS ? true : false;
  TextEditingController _textController;
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

  bool _has;
  int pa1;
  int pa2;
  int fc;
  int glicemia;
  Double rni;
  String _dataString;
  DateTime _data;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: 'initial text');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 25, bottom: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Image(
                    image: AssetImage(
                      'assets/images/Doctor_4.png',
                    ),
                    width: 200.0,
                  ),
                ),
                SizedBox(height: 25),
                Text(
                  'Insira os dados',
                  style: TextStyle(
                    fontSize: 28,
                    fontFamily: 'SF Pro Display',
                    fontWeight: FontWeight.w600,
                    color: Color(0xff1f1f1f),
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 45),
                  child: Text(
                    'Preencha corretamente os dados para que possamos fazer o acompanhamento da melhor forma possível',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'SF Pro Display',
                      color: Color(0xffb0b0b0),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Form(
                  child: Expanded(
                    child: ListView(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            showPickerDialog(context);
                          },
                          child: Container(
                            color: Colors.white.withOpacity(0),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      _has == null
                                          ? 'HAS'
                                          : _has == true ? 'Sim' : 'Não',
                                      style: TextStyle(
                                        color: Color(0xffb0b0b0),
                                        fontSize: 16,
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_drop_down,
                                      color: Color(0xffb0b0b0),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 1,
                                  color: Color(0xffdddddd),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        TextFieldForm(
                          labelText: 'Glicemia',
                          hintText: 'Glicemia em mg/dl',
                          keyType: TextInputType.number,
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        TextFieldForm(
                          labelText: 'RNI',
                          hintText: 'Insira seu RNI',
                          keyType: TextInputType.number,
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        GestureDetector(
                          onTap: () {
                            showPickerDateTime(context);
                          },
                          child: Container(
                            color: Colors.white.withOpacity(0),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'Data',
                                      style: TextStyle(
                                        color: Color(0xffb0b0b0),
                                        fontSize: 16,
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_drop_down,
                                      color: Color(0xffb0b0b0),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 1,
                                  color: Color(0xffdddddd),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Expanded(
                              child: TextFieldForm(
                                labelText: 'RNI 1',
                                hintText: '',
                                keyType: TextInputType.number,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24),
                              child: Icon(
                                Icons.close,
                                color: Color(0xffb0b0b0),
                              ),
                            ),
                            Expanded(
                              child: TextFieldForm(
                                labelText: 'RNI 1',
                                hintText: '',
                                keyType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        TextFieldForm(
                          labelText: 'Frequência cardíaca',
                          hintText: 'Insira sua frequência cardíaca',
                          keyType: TextInputType.number,
                        ),
                        SizedBox(
                          height: 24,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(25),
                  child: SizedBox(
                    width: double.infinity,
                    child: _isIos
                        ? CupertinoButton(
                            child: Text('Enviar'),
                            onPressed: () => showThanksPage(context),
                            color: Color(0xff007aff),
                          )
                        : FlatButton(
                            onPressed: () => showThanksPage(context),
                            child: Text(
                              'Enviar',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            color: Color(0xff007aff),
                            textColor: Colors.white,
                            padding: EdgeInsets.all(15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  showPickerDialog(BuildContext context) {
    new Picker(
        adapter: PickerDataAdapter<String>(
            pickerdata: new JsonDecoder().convert(PickerData2)),
        hideHeader: true,
        title: new Text("Selecionar HAS"),
        onConfirm: (Picker picker, List value) {
          setState(() {
            _has = value[0] == 0 ? null : (value[0] == 1 ? true : false);
          });
        }).showDialog(context);
  }

  showPickerDateTime(BuildContext context) {
    new Picker(
        adapter: new DateTimePickerAdapter(
          type: PickerDateTimeType.kYMD_AP_HM,
          isNumberMonth: true,
          //strAMPM: const["上午", "下午"],
          yearSuffix: "",
          monthSuffix: "",
          daySuffix: "",
          minuteInterval: 5,
          minHour: 1,
          maxHour: 23,
          // twoDigitYear: true,
        ),
        title: new Text("Selecione a data"),
        textAlign: TextAlign.right,
        selectedTextStyle: TextStyle(color: Colors.blue),
        delimiter: [
          PickerDelimiter(
            column: 5,
            child: Container(
              width: 16.0,
              alignment: Alignment.center,
              child: Text(':', style: TextStyle(fontWeight: FontWeight.bold)),
              color: Colors.white,
            ),
          )
        ],
        footer: Container(
          height: 50.0,
          alignment: Alignment.center,
          color: Colors.white,
        ),
        onConfirm: (Picker picker, List value) {
          setState(() {
            _data = dateFormat.parse(picker.adapter.text);
          });
        },
        onSelect: (Picker picker, int index, List<int> selecteds) {
          this.setState(() {
            _dataString = picker.adapter.toString();
          });
        }).show(widget.scaffoldKey.currentState);
  }

  showThanksPage(BuildContext context) {
    return showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  width: 200,
                  height: 200,
                  child: FlareActor(
                    'assets/animations/Check.flr',
                    alignment: Alignment.center,
                    fit: BoxFit.contain,
                    animation: 'Checkmark_appear',
                  ),
                ),
                Text(
                  'Tudo certo!',
                  style: TextStyle(
                    fontSize: 28,
                    fontFamily: 'SF Pro Display',
                    fontWeight: FontWeight.w600,
                    color: Color(0xff1f1f1f),
                  ),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  child: Text(
                    'Recebemos sua atualização e iremos trabalhar em cima desses dados. Continue enviando e mantenha a constância!',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'SF Pro Display',
                      color: Color(0xffb0b0b0),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }
}
