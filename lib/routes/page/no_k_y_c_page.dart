import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:seller_management/main.export.dart';
import 'package:seller_management/routes/routes.dart';

class NoKYCPage extends HookConsumerWidget {
  const NoKYCPage({super.key});

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
              Text(
                'KYC verification needed',
                style: context.textTheme.titleLarge,
              ),
              Text(
                'Please apply for KYC verification',
                style: context.textTheme.titleMedium,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: FilledButton.icon(
                      style: OutlinedButton.styleFrom(
                        fixedSize: const Size.fromHeight(50),
                      ),
                      onPressed: () async {
                        RouteNames.verifyKyc.goNamed(context);
                      },
                      icon: const Icon(Icons.verified_user_outlined),
                      label: Text(TR.of(context).verifyKyc),
                    ),
                  ),
                  const Gap(Insets.def),
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      fixedSize: const Size.fromHeight(50),
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
