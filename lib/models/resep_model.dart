class ResepModel {
  String title;
  String image;
  String country;
  String time;
  String serving;
  bool halal; // ✅ ubah dari String → bool
  List<String> ingredients;
  List<String> instructions;
  List<Map<String, String>> nutritions; // ✅ tambahan baru

  ResepModel({
    this.title = '',
    this.image = '',
    this.country = '',
    this.time = '',
    this.serving = '',
    this.halal = false, // ✅ default: belum halal
    List<String>? ingredients,
    List<String>? instructions,
    List<Map<String, String>>? nutritions,
  }) : ingredients = ingredients ?? [],
       instructions = instructions ?? [],
       nutritions = nutritions ?? [];

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'image': image,
      'country': country,
      'time': time,
      'serving': serving,
      'halal': halal,
      'ingredients': ingredients,
      'instructions': instructions,
      'nutritions': nutritions, // ✅ ikut disimpan juga
    };
  }
}
