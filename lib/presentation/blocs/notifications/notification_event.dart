abstract class NotificationsEvent {}

class FetchNotifications extends NotificationsEvent {
  final int offset;
  final int limit;

  FetchNotifications(this.offset, this.limit);
}
