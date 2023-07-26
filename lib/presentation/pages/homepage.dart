import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterbasesetup/presentation/pages/notification/notifications_screen.dart';

import '../blocs/homepage/homepage_bloc.dart';
import '../blocs/homepage/homepage_event.dart';
import '../blocs/homepage/homepage_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider<NavigationBloc>(
            create: (context) => NavigationBloc(),
          ),
        ],
        child: const HomePageManager(),
      ),
    );
  }
}

class HomePageManager extends StatelessWidget {
  const HomePageManager({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return Scaffold(
          body: _buildCurrentScreen(state.currentIndex),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: state.currentIndex,
            onTap: (index) {
              var navigationEvent;
              if (index == 0) {
                navigationEvent = NavigationEvent.screenOneSelected;
              } else if (index == 1) {
                navigationEvent = NavigationEvent.screenTwoSelected;
              } else if (index == 2) {
                navigationEvent = NavigationEvent.screenThreeSelected;
              }

              context.read<NavigationBloc>().add(navigationEvent);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Person',
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCurrentScreen(int currentIndex) {
    switch (currentIndex) {
      case 0:
        return const MyNotificationsScreen();
      case 1:
        return const MyNotificationsScreen();
      case 2:
        return const MyNotificationsScreen();
      default:
        return const MyNotificationsScreen();
    }
  }
}
