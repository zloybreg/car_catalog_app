import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:car_catalog_app/models/car.dart';
import 'package:car_catalog_app/models/translator.dart';
import 'package:car_catalog_app/suplemental/user_define_icons.dart';

import 'edit_page.dart';

class ViewPage extends StatefulWidget {
  final Car car;

  ViewPage(this.car);
  
  @override
  _ViewStatePage createState() => _ViewStatePage();
}

class _ViewStatePage extends State<ViewPage> {

  final Firestore db = Firestore.instance;

  String id;

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
                  widget.car.model, 
                  style: TextStyle(fontSize: 20.0, fontFamily: 'Mandali', color: Color(0xFFDDDDDD))
                )
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0),
            child: Divider(color: Color(0xFFDDDDDD),),
          ),
          SizedBox(height: 20.0,),
          buildItem(widget.car),
          Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                RaisedButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => EditPage(widget.car))),
                  child: Text(
                    'Редактировать', 
                    style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'OpenSans')
                  ),
                  color: Color(0xFFDE3371),
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)
                ), 
                ),
                SizedBox(width: 8),
                FlatButton(
                  onPressed: () {
                    deleteData(widget.car);
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Удалить',
                    style: TextStyle(fontSize: 12, color: Color(0xFFDE3371), fontWeight: FontWeight.bold, fontFamily: 'OpenSans'),
                  ),
                ),
              ],
            )
        ],
      ),
    );
  }

  Widget buildItem(Car car) {

    ParameterNameTranslator translatedCar = ParameterNameTranslator.car(car);
    //translatedCar.toMap().forEach((k,v) => print('Key: $k, Value: $v'));
    //car.toJson().forEach((k,v) => print('Key: $k, Value: $v'));     
    return Card(      
      color: Color(0xFF313132),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0)
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14.0, 9.0, 14.0, 9.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Align(
                alignment: Alignment.topRight,
                child: Text(car.addDate,
                  style: TextStyle(fontSize: 10, color: Color(0xFF9D9C9C), fontWeight: FontWeight.bold, fontFamily: 'Muli'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 2.5, bottom: 2.5),
              child: Container(
                child: Row(
                  children: <Widget>[
                    //Text('asd'),
                    keyName(translatedCar),
                    SizedBox(width: 5.0,),
                    valName(car)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void deleteData(Car car) async {
    await db.collection('cars').document(car.key).delete();
    setState(() => id = null);
  }

  Widget keyName(ParameterNameTranslator car) {
    List<String> listKey = List<String>();
    
    car.toMap().forEach((k, v) => listKey.add(v));

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: listKey.map((carParameter) => Text(
          '$carParameter: ' ?? 'bnm',
          style: TextStyle(fontSize: 12, color: Color(0xFFDDDDDD), fontFamily: 'OpenSans'),
        )
      ).toList(),
    );
  }

  Widget valName(Car car) {
    List<String> listVal = List<String>();
    
    car.toJson().forEach((k, v) => listVal.add(v));

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: listVal.map((car) => Text(
          car ?? 'bnm', 
          style: TextStyle(fontSize: 12, color: Color(0xFFFFFFFF), fontWeight: FontWeight.bold, fontFamily: 'OpenSans'),
        )
      ).toList(),
    );
  }
}