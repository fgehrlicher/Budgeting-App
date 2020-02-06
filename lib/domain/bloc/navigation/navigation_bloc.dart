import 'package:bloc/bloc.dart';
import 'package:unnamed_budgeting_app/domain/bloc/navigation/navigation_event.dart';
import 'package:unnamed_budgeting_app/domain/bloc/navigation/navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  @override
  NavigationState get initialState => NotNavigatedYet();

  @override
  Stream<NavigationState> mapEventToState(NavigationEvent event) async* {
    if (event is NavigateToPage) {
      yield* _mapNavigateToPageToState(event);
    }
  }

  Stream<NavigationState> _mapNavigateToPageToState(
    NavigateToPage event,
  ) async* {
    if (event.lastScreen == event.targetScreen) {
      yield SamePage();
    } else {
      yield NewPage();
    }
  }
}
