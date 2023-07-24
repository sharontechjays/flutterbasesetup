import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/notification_event.dart';
import '../../bloc/notification_state.dart';
import '../../bloc/notififcation_bloc.dart';

class MyNotificationsScreen extends StatefulWidget {
  const MyNotificationsScreen({super.key});

  @override
  _MyNotificationsScreenState createState() => _MyNotificationsScreenState();
}

class _MyNotificationsScreenState extends State<MyNotificationsScreen> {
  late ScrollController _scrollController;
  late NotificationsBloc _notificationsBloc;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _notificationsBloc = NotificationsBloc();
    _scrollController.addListener(_onScroll);
    _notificationsBloc.add(
        FetchNotifications(_notificationsBloc.page, _notificationsBloc.limit));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _notificationsBloc.close();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (_notificationsBloc.isNextLink) {
        final nextPage = _notificationsBloc.page + 1;
        _notificationsBloc
            .add(FetchNotifications(nextPage, _notificationsBloc.limit));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _notificationsBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Notifications'),
        ),
        body: BlocBuilder<NotificationsBloc, NotificationsState>(
          builder: (context, state) {
            if (state is NotificationsLoading &&
                _notificationsBloc.notifications.isEmpty) {
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
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
                separatorBuilder: (context, index) => const Divider(),
              );
            } else if (state is NotificationsError) {
              return Center(child: Text(state.message));
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
