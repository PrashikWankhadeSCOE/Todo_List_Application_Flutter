import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_list_app/2_application/core/go_router_observer.dart';
import 'package:todo_list_app/2_application/pages/home/home_page.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

final routes = GoRouter(
  navigatorKey: _rootNavigatorKey,
  observers: [
    GoRouterObserver(),
  ],
  initialLocation: '/home',
  routes: [
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/home/settings',
      builder: (context, state) => Container(
        height: 100,
        width: 100,
        color: Colors.amber,
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () => context.push('/home'),
              child: const Text('Go back to StartButton'),
            ),
            TextButton(
              onPressed: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.push('/home/settings');
                }
              },
              child: const Text('Go back'),
            ),
          ],
        ),
      ),
    ),
    GoRoute(
      path: '/home/task',
      builder: (context, state) => Container(
        color: Colors.pink,
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () => context.push('/home'),
              child: const Text('Start'),
            ),
            ElevatedButton(
              onPressed: () => context.push('/home/settings'),
              child: const Text('Setting'),
            ),
            TextButton(
                onPressed: () {
                  if (context.canPop()) {
                    context.pop();
                  } else {
                    context.push('/home/task');
                  }
                },
                child: const Text('go back')),
          ],
        ),
      ),
    ),
  ],
);
