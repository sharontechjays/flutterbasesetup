import 'package:flutter/material.dart';
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
        offset = event.offset;
        limit = event.limit;
        final newNotifications =
            await getNotifications(event.offset, event.limit);
        debugPrint("offset-->$offset");
        if (isNextLink && newNotifications.isNotEmpty) {
          notifications.addAll(newNotifications);
        }
        if (offset >= 30) {
          isNextLink = false;
        }
        emit(NotificationsLoaded(notifications));
        if (newNotifications.isEmpty && offset == 0) {
          emit(const NotificationEmpty("No Notifications"));
        }
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
      "String 10",
      "String 11",
      "String 12",
      "String 13",
      "String 14",
      "String 15",
      "String 16",
      "String 17",
      "String 18",
      "String 19",
      "String 20",
    ];
  }
}
