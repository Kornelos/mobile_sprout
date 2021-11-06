class PlantInfoApiResponse {
  final String type;
  final String id;
  final Attributes attributes;

  PlantInfoApiResponse(
      {required this.type, required this.id, required this.attributes});

  factory PlantInfoApiResponse.fromJson(Map<String, dynamic> json) {
    return PlantInfoApiResponse(
        type: json['type'], id: json['id'], attributes: Attributes.fromJson(json['attributes']));
  }
}

class Attributes {
  final String name;
  final String? slug;
  final String? binomialName;
  final String? description;
  final String? sunRequirements;
  final String? sowingMethod;
  final int? spread;
  final int? rowSpacing;
  final int? height;
  final String? mainImagePath;
  final String? taxon;
  final int? growingDegreeDays;
  final String? svgIcon;

  Attributes(
      {required this.name,
      required this.slug,
      required this.binomialName,
      required this.description,
      required this.sunRequirements,
      required this.sowingMethod,
      required this.spread,
      required this.rowSpacing,
      required this.height,
      required this.mainImagePath,
      required this.taxon,
      required this.growingDegreeDays,
      required this.svgIcon});

  factory Attributes.fromJson(Map<String, dynamic> json) {
    return Attributes(
      name: json['name'],
      slug: json['slug'],
      binomialName: json['binomial_name'],
      description: json['description'],
      sunRequirements: json['sun_requirements'],
      sowingMethod: json['sowing_method'],
      spread: json['spread'],
      rowSpacing: json['row_spacing'],
      height: json['height'],
      mainImagePath: json['main_image_path'],
      taxon: json['taxon'],
      growingDegreeDays: json['growing_degree_days'],
      svgIcon: json['svg_icon'],
    );
  }
}
