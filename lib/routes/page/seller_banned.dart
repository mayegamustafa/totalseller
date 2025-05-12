import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:seller_management/main.export.dart';
import 'package:seller_management/routes/routes.dart';

class SellerBanned extends ConsumerWidget {
  const SellerBanned({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              AssetsConst.warning,
              height: 250,
            ),
            Text(
              TR.of(context).yourShopIsBanned,
              style: context.textTheme.headlineSmall,
            ),
            Text(
              TR.of(context).contactAdmin,
              style: context.textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: () => RouteNames.createTicket.pushNamed(context),
              child: Text(TR.of(context).createTicket),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () => RouteNames.home.go(context),
              child: Text(TR.of(context).goToHome),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
