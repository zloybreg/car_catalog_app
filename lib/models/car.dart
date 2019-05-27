import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'car.g.dart';

@JsonSerializable()

class Car {
  String key;
  String model;
  String yearOfManufacture;
  String manufacture;
  String carClass;
  String addDate;
  String bodyType;

  Car({this.model, this.yearOfManufacture, this.manufacture, this.carClass, this.bodyType})
  {
    this.addDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
  } 

  Car.fromSnapshot(DocumentSnapshot snap) :
    this.key = snap.documentID,
    this.model = snap.data['model'],
    this.yearOfManufacture = snap.data['yearOfManufacture'],
    this.manufacture = snap.data['manufacture'],
    this.carClass = snap.data['carClass'],
    this.addDate = snap.data['addDate'],
    this.bodyType = snap.data['bodyType'];

  factory Car.fromJson(Map<String, dynamic> json) => _$CarFromJson(json);

  Car.init() :
    this.model = 'model',
    this.yearOfManufacture = 'yearOfManufacture',
    this.manufacture = 'manufacture',
    this.carClass = 'carClass',
    this.bodyType = 'bodyType';

  Map<String, dynamic> toJson() => _$CarToJson(this);
}
