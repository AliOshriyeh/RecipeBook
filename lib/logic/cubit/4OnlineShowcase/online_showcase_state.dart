part of 'online_showcase_cubit.dart';

sealed class OnlineShowcaseState extends Equatable {
  final List<Category> categoryList;
  final List<Recipe> randomList;
  const OnlineShowcaseState(this.categoryList, this.randomList);

  @override
  List<Object> get props => [categoryList, randomList];
}

final class OnlineShowcaseInitial extends OnlineShowcaseState {
  const OnlineShowcaseInitial(super.categoryList, super.randomList);
}

final class OnlineShowcaseLoaded extends OnlineShowcaseState {
  const OnlineShowcaseLoaded(super.categoryList, super.randomList);

  @override
  List<Object> get props => [categoryList, randomList];
}
