import 'package:car_catalog_app/models/car.dart';

class ParameterNameTranslator {
  
  String model;
  String yearOfManufacture;
  String manufacture;
  String carClass;
  String addDate;
  String bodyType;

  ParameterNameTranslator(this.model,this.yearOfManufacture,this.manufacture,this.carClass,this.addDate,this.bodyType);

  factory ParameterNameTranslator.car(Car car) {
    return ParameterNameTranslator(car.model, car.yearOfManufacture, car.manufacture, car.carClass, car.addDate, car.bodyType);
  }

  Map<String, String> toMap() => {
    model : 'Модель',
    yearOfManufacture : 'Дата производства',
    manufacture : 'Производитель',
    carClass : 'Класс',
    addDate : 'Дата добавления',
    bodyType : 'Тип кузова'
  };

  Map<String, String> addHintText() => {
    model : 'Модель',
    yearOfManufacture : 'Дата производства',
    manufacture : 'Производитель',
    carClass : 'Класс',
    bodyType : 'Тип кузова'
  };
}






