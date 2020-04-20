class PlantList {
  final List<PlantsModel> data;
  PlantList({this.data});

  factory PlantList.fromJson(List<dynamic> parsedJson) {
    return PlantList(
      data: parsedJson.map((i) => PlantsModel.fromJson(i)).toList(),
    );
  }
}

class PlantsModel {
  String name;
  String image;
  String description;
  String price;

  PlantsModel({this.name, this.image, this.description, this.price});
  factory PlantsModel.fromJson(Map<String, dynamic> data) {
    return PlantsModel(
        name: data['name'],
        image: data['image'],
        description: data['description'],
        price: data['price']);
  }
}
