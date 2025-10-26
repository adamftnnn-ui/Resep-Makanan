import '../models/resep_model.dart';

class CreateResepController {
  ResepModel resep = ResepModel();

  void setTitle(String value) => resep.title = value;
  void setCountry(String value) => resep.country = value;
  void setTime(String value) => resep.time = value;
  void setServing(String value) => resep.serving = value;

  void addIngredient(String ingredient) => resep.ingredients.add(ingredient);
  void addInstruction(String step) => resep.instructions.add(step);

  void setIngredients(List<String> ingredients) {
    resep.ingredients = ingredients;
  }

  void setSteps(List<String> steps) {
    resep.instructions = steps;
  }

  // ✅ ubah jadi menerima bool
  void setHalal(bool value) => resep.halal = value;

  // ✅ tambahan baru: set nutrisi (list map)
  void setNutritions(List<Map<String, String>> nutritions) {
    resep.nutritions = nutritions;
  }

  void simpanResep() {
    print('Resep disimpan: ${resep.toMap()}');
  }
}
