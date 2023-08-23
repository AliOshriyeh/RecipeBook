// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class Recipe extends Equatable {
  final String id;
  final String name;
  final bool isVegan;
  final String content;
  final String calories;
  // final Image image;

  const Recipe({
    required this.id,
    required this.name,
    required this.isVegan,
    required this.content,
    required this.calories,
    // required this.image,
  });

  @override
  List<Object?> get props => [id, name, isVegan, content, calories];

  //!DUMMY DATA
  // static List<Recipe> recipes = [
  //   Recipe(
  //       id: '0',
  //       image: Image.asset('assets/images/Re1_zucchini_slice.jpg', fit: BoxFit.cover),
  //       name: "Zucchini Slice",
  //       content: "While the argument as to what is Australia’s national dish will always rage (is it roast lamb, green chicken curry or a barramundi burger)? One thing is for sure, zucchini slice is hands-down the national food of the home cook."),
  //   Recipe(
  //       id: '1',
  //       image: Image.asset('assets/images/Re2_pumpkin_soup.jpg', fit: BoxFit.cover),
  //       name: "Easy pumpkin soup recipe",
  //       content: "The beauty of pumpkin soup _ and this classic pumpkin soup recipe in particular - is that it’s so versatile and forgiving. It’s one of the easiest meals to make with just a handful of ingredients, and it’s almost impossible to mess up."),
  //   Recipe(
  //       id: '2',
  //       image: Image.asset('assets/images/Re3_fried_rice.jpg', fit: BoxFit.cover),
  //       name: "Easy fried rice",
  //       content: "Fried rice is a staple of Aussie takeaway and while we all have our favourite restaurant that makes it just the way we like it, it's a dish that is easy to replicate at home. "),
  //   Recipe(
  //       id: '3',
  //       image: Image.asset('assets/images/Re4_shepherds_pie.jpg', fit: BoxFit.cover),
  //       name: "Classic shepherd's pie",
  //       content: "A classic British and Irish dish that’s loved the world over, shepherd’s pie is the ultimate comfort food. Made with lamb mince, a rich gravy and buttery mashed potatoes, this recipe has all the elements for a perfect Sunday dinner"),
  //   Recipe(
  //       id: '4',
  //       image: Image.asset('assets/images/Re5_impossible_quiche.jpg', fit: BoxFit.cover),
  //       name: "Impossible quiche",
  //       content: "Don’t let the name deceive you: this ham and cheese quiche is actually incredibly possible to make. What we love about impossible quiche is that it requires no puff pastry base - you simply mix all the ingredients together, pour into the dish and voila!"),
  // ];
}
