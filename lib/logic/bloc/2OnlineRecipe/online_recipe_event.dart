part of 'online_recipe_bloc.dart';

sealed class OnlineRecipeEvent extends Equatable {
  final Recipe recipe;
  const OnlineRecipeEvent(this.recipe);

  @override
  List<Object> get props => [recipe];
}

//Event Designed for READING The Elements from API
class InitOnlineRecipeEvent extends OnlineRecipeEvent {
  const InitOnlineRecipeEvent(super.recipe);
}

//Event Designed for READING The Elements from API
class LoadOnlineRecipeEvent extends OnlineRecipeEvent {
  const LoadOnlineRecipeEvent(super.recipe);
}

//Event Designed for READING The Elements from API
class StreamOnlineRecipeEvent extends OnlineRecipeEvent {
  const StreamOnlineRecipeEvent(super.recipe);
}

// //Event Designed for CREATING New Elements in API
// class AddOnlineRecipeEvent extends OnlineRecipeEvent {
//   const AddOnlineRecipeEvent(super.recipe);
// }

// //Event Designed for DELETING The Elements from API
// class RemoveOnlineRecipeEvent extends OnlineRecipeEvent {
//   const RemoveOnlineRecipeEvent(super.recipe);
// }

// //Event Designed for UPDATING The Elements from API
// class EditOnlineRecipeEvent extends OnlineRecipeEvent {
//   const EditOnlineRecipeEvent(super.recipe);
// }
