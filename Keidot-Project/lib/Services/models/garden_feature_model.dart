class GardenFeature {
  final String id;
  final String name;
  bool selected;

  GardenFeature({required this.id, required this.name, this.selected = false});

  factory GardenFeature.fromJson(Map<String, dynamic> json) {
    return GardenFeature(
      id: json['featureId'],
      name: json['name'],
      selected: false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'featureId': id,
      'name': name,
    };
  }
}
