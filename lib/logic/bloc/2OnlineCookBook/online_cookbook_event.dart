part of 'online_cookbook_bloc.dart';

sealed class OnlineCookBookEvent extends Equatable {
  final Recipe recipe;
  final Ingredient ingredient;
  // final Category? category;
  const OnlineCookBookEvent(this.recipe, this.ingredient);

  @override
  List<Object> get props => [recipe, ingredient];
}

//Event Designed for READING The Elements from API
class ResetOnlineCookBookEvent extends OnlineCookBookEvent {
  const ResetOnlineCookBookEvent(super.recipe, super.ingredient);
}

//Event Designed for READING ⁡⁢⁣⁣𝗥𝗘𝗖𝗜𝗣𝗘⁡ Elements from API
class LoadOnlineRecipeEvent extends OnlineCookBookEvent {
  const LoadOnlineRecipeEvent(super.recipe, super.ingredient);
}

//Event Designed for READING ⁡⁢⁣⁣𝗜𝗡𝗚𝗥𝗘𝗗𝗜𝗘𝗡𝗧⁡ Elements from API
class LoadOnlineIngredientEvent extends OnlineCookBookEvent {
  const LoadOnlineIngredientEvent(super.recipe, super.ingredient);
}

//Event Designed for READING ⁡⁢⁣⁣𝗖𝗔𝗧𝗘𝗚𝗢𝗥𝗬⁡ Elements from API
class LoadOnlineCategoryEvent extends OnlineCookBookEvent {
  const LoadOnlineCategoryEvent(super.recipe, super.ingredient);
}

//Event Designed for CREATING New Elements in API
class AddOnlineCookBookEvent extends OnlineCookBookEvent {
  const AddOnlineCookBookEvent(super.recipe, super.ingredient);
}

// //Event Designed for STREAMING Recipe Elements from API
// class StreamOnlineCookBookEvent extends OnlineCookBookEvent {
//   const StreamOnlineCookBookEvent(super.recipe);
// }

// //Event Designed for DELETING The Elements from API
// class RemoveOnlineCookBookEvent extends OnlineCookBookEvent {
//   const RemoveOnlineCookBookEvent(super.recipe);
// }

// //Event Designed for UPDATING The Elements from API
// class EditOnlineCookBookEvent extends OnlineCookBookEvent {
//   const EditOnlineCookBookEvent(super.recipe);
// }
