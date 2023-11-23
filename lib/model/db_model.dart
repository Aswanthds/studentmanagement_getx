import 'package:hive/hive.dart';

part 'db_model.g.dart';

enum Gender {
  male,
  female,
  other,
  none,
}

@HiveType(typeId: 0)
class Student {
  @HiveField(4)
  String? gender;
  @HiveField(1)
  String name;
  @HiveField(2)
  String age;
  @HiveField(3)
  String grade;
  @HiveField(5)
  String id;
  @HiveField(6)
  String? imgPath;

  Student({
    required this.gender,
    required this.age,
    required this.grade,
    required this.id,
    required this.name,
    this.imgPath
  });
}
