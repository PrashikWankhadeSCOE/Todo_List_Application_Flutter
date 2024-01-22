import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_list_app/core/go_router_observer.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

final routes = GoRouter(
  navigatorKey: _rootNavigatorKey,
  observers: [
    GoRouterObserver(),
  ],
  initialLocation: '/home/start',
  routes: [
    GoRoute(
      path: '/home/start',
      builder: (context, state) => Container(
        color: Colors.blueGrey,
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () => context.push('/home/settings'),
              child: const Text("Go to Settings"),
            ),
            ElevatedButton(
              onPressed: () => context.push('/home/task'),
              child: const Text("Go to Tasks"),
            ),
            TextButton(
              onPressed: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.push('/home/start');
                }
              },
              child: const Text('Go back'),
            ),
          ],
        ),
      ),
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
              onPressed: () => context.push('/home/start'),
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
              onPressed: () => context.push('/home/start'),
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
