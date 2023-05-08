class CategoriesModel {
  var id;
  var imageURL;
  var name;
  var Id_stateType;

  CategoriesModel({
    required this.id,
    required this.imageURL,
    required this.name,
    this.Id_stateType,
  });

  factory CategoriesModel.fromJson(var json) {
    return CategoriesModel(
      id: json['Id'],
      imageURL: json['ImageURL'],
      name: json['Name'],
      Id_stateType: json['Id_statetype'],
    );
  }
}
