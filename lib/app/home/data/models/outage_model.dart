class OutageModel {
  final String name;
  final String description;
  final String cityImage;
  final bool status;

  OutageModel({required this.name, required this.description, required this.cityImage, required this.status});

  factory OutageModel.fromJson(Map<String, dynamic> json) {
    return OutageModel(
      name: json['name'],
      description: json['description'],
      cityImage: json['cityImage'],
      status: json['status'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "description": description,
      "cityImage": cityImage,
      "status": status,
    };
  }
}
