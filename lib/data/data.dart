import '../model/categories_model.dart';

List<CategoriesModel> getCategories(){
  List<CategoriesModel> categories = <CategoriesModel>[];
  CategoriesModel categoriesModel = CategoriesModel();

  categoriesModel.imgUrl = "https://images.pexels.com/photos/2156/sky-earth-space-working.jpg?auto=compress&cs=tinysrgb&w=800";
  categoriesModel.categoryName = "Space";
  categories.add(categoriesModel);
  categoriesModel = new CategoriesModel();

  categoriesModel.imgUrl = "https://images.pexels.com/photos/4215113/pexels-photo-4215113.jpeg?auto=compress&cs=tinysrgb&w=800";
  categoriesModel.categoryName = "Nature";
  categories.add(categoriesModel);
  categoriesModel = new CategoriesModel();

  categoriesModel.imgUrl = "https://images.pexels.com/photos/1105766/pexels-photo-1105766.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2";
  categoriesModel.categoryName = "City";
  categories.add(categoriesModel);
  categoriesModel = new CategoriesModel();

  categoriesModel.imgUrl = "https://images.pexels.com/photos/3910071/pexels-photo-3910071.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2";
  categoriesModel.categoryName = "Aesthetic";
  categories.add(categoriesModel);
  categoriesModel = new CategoriesModel();

  categoriesModel.imgUrl = "https://images.pexels.com/photos/2599244/pexels-photo-2599244.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2";
  categoriesModel.categoryName = "Robots";
  categories.add(categoriesModel);
  categoriesModel = new CategoriesModel();



  return categories;
}