import 'package:bloc/bloc.dart';
import 'package:unnamed_budgeting_app/domain/bloc/navigation/navigation_event.dart';
import 'package:unnamed_budgeting_app/domain/bloc/navigation/navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  @override
  NavigationState get initialState => NotNavigatedYet();

  @override
  Stream<NavigationState> mapEventToState(NavigationEvent event) async* {

  }
}
