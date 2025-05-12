import 'package:flutter/material.dart';
import 'package:seller_management/main.export.dart';

import '../../controller/deposit_ctrl.dart';

class DepositLogView extends HookConsumerWidget {
  const DepositLogView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final depositList = ref.watch(depositLogsCtrlProvider);
    final depositCtrl =
        useCallback(() => ref.read(depositLogsCtrlProvider.notifier));
    return depositList.when(
      loading: Loader.list,
      error: ErrorView.new,
      data: (data) => ListViewWithFooter(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        pagination: data.pagination,
        onNext: (url) => depositCtrl().listByUrl(url),
        onPrevious: (url) => depositCtrl().listByUrl(url),
        itemCount: data.length,
        itemBuilder: (context, index) {
          final item = data[index];
          return Container(
            margin: Insets.padH.copyWith(bottom: 10),
            padding: Insets.padAll,
            decoration: BoxDecoration(
              color: context.colors.onPrimaryContainer,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.paymentMethod.name,
                      style: context.textTheme.bodyLarge,
                    ),
                    GestureDetector(
                      onTap: () => Clipper.copy(item.trxNumber),
                      child: Text(
                        item.trxNumber,
                        style: context.textTheme.bodyLarge,
                      ),
                    ),
                  ],
                ),
                const Gap(Insets.sm),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                              text: '${TR.of(context).amount}: ',
                              style: context.textTheme.bodyLarge),
                          TextSpan(
                            text: item.amount,
                            style: context.textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                              text: '${TR.of(context).charge}: ',
                              style: context.textTheme.bodyLarge),
                          TextSpan(
                            text: item.charge,
                            style: context.textTheme.bodyLarge!.copyWith(
                              color: context.colors.error,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Gap(Insets.sm),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Payable: ${item.payable}',
                      style: context.textTheme.bodyLarge,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: item.status.color.withOpacity(.1),
                        borderRadius: Corners.smBorder,
                      ),
                      padding: Insets.padSym(3, 8),
                      child: Text(
                        item.status.name.titleCaseSingle,
                        style: context.textTheme.bodyMedium!.copyWith(
                          color: item.status.color,
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(Insets.sm),
                Row(
                  mainAxisAlignment: item.feedback != null
                      ? MainAxisAlignment.spaceBetween
                      : MainAxisAlignment.end,
                  children: [
                    if (item.feedback != null)
                      Flexible(
                        child: Text(
                          '${TR.of(context).note}: ${item.feedback}',
                          style: TextStyle(
                            color: context.colors.error,
                          ),
                        ),
                      ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(item.readableTime),
                        Text(item.dateTime),
                      ],
                    )
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
