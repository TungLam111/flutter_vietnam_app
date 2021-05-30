class ItemList {
    final List<Item> categories;

  ItemList({
    this.categories,
  });

  factory ItemList.fromJson(List<dynamic> parsedJson) {
    List<Item> categories = parsedJson
        .map((categoryJson) => Item.fromJSON(categoryJson))
        .toList();

    return new ItemList(
      categories: categories,
    );
  }

  factory ItemList.fromMenu(List<dynamic> parsedJson){
    List<MenuItem> categories = parsedJson.map((categoryJson) => MenuItem.fromJson(categoryJson)).toList();
    return new ItemList(categories: categories);
  }

  factory ItemList.fromHotel(List<dynamic> parsedJson){
    List<MenuItem> categories = parsedJson.map((categoryJson) => MenuItem.fromJson(categoryJson)).toList();
    return new ItemList(categories: categories);
  }
}

class Item {
  int id;
  String name;
  int price; //avg price
  List images;
  Item({this.id, this.name, this.images, this.price});
    
  factory Item.fromJSON(Map<String, dynamic> json) {
    if (json == null) return null;
    return Item(
        id: json['id'],
      name: json['name'],
      images: json['images'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
    "id": id,
    "name": name,
    "images": images,
    "price": price

    };
  }
}

class MenuItem extends Item {
  MenuItem({int id, String name, List images, int price}) : super(price: price, id: id, name: name, images: images){

  }
  factory MenuItem.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return MenuItem(
        id: json['id'],
      name: json['name'],
      images: json['images'],
      price: json['price'],
    );
  }
}

class RoomItem extends Item{
  RoomItem({int id, String name, List images, int price}) : super(price: price, id: id, name: name, images: images){

  }
  factory RoomItem.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return RoomItem(
        id: json['id'],
      name: json['name'],
      images: json['images'],
      price: json['price'],
    );
  }
}