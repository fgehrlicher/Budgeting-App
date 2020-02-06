abstract class NavigationEvent {}

class NavigateToPage extends NavigationEvent{
  final String targetScreen;
  final String lastScreen;

  NavigateToPage({this.targetScreen, this.lastScreen});
}
