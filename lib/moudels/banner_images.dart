class BannerImages {
  var id;
  var url;
  var imageURL;

  BannerImages({required this.id, required this.url, required this.imageURL});

  factory BannerImages.fromJson(var json) {
    return BannerImages(
      id: json['Id'],
      url: json['URL'],
      imageURL: json['ImageURL'],
    );
  }
}
