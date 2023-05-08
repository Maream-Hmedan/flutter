class ItemModel {
  var Id;
  var Name;
  var ImageURL;
  var Price;
  var Description;
  var Id_statetype;
  var Id_shops;

  ItemModel({
    required this.Id,
    required this.Name,
    required this.ImageURL,
    required this.Price,
    required this.Description,
    this.Id_statetype,
     this.Id_shops,
  });
  factory ItemModel.fromJson(var json) {
    return ItemModel(
      Id: json['Id'],
      ImageURL: json['ImageURL'],
      Name: json['Name'],
      Price: json['Price'],
      Description: json['Description'],
      Id_statetype: json['Id_statetype'],
      Id_shops:json['Id_shops']
    );
  }
}
