import 'package:flutter/material.dart';
import 'package:seller_management/main.export.dart';
import 'package:seller_management/routes/go_route_name.dart';

class HomeDrawer extends ConsumerWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: Padding(
        padding: Insets.padH,
        child: Column(
          children: [
            const Gap(80),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AssetsConst.logo,
                  height: 40,
                ),
                const Gap(Insets.med),
                Text(
                  TR.of(context).seller_center,
                  style: context.textTheme.bodyLarge,
                )
              ],
            ),
            const Gap(Insets.lg),
            const Divider(),
            const Gap(Insets.offset),
            ListTile(
              tileColor: context.colors.onPrimaryContainer,
              onTap: () => RouteNames.accountSettings.pushNamed(context),
              title: Text(
                TR.of(context).profile,
                style: context.textTheme.bodyLarge!.copyWith(
                  color: context.colors.primary,
                ),
              ),
            ),
            const Gap(Insets.med),
            ListTile(
              tileColor: context.colors.onPrimaryContainer,
              onTap: () => RouteNames.storeInformation.pushNamed(context),
              title: Text(
                TR.of(context).store_info,
                style: context.textTheme.bodyLarge!.copyWith(
                  color: context.colors.primary,
                ),
              ),
            ),
            const Gap(Insets.med),
            ListTile(
              tileColor: context.colors.onPrimaryContainer,
              onTap: () => RouteNames.deposit.pushNamed(context),
              title: Text(
                'Deposit',
                style: context.textTheme.bodyLarge!.copyWith(
                  color: context.colors.primary,
                ),
              ),
            ),
            const Gap(Insets.med),
            ListTile(
              tileColor: context.colors.onPrimaryContainer,
              onTap: () => RouteNames.withdraw.goNamed(context),
              title: Text(
                TR.of(context).withdraw,
                style: context.textTheme.bodyLarge!.copyWith(
                  color: context.colors.primary,
                ),
              ),
            ),
            const Gap(Insets.med),
            ListTile(
              tileColor: context.colors.onPrimaryContainer,
              onTap: () => RouteNames.updatePass.goNamed(context),
              title: Text(
                TR.of(context).change_password,
                style: context.textTheme.bodyLarge!.copyWith(
                  color: context.colors.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
