abstract class NavigationEvent {}

class NavigateToPage extends NavigationEvent{
  final int targetIndex;
  final int lastIndex;

  NavigateToPage({this.targetIndex, this.lastIndex});
}
