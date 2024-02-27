import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_list_app/1_domain/entities/unique_id.dart';
import 'package:todo_list_app/2_application/core/go_router_observer.dart';
import 'package:todo_list_app/2_application/pages/create_todo_collection/create_todo_collection_page.dart';
import 'package:todo_list_app/2_application/pages/dashboard/dashboard_page.dart';
import 'package:todo_list_app/2_application/pages/detail/todo_detail_page.dart';
import 'package:todo_list_app/2_application/pages/home/home_page.dart';
import 'package:todo_list_app/2_application/pages/overview/overview_page.dart';
import 'package:todo_list_app/2_application/pages/settings/settings_page.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

const String _basePath = '/home';

final routes = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '$_basePath/${DashboardPage.pageconfig.name}',
  observers: [GoRouterObserver()],
  routes: [
    GoRoute(
      name: SettingsPage.pageconfig.name,
      path: '$_basePath/${SettingsPage.pageconfig.name}',
      builder: (context, state) => const SettingsPage(),
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => child,
      routes: [
        GoRoute(
          name: HomePage.pageconfig.name,
          path: '$_basePath/:tab',
          builder: (context, state) => HomePage(
            key: state.pageKey,
            tab: state.pathParameters['tab']!,
          ),
        ),
      ],
    ),
    GoRoute(
      name: CreateToDoCollectionPage.pageConfig.name,
      path: '$_basePath/overvier/${CreateToDoCollectionPage.pageConfig.name}',
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('create collection'),
            leading: BackButton(
              onPressed: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.goNamed(
                    HomePage.pageconfig.name,
                    pathParameters: {'tab': OverviewPage.pageconfig.name},
                  );
                }
              },
            ),
          ),
          body: SafeArea(
            child: CreateToDoCollectionPage.pageConfig.child,
          ),
        );
      },
    ),
    GoRoute(
      name: ToDoDetailPage.pageConfig.name,
      path: '$_basePath/overview/:collectionId',
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('details'),
            leading: BackButton(
              onPressed: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.goNamed(
                    HomePage.pageconfig.name,
                    pathParameters: {'tab': OverviewPage.pageconfig.name},
                  );
                }
              },
            ),
          ),
          body: ToDoDetailPageProvider(
              collectionId: CollectionId.fromUniqueString(
                  state.pathParameters['collectionId'] ?? '')),
        );
      },
    )
  ],
);
