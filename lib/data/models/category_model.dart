import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final int id;
  final String name;
  final String thumbnail;
  final String description;

  const Category({
    required this.id,
    required this.name,
    required this.thumbnail,
    required this.description,
  });

  @override
  List<Object?> get props => [id, name, thumbnail, description];

  //Parsing Network Item to App Object
  factory Category.fromJSON(Map<String, dynamic> jsonCategory) {
    var storedid = int.parse(jsonCategory['idCategory']);
    var storedname = jsonCategory['strCategory'];
    var storedthumbnail = jsonCategory['strCategoryThumb'] ?? "Null";
    var storeddescription = jsonCategory['strCategoryDescription'];

    return Category(id: storedid, name: storedname, thumbnail: storedthumbnail, description: storeddescription);
  }

  static Category nullcategory = const Category(
    id: -1,
    name: "NULL",
    thumbnail: "NULL",
    description: "NULL",
  );
}
