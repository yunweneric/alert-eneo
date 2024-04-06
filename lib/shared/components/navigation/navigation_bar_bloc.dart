import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'navigation_bar_event.dart';
part 'navigation_bar_state.dart';

class NavigationBarBloc extends Bloc<NavigationBarEvent, NavigationBarState> {
  int activeIndex = 1;
  NavigationBarBloc() : super(NavigationBarInitial(activeIndex: 1)) {
    on<NavigationBarChangeIndexEvent>((event, emit) {
      activeIndex = event.activeIndex;
      emit(NavigationBarChangeIndexState(activeIndex: event.activeIndex));
    });
  }
}
