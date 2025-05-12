import 'package:flutter/material.dart';
import 'package:seller_management/features/kyc/controller/kyc_ctrl.dart';
import 'package:seller_management/features/kyc/view/kyc_view.dart';
import 'package:seller_management/main.export.dart';

class KYCLogsView extends ConsumerWidget {
  const KYCLogsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logsData = ref.watch(kycLogsProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(TR.of(context).kycLogs),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(kycLogsProvider);
        },
        child: logsData.when(
          loading: Loader.list,
          error: ErrorView.new,
          data: (logs) {
            if (logs.isEmpty) return const Center(child: NoItemWidget());

            return ListView.separated(
              itemCount: logs.length,
              padding: Insets.padAll,
              separatorBuilder: (_, __) => const Gap(Insets.def),
              itemBuilder: (context, index) {
                final log = logs[index];
                return Card(
                  child: ListTile(
                    onTap: () {
                      context.nPush(KYCView(log));
                    },
                    title: Text(log.readableTime),
                    subtitle: Text(log.date),
                    trailing: DecoratedContainer(
                      color: log.statusConfig.$2.withOpacity(.1),
                      padding: Insets.padSym(3, 8),
                      borderRadius: Corners.med,
                      child: Text(
                        log.statusConfig.$1,
                        style: context.textTheme.titleMedium
                            ?.textColor(log.statusConfig.$2),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
