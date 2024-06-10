import 'package:hive/hive.dart';

class CarModel extends HiveObject{
  @HiveField(0)
  final String name;
  @HiveField(0)
  final String brand;
  @HiveField(1)
  final num price;

  CarModel({
    required this.name,
    required this.brand,
    required this.price,
  });
}
