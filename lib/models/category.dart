class Category {
  late String title;

  Category({required this.title});

  Category.fromJson(Map<String, dynamic> json) {
    title = json['strCategory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['strCategory'] = this.title;
    return data;
  }
}