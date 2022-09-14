import 'package:theo/model/agency.dart';

class Category {
  Category({
    this.id,
    this.name,
    this.agencies,
  });

  int? id;
  String? name;
  List<Agency>? agencies;

  factory Category.fromMap(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
      );
}
