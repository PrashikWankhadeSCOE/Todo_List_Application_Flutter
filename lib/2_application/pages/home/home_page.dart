import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_list_app/2_application/core/page_config.dart';
import 'package:todo_list_app/2_application/pages/dashboard/dashboard_page.dart';
import 'package:todo_list_app/2_application/pages/detail/todo_detail_page.dart';
import 'package:todo_list_app/2_application/pages/home/bloc/navigation_todo_cubit.dart';
import 'package:todo_list_app/2_application/pages/overview/overview_page.dart';
import 'package:todo_list_app/2_application/pages/settings/settings_page.dart';
// import 'package:todo_list_app/2_application/pages/tasks/tasks_page.dart';

import '../create_todo_collection/create_todo_collection_page.dart';

class HomePageProvider extends StatelessWidget {
  const HomePageProvider({super.key, required this.tab});
  final String tab;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NavigationToDoCubit>(
      create: (_) => NavigationToDoCubit(),
      child: HomePage(tab: tab),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({
    super.key,
    required String tab,
  }) : index = tabs.indexWhere((element) => element.name == tab);

  static const pageconfig = PageConfig(
    icon: Icons.home_outlined,
    name: 'home',
  );

  final int index;

  static const tabs = [
    DashboardPage.pageconfig,
    OverviewPage.pageconfig,
    // TaskPage.pageconfig,
  ];

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final destinations = HomePage.tabs
      .map(
        (page) =>
            NavigationDestination(icon: Icon(page.icon), label: page.name),
      )
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AdaptiveLayout(
          primaryNavigation: SlotLayout(
            config: <Breakpoint, SlotLayoutConfig>{
              Breakpoints.mediumAndUp: SlotLayout.from(
                key: const Key('primary-navigation-medium'),
                builder: (context) => AdaptiveScaffold.standardNavigationRail(
                  leading: IconButton(
                      key: const Key('create-todo-collection'),
                      onPressed: () async {
                        final result = await context.pushNamed(
                            CreateToDoCollectionPage.pageConfig.name);
                        if (result == true) {
                          debugPrint('Item was created successfully');
                        }
                      },
                      icon: Icon(CreateToDoCollectionPage.pageConfig.icon),
                      tooltip: 'Add Collection'),
                  trailing: IconButton(
                    onPressed: () =>
                        context.pushNamed(SettingsPage.pageconfig.name),
                    icon: Icon(SettingsPage.pageconfig.icon),
                  ),
                  onDestinationSelected: (index) =>
                      _tapOnNavigationDestination(context, index),
                  selectedIndex: widget.index,
                  destinations: destinations
                      .map((_) => AdaptiveScaffold.toRailDestination(_))
                      .toList(),
                ),
              ),
            },
          ),
          bottomNavigation: SlotLayout(
            config: <Breakpoint, SlotLayoutConfig>{
              Breakpoints.small: SlotLayout.from(
                key: const Key('Bottom-Navigation_small'),
                builder: (_) => AdaptiveScaffold.standardBottomNavigationBar(
                  currentIndex: widget.index,
                  destinations: destinations,
                  onDestinationSelected: (value) => _tapOnNavigationDestination(
                    context,
                    value,
                  ),
                ),
              ),
            },
          ),
          body: SlotLayout(
            config: <Breakpoint, SlotLayoutConfig>{
              Breakpoints.smallAndUp: SlotLayout.from(
                key: const Key('primary-body-small'),
                builder: (_) => HomePage.tabs[widget.index].child,
              ),
            },
          ),
          secondaryBody: SlotLayout(
            config: <Breakpoint, SlotLayoutConfig>{
              Breakpoints.mediumAndUp: SlotLayout.from(
                key: const Key('Secondary-body'),
                builder: widget.index != 1
                    ? null
                    : (_) => BlocBuilder<NavigationToDoCubit,
                            NavigationToDoCubitState>(
                          builder: (context, state) {
                            final selectedId = state.selectedCollectionId;
                            final isSecondBodyDisplayed =
                                Breakpoints.mediumAndUp.isActive(context);
                            context
                                .read<NavigationToDoCubit>()
                                .secondBodyHasChanged(
                                    isSecondBodyDisplayed:
                                        isSecondBodyDisplayed);
                            if (selectedId == null) {
                              return const Placeholder();
                            }
                            return ToDoDetailPageProvider(
                              key: Key(selectedId.value),
                              collectionId: selectedId,
                            );
                          },
                        ),
              ),
            },
          ),
        ),
      ),
    );
  }

  void _tapOnNavigationDestination(
    BuildContext context,
    int index,
  ) =>
      context.goNamed(
        HomePage.pageconfig.name,
        pathParameters: {
          'tab': HomePage.tabs[index].name,
        },
      );
}
