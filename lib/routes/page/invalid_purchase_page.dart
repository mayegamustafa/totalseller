import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:seller_management/main.export.dart';

class InvalidPurchasePage extends HookConsumerWidget {
  const InvalidPurchasePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: Insets.padAll,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                AssetsConst.warning,
                height: 100,
              ),
              const SizedBox(height: 20),
              Text(
                'Your software is not installed yet',
                style: context.textTheme.titleLarge,
              ),
              Text(
                'Please contact your admin',
                style: context.textTheme.titleMedium,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      fixedSize: const Size(150, 50),
                    ),
                    onPressed: () async {
                      final statusCtrl =
                          ref.read(serverStatusProvider.notifier);

                      await statusCtrl.retryStatusResolver();
                    },
                    icon: const Icon(Icons.refresh_rounded),
                    label: Text(TR.of(context).retry),
                  ),
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      fixedSize: const Size(150, 50),
                    ),
                    onPressed: () => exit(0),
                    icon: const Icon(Icons.exit_to_app_rounded),
                    label: Text(TR.of(context).exit),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
