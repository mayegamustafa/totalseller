import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:seller_management/main.export.dart';
import 'package:seller_management/routes/go_route_name.dart';

import 'nav_button.dart';
import 'nav_destination.dart';

class NavigationRoot extends HookConsumerWidget {
  const NavigationRoot(this.child, {super.key});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rootPath = GoRouterState.of(context).uri.pathSegments.first;
    final int getIndex =
        RouteNames.nestedRoutes.map((e) => e.name).toList().indexOf(rootPath);

    final index = useState(0);

    useEffect(() {
      index.value = getIndex;
      return null;
    }, [rootPath]);

    return Scaffold(
      extendBody: true,
      body: child,
      bottomNavigationBar: context.onTab
          ? null
          : Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: context.colors.onPrimaryContainer,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 5,
                    color: context.colors.secondaryContainer.withOpacity(0.1),
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: NavigationBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                selectedIndex: index.value,
                height: 70,
                destinations: [
                  for (var i = 0; i < _destinations(context).length; i++)
                    NavButton(
                      count: 1,
                      destination: _destinations(context)[i],
                      index: i,
                      selectedIndex: index.value,
                      onPressed: () {
                        index.value = i;
                        RouteNames.nestedRoutes[i].push(context);
                      },
                    ),
                ],
              ),
            ),
    );
  }

  List<KNavDestination> _destinations(BuildContext ctx) => [
        KNavDestination(
          icon: AssetsConst.home,
          selectIcon: AssetsConst.homeFill,
          title: TR.current.home,
        ),
        KNavDestination(
          icon: AssetsConst.order,
          selectIcon: AssetsConst.orderFill,
          title: TR.current.order,
        ),
        KNavDestination(
          isHighlight: true,
          icon: AssetsConst.product,
          title: TR.current.product,
        ),
        KNavDestination(
          icon: AssetsConst.sms,
          selectIcon: AssetsConst.smsFill,
          title: TR.current.massage,
        ),
        KNavDestination(
          icon: AssetsConst.profile,
          selectIcon: AssetsConst.profileFill,
          title: 'Me',
        ),
      ];
}
