import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/notifications/notification_bloc.dart';
import '../../blocs/notifications/notification_event.dart';
import '../../blocs/notifications/notification_state.dart';

class MyNotificationsScreen extends StatefulWidget {
  const MyNotificationsScreen({Key? key}) : super(key: key);

  @override
  _MyNotificationsScreenState createState() => _MyNotificationsScreenState();
}

class _MyNotificationsScreenState extends State<MyNotificationsScreen>
    with WidgetsBindingObserver {
  late ScrollController _scrollController;
  late NotificationsBloc _notificationsBloc;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _init();
  }

  _init() {
    _scrollController = ScrollController();
    _notificationsBloc = NotificationsBloc();
    _scrollController.addListener(_onScroll);
    _notificationsBloc.add(FetchNotifications(
        _notificationsBloc.offset, _notificationsBloc.limit));
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _scrollController.dispose();
    _notificationsBloc.close();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(final AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _onRefresh();
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (_notificationsBloc.isNextLink) {
        _notificationsBloc.offset =
            _notificationsBloc.offset + _notificationsBloc.limit;
        _notificationsBloc.add(FetchNotifications(
            _notificationsBloc.offset, _notificationsBloc.limit));
      }
    }
  }

  Future<void> _onRefresh() async {
    _notificationsBloc.offset = 0;
    _notificationsBloc.notifications.clear();
    _notificationsBloc.isNextLink = true;
    _notificationsBloc.add(FetchNotifications(
        _notificationsBloc.offset, _notificationsBloc.limit));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NotificationsBloc>(
      create: (context) => _notificationsBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Notifications'),
        ),
        body: RefreshIndicator(
          onRefresh: _onRefresh,
          child: BlocBuilder<NotificationsBloc, NotificationsState>(
            builder: (context, state) {
              if (state is NotificationsLoading &&
                  _notificationsBloc.isNextLink) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is NotificationsLoaded) {
                return ListView.separated(
                  controller: _scrollController,
                  itemCount: state.notifications.length +
                      (_notificationsBloc.isNextLink ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index < state.notifications.length) {
                      final notification = state.notifications[index];
                      return ListTile(
                        title: Text("$notification>>$index"),
                      );
                    } else if (_notificationsBloc.offset == 0 &&
                        state.notifications.isEmpty) {
                      return const SizedBox();
                    } else {
                      return const SizedBox();
                    }
                  },
                  separatorBuilder: (context, index) => const Divider(),
                );
              } else if (state is NotificationsError) {
                return Center(child: Text(state.message));
              } else if (state is NotificationEmpty) {
                return Center(child: Text(state.message));
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}
