import 'package:floor/floor.dart';

@entity
class Category {
  @PrimaryKey(autoGenerate: true)
  int? id;

  late String title;

  Category({required this.title, required this.id});

  Category.fromJson(Map<String, dynamic> json) {
    title = json['strCategory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['strCategory'] = title;
    return data;
  }
}
