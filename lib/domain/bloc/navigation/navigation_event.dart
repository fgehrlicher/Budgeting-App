abstract class NavigationEvent {}

class NavigateToPageEvent extends NavigationEvent{
  final int targetIndex;
  final int lastIndex;

  NavigateToPageEvent({this.targetIndex, this.lastIndex});
}
