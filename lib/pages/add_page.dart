import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:car_catalog_app/models/car.dart';
import 'package:car_catalog_app/models/translator.dart';
import 'package:car_catalog_app/suplemental/user_define_icons.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> { 

  // Создаем ключ для синхронизации форм
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final Firestore db = Firestore.instance;

  String _model;
  String _yearOfManufacture;
  String _manufacture;
  String _carClass;
  String _bodyType;

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Color(0xFF262627),
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: <Widget>[
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 40.0,
              ),
              FlatButton(
                child: Icon(
                  UserDefineIsons.arrow_icon, 
                  color: Color(0xFFDDDDDD),
                  size: 10.0,
                ),
                onPressed: () => Navigator.pop(context),
              ),
              SizedBox(
                width: 15.0,
              ),
              Center(
                child: Text(
                  'ADD CAR', 
                  style: TextStyle(fontSize: 20.0, fontFamily: 'Mandali', color: Color(0xFFDDDDDD))
                )
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0),
            child: Divider(color: Color(0xFFDDDDDD),),
          ),
          Form(
            key: _formKey,
            child: buildTextFormFields(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  createData(context);
                },
                child: Text(
                  'Добавить', 
                  style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'OpenSans'),
                ),
                color: Color(0xFFDE3371),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)
                ), 
              )
            ],
          )
        ],
      ),
    );
  }

  void createData(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      Navigator.pop(context);
      Car car = Car(model : _model, yearOfManufacture : _yearOfManufacture, manufacture : _manufacture, carClass : _carClass, bodyType : _bodyType);
      _formKey.currentState.reset();
      //car.toJson().forEach((k,v) => print('Key: $k, Value: $v'));   
      DocumentReference ref = await db.collection('cars').add(car.toJson());
      print(ref.documentID);
    }
  }

  Widget buildTextFormFields() {

    const double textFormBorderRadius = 10.0;
    const double textFormHeight = 50.0;
    const EdgeInsets textFormPadding = EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0);

    ParameterNameTranslator translatedCar = ParameterNameTranslator.car(Car.init());

    Map<String, dynamic> _car = translatedCar.toMap();

    return Column(
      children: <Widget>[        
        SizedBox(height: 20.0),
        Padding(
          padding: textFormPadding,
          child: Container(
            height: textFormHeight,
            child: TextFormField(
              
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(textFormBorderRadius)
                ),
                labelText: _car[translatedCar.model],
                fillColor: Colors.grey[300],
                filled: true,
                labelStyle: TextStyle(fontFamily: 'OpenSans', fontSize: 15)
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Введите поле: ${_car[translatedCar.model]}!';
                } 
              },
              onSaved: (value) => this._model = value,
            ),
          ),
        ),
        Padding(
          padding: textFormPadding,
          child: Container(
            height: textFormHeight,
            child: TextFormField(             
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(textFormBorderRadius),
                ),
                labelText: _car[translatedCar.yearOfManufacture],
                fillColor: Colors.grey[300],
                filled: true,
                labelStyle: TextStyle(fontFamily: 'OpenSans', fontSize: 15)
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Введите поле: ${_car[translatedCar.yearOfManufacture]}!';
                }
              },
              onSaved: (value) => this._yearOfManufacture = value,
            ),
          ),
        ),
        Padding(
          padding: textFormPadding,
          child: Container(
            height: textFormHeight,
            child: TextFormField(
              
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(textFormBorderRadius)
                ),
                labelText: _car[translatedCar.manufacture],
                fillColor: Colors.grey[300],
                filled: true,
                labelStyle: TextStyle(fontFamily: 'OpenSans', fontSize: 15)
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Введите поле: ${_car[translatedCar.manufacture]}!';
                }
              },
              onSaved: (value) => this._manufacture = value,
            ),
          ),
        ),
        Padding(
          padding: textFormPadding,
          child: Container(
            height: textFormHeight,
            child: TextFormField(
              
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(textFormBorderRadius)
                ),
                labelText: _car[translatedCar.carClass],
                fillColor: Colors.grey[300],
                filled: true,
                labelStyle: TextStyle(fontFamily: 'OpenSans', fontSize: 15)
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Введите поле: ${_car[translatedCar.carClass]}!';
                }
              },
              onSaved: (value) => this._carClass = value,
            ),
          ),
        ),
        Padding(
          padding: textFormPadding,
          child: Container(
            height: textFormHeight,
            child: TextFormField(
              
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(textFormBorderRadius)
                ),
                labelText: _car[translatedCar.bodyType],
                fillColor: Colors.grey[300],
                filled: true,
                labelStyle: TextStyle(fontFamily: 'OpenSans', fontSize: 15)
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Введите поле: ${_car[translatedCar.bodyType]}!';
                }
              },
              onSaved: (value) => this._bodyType = value,
            ),
          ),
        )
      ]
    );
  }
}