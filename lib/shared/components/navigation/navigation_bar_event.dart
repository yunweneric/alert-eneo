part of 'navigation_bar_bloc.dart';

@immutable
class NavigationBarEvent {
  final int activeIndex;

  NavigationBarEvent({required this.activeIndex});
}

class NavigationBarChangeIndexEvent extends NavigationBarEvent {
  NavigationBarChangeIndexEvent({required super.activeIndex});
}
