class Dish {
  int? id;
  String? title;
  String? ingredients;
  String? steps;
  String? category;

  Dish(
      {this.id,
        this.title,
        this.ingredients,
        this.steps,
        this.category});

  factory Dish.fromJson(Map<String, dynamic> json) {
    return Dish(
        id: json['id'],
        title: json['title'],
        ingredients: json['ingredients'],
        steps: json['steps'],
        category: json['category']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['ingredients'] = ingredients;
    data['steps'] = steps;
    data['category'] = category;
    return data;
  }
}