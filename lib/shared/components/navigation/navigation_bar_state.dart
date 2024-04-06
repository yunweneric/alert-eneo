part of 'navigation_bar_bloc.dart';

class NavigationBarState {
  int activeIndex;
  NavigationBarState({required this.activeIndex});
}

class NavigationBarInitial extends NavigationBarState {
  NavigationBarInitial({required super.activeIndex});
}

class NavigationBarChangeIndexState extends NavigationBarState {
  NavigationBarChangeIndexState({required super.activeIndex});
}
