// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Car _$CarFromJson(Map<String, dynamic> json) {
  return Car(
      //key: json['key'] as String,
      model: json['model'] as String,
      yearOfManufacture: json['yearOfManufacture'] as String,
      manufacture: json['manufacture'] as String,
      carClass: json['carClass'] as String,
      bodyType: json['bodyType'] as String)
    ..addDate = json['addDate'] as String;
}

Map<String, dynamic> _$CarToJson(Car instance) => <String, dynamic>{
      //'key': instance.key,
      'model': instance.model,
      'yearOfManufacture': instance.yearOfManufacture,
      'manufacture': instance.manufacture,
      'carClass': instance.carClass,
      'addDate': instance.addDate,
      'bodyType': instance.bodyType
    };
