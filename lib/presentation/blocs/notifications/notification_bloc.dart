import 'package:flutter_bloc/flutter_bloc.dart';
import 'notification_event.dart';
import 'notification_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  NotificationsBloc() : super(NotificationsInitial()) {
    on<FetchNotifications>(_onFetchNotifications);
  }

  List<String> notifications = [];
  int offset = 0;
  int limit = 5;
  bool isNextLink = true;

  void _onFetchNotifications(
    FetchNotifications event,
    Emitter<NotificationsState> emit,
  ) async {
    if (isNextLink) {
      try {
        emit(NotificationsLoading());

        final newNotifications =
            await getNotifications(event.offset, event.limit);

        if (newNotifications.isEmpty) {
          isNextLink = false;
        } else if (notifications.length >= 30) {
          isNextLink = false;
        } else {
          offset = event.offset;
          limit = event.limit;
          notifications.addAll(newNotifications);
        }
        emit(NotificationsLoaded(notifications));
      } catch (e) {
        emit(const NotificationsError('Failed to fetch notifications.'));
      }
    }
  }

  Future<List<String>> getNotifications(int page, int limit) async {
    return [
      "String 1",
      "String 2",
      "String 3",
      "String 4",
      "String 5",
      "String 6",
      "String 7",
      "String 8",
      "String 9",
      "String 10"
    ];
  }
}
