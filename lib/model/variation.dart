class VariationModel {
  int id;
  String description;
  String regularPrice;
  String salePrice;
  String stockStatus;
  Imag image;
  List<Attributes> attributes;

  VariationModel(
      {this.id,
      this.attributes,
      this.description,
      this.image,
      this.regularPrice,
      this.salePrice,
      this.stockStatus});

  factory VariationModel.fromJson(Map<String, dynamic> json) {
    json = json ?? {};
    return VariationModel(
      id: json['id'],
      attributes: List<Attributes>.from(json["attributes"].map((x) => Attributes.fromJson(x))),
      description: json['description'],
      image: Imag.fromJson(json['image']),
      regularPrice: json['regular_price'],
      salePrice: json['sale_price'],
      stockStatus: json['stock_status'],
    );
  }
}

class Attributes {
  int id;
  String name;
  String option;

  Attributes({this.id, this.name, this.option});

  factory Attributes.fromJson(Map<String, dynamic> json) {
    json = json ?? {};
    return Attributes(
      id: json["id"],
      name: json["name"],
      option: json['option'],
    );
  }
// Map<String, dynamic> toJson() => {
//   "id": id,
//   "name": name,
//   "": position,
//   "visible": visible,
//   "variation": variation,
//   "options": List<dynamic>.from(options.map((x) => x)),
// };
}

class Imag {
  Imag({
    this.id,
    this.src,
    this.name,
    this.alt,
  });

  int id;
  String src;
  String name;
  String alt;

  factory Imag.fromJson(Map<String, dynamic> json) => Imag(
        id: json["id"],
        src: json["src"],
        name: json["name"],
        alt: json["alt"],
      );
}
