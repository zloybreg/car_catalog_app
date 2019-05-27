import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:car_catalog_app/models/car.dart';
import 'package:car_catalog_app/models/translator.dart';
import 'package:car_catalog_app/suplemental/user_define_icons.dart';

import 'add_page.dart';
import 'view_page.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key); 

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  final Firestore db = Firestore.instance;

  String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF262627),
      body: ListView(
        //padding: EdgeInsets.all(8.0),          
        children: <Widget>[
          SizedBox(
            height: 20.0,
          ),
          Center(
            child: Text(
              'CAR CATALOG', 
              style: TextStyle(fontSize: 20.0, fontFamily: 'Mandali', color: Color(0xFFDDDDDD))
            )
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0),
            child: Divider(color: Color(0xFFDDDDDD),),
          ),
          streamBuilder(context)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddPage())),
        tooltip: 'Increment',
        child: Icon(Icons.add, size: 30.0,),
        backgroundColor: Color(0xFFDE3371),        
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  streamBuilder(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: db.collection('cars').snapshots(),
      builder: (context, snapshot) {       

        if (snapshot.hasData && snapshot.data.documents != null) {
          
          List<DocumentSnapshot> snapList = snapshot.data.documents;
          
          return Container(        
            padding: const EdgeInsets.fromLTRB(33.0, 22.0, 33.0, 22.0),            
            /*child: Column(
              children: snapshot.data.documents.map((doc) => buildItem(doc, context)).toList(),
            )*/
            child:ListView.builder(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              itemCount: snapList.length,
              itemBuilder: (BuildContext context, int index) {
                var doc = snapshot.data.documents[index];
                Car car = Car.fromSnapshot(doc);

                ParameterNameTranslator translatedCar = ParameterNameTranslator.car(car);
                //translatedCar.toMap().forEach((k,v) => print('Key: $k, Value: $v'));
                //car.toJson().forEach((k,v) => print('Key: $k, Value: $v'));     
                return Dismissible(
                  key: Key(car.key),
                  onDismissed: (direction) {
                    setState(() {
                      snapList.removeAt(index);
                      deleteData(car);
                    });
                  },
                  background: Container(color: Color(0xFF262627),),
                  child: GestureDetector(
                    onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) => ViewPage(car))); print(car.key);},
                    child: Card(      
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
                                child: Text(car.addDate ?? ' ',
                                  style: TextStyle(fontSize: 10, color: Color(0xFF9D9C9C), fontWeight: FontWeight.bold, fontFamily: 'Muli'),
                                ),
                              ),
                            ),
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Icon(UserDefineIsons.car, color: Colors.white,),
                                  SizedBox(width: 12,),
                                  Text(
                                    translatedCar.model ?? 'bnm',
                                    style: TextStyle(fontSize: 20, color: Color(0xFFDE3371), fontWeight: FontWeight.bold, fontFamily: 'OpenSansCondensed'),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 5.0,),
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
                    ),
                  ),
                );
              },
            )
          );
        } else {
          return Text("Loading...");
        }
      },
    );
  }

  void deleteData(Car car) async {
    await db.collection('cars').document(car.key).delete();
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
