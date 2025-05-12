import 'package:flutter/material.dart';
import 'package:seller_management/main.export.dart';
import 'package:seller_management/routes/go_route_name.dart';

class NoSubPage extends ConsumerWidget {
  const NoSubPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Your shop does not have any active subscription',
              style: context.textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              TR.of(context).subscribeToAddProduct,
              style: context.textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            SubmitButton.dense(
              onPressed: (l) async {
                RouteNames.planUpdate.goNamed(context);
              },
              child: Text(TR.of(context).subscribeNow),
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
