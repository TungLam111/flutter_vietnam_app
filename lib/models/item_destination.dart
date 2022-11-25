class ItemList {
  factory ItemList.fromJson(List<dynamic> parsedJson) {
    List<Item> categories = parsedJson
        .map(
          (dynamic categoryJson) => Item.fromJSON(
            categoryJson as Map<String, dynamic>,
          ),
        )
        .toList();

    return ItemList(
      categories: categories,
    );
  }

  ItemList({
    this.categories,
  });
  List<Item>? categories;
}

class Item {
  factory Item.fromJSON(Map<String, dynamic> json) {
    return Item(
      id: json['id'] as int?,
      name: json['name'] as String?,
      images: json['images'] != null
          ? List<String>.from(json['images'] as List<dynamic>)
          : null,
      price: json['price'] as int?,
    );
  }
  Item({this.id, this.name, this.images, this.price});
  int? id;
  String? name;
  int? price; //avg price
  List<String>? images;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'images': images,
      'price': price
    };
  }
}
