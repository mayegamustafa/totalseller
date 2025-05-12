import 'package:flutter/material.dart';
import 'package:seller_management/features/settings/controller/auth_config_ctrl.dart';
import 'package:seller_management/main.export.dart';

class KYCView extends ConsumerWidget {
  const KYCView(this.kyc, {super.key});

  final KYCLog kyc;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TR.of(context).kycDetails),
      ),
      body: SingleChildScrollView(
        padding: Insets.padAll,
        child: Column(
          children: [
            ShadowContainer(
              padding: Insets.padAll,
              child: SeparatedColumn(
                separatorBuilder: () => const Divider(height: 25),
                children: [
                  SpacedText(
                    left: 'Date',
                    styleBuilder: (left, right) => (
                      context.textTheme.titleMedium,
                      context.textTheme.titleMedium!.bold,
                    ),
                    right: kyc.readableTime,
                  ),
                  SpacedText(
                    left: 'Status',
                    right: kyc.statusConfig.$1,
                    styleBuilder: (left, right) => (
                      context.textTheme.titleMedium,
                      context.textTheme.titleMedium!.bold
                          .textColor(kyc.statusConfig.$2),
                    ),
                  ),
                  SpacedText(
                    left: 'FeedBack',
                    right: kyc.feedback ?? 'N/A',
                    styleBuilder: (left, right) => (
                      context.textTheme.titleMedium,
                      context.textTheme.titleMedium!.bold,
                    ),
                  ),
                ],
              ),
            ),
            const Gap(Insets.lg),
            ShadowContainer(
              padding: Insets.padAll,
              child: SeparatedColumn(
                separatorBuilder: () => const Divider(height: 25),
                children: [
                  for (var data in kyc.kyc.data.entries)
                    SpacedText(
                      left: data.key,
                      right: data.value,
                      styleBuilder: (left, right) => (
                        context.textTheme.titleMedium,
                        context.textTheme.titleMedium!.bold,
                      ),
                    ),
                ],
              ),
            ),
            const Gap(Insets.lg),
            ShadowContainer(
              padding: Insets.padAll,
              child: SeparatedColumn(
                separatorBuilder: () => const Divider(height: 25),
                children: [
                  for (var data in kyc.kyc.files.entries)
                    Row(
                      children: [
                        Text(data.key, style: context.textTheme.titleMedium),
                        const Gap(Insets.med),
                        const Spacer(),
                        HostedImage.square(
                          data.value,
                          dimension: 100,
                          enablePreviewing: true,
                        ),
                      ],
                    ),
                ],
              ),
            ),
            const Gap(Insets.def),
            FilledButton.icon(
              style: OutlinedButton.styleFrom(
                fixedSize: const Size.fromHeight(50),
              ),
              onPressed: () async {
                final test = ref.refresh(authConfigCtrlProvider);
                test.when(
                  data: (d) {
                    ref.read(serverStatusProvider.notifier).update(200);
                  },
                  error: (e, s) => Toaster.showError(e),
                  loading: () {},
                );
              },
              icon: const Icon(Icons.arrow_forward_rounded),
              label: Text(TR.of(context).goToHome),
            ),
            const Gap(Insets.def),
          ],
        ),
      ),
    );
  }
}
