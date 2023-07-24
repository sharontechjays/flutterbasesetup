abstract class NotificationsEvent {}

class FetchNotifications extends NotificationsEvent {
  final int page;
  final int limit;

  FetchNotifications(this.page, this.limit);
}
