import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:seller_management/features/withdraw/controller/withdraw_ctrl.dart';

import '../../../../main.export.dart';

class WithdrawLog extends ConsumerWidget {
  const WithdrawLog({
    super.key,
    required this.searchCtrl,
    required this.withdrawCtrl,
    required this.withdrawList,
  });

  final TextEditingController searchCtrl;
  final WithdrawListCtrlNotifier Function() withdrawCtrl;
  final AsyncValue<PagedItem<WithdrawData>> withdrawList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(Insets.lg),
        Padding(
          padding: Insets.padH,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              TR.of(context).all_withdraw,
              style: context.textTheme.titleLarge,
            ),
          ),
        ),
        const Gap(Insets.lg),
        Padding(
          padding: Insets.padH,
          child: Row(
            children: [
              Flexible(
                child: TextField(
                  controller: searchCtrl,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: IconButton(
                      onPressed: () {
                        searchCtrl.clear();
                        withdrawCtrl().reload();
                      },
                      icon: const Icon(Icons.clear),
                    ),
                    hintText: TR.of(context).search_by_trx_id,
                    border: const OutlineInputBorder(),
                  ),
                  onChanged: (value) => withdrawCtrl().search(value),
                ),
              ),
              IconButton.filled(
                onPressed: () async {
                  final range = await showDateRangePicker(
                    context: context,
                    firstDate: DateTime(1950),
                    lastDate: DateTime.now().add(30.days),
                  );
                  withdrawCtrl().searchWithDateRange(range);
                },
                icon: const Icon(Icons.calendar_month_rounded),
              ),
            ],
          ),
        ),
        const Gap(Insets.med),
        withdrawList.when(
          loading: Loader.list,
          error: ErrorView.new,
          data: (data) => ListViewWithFooter(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            pagination: data.pagination,
            onNext: (url) => withdrawCtrl().listByUrl(url),
            onPrevious: (url) => withdrawCtrl().listByUrl(url),
            itemCount: data.length,
            itemBuilder: (context, index) {
              final item = data[index];
              return Container(
                decoration: BoxDecoration(
                  color: context.colors.onPrimaryContainer,
                ),
                margin: Insets.padH.copyWith(bottom: 10),
                padding: Insets.padAll,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                  text: '${TR.of(context).receivable}: ',
                                  style: context.textTheme.bodyLarge),
                              TextSpan(
                                text: item.finalAmount
                                    .formate(currency: item.currency),
                                style: context.textTheme.bodyLarge!.copyWith(
                                  color: context.colors.errorContainer,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Clipper.copy(item.trxNo),
                          child: Text(
                            item.trxNo,
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
                                  text: 'Amount: ',
                                  style: context.textTheme.bodyLarge),
                              TextSpan(
                                text: item.amount.formate(useBase: true),
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
                                text: item.charge.formate(useBase: true),
                                style: context.textTheme.bodyLarge!.copyWith(
                                  color: context.colors.error,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Gap(Insets.med),
                    Row(
                      mainAxisAlignment: item.feedback.isNotEmpty
                          ? MainAxisAlignment.spaceBetween
                          : MainAxisAlignment.end,
                      children: [
                        if (item.feedback.isNotEmpty)
                          Text(
                            '${TR.of(context).note}: ${item.feedback}',
                            style: context.textTheme.bodyLarge,
                          ),
                        Container(
                          decoration: BoxDecoration(
                            color: item.statusColor.withOpacity(.1),
                            borderRadius: Corners.smBorder,
                          ),
                          padding: Insets.padSym(5, 10),
                          child: Text(
                            item.status,
                            style: context.textTheme.labelMedium!.copyWith(
                              color: item.statusColor,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
