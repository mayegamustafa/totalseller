import 'package:flutter/material.dart';
import 'package:seller_management/features/total_balance/controller/total_balance_ctrl.dart';

import '../../../../main.export.dart';

class BalanceTransactionLog extends HookConsumerWidget {
  const BalanceTransactionLog({
    super.key,
    required this.transactions,
    this.pagination,
  });

  final List<TransactionData> transactions;
  final PaginationInfo? pagination;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactionCtrl =
        useCallback(() => ref.read(transactionCtrlProvider.notifier));
    return ListViewWithFooter(
      pagination: pagination,
      onNext: (url) => transactionCtrl().listByUrl(url),
      onPrevious: (url) => transactionCtrl().listByUrl(url),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        var transaction = transactions[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: Corners.medBorder,
              color: context.colors.onPrimaryContainer,
            ),
            child: Padding(
              padding: Insets.padAll,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Clipper.copy(transaction.trxId),
                        child: Text(
                          transaction.trxId,
                          style: context.textTheme.bodyLarge,
                        ),
                      ),
                      Text(
                        transaction.formattedAmount,
                        style: context.textTheme.bodyLarge!.copyWith(
                          color: transaction.amountColor,
                        ),
                      ),
                    ],
                  ),
                  const Gap(Insets.sm),
                  Text(
                    '${TR.of(context).post_balance}: ${transaction.postBalance.formate()}',
                    style: context.textTheme.bodyLarge!.copyWith(),
                  ),
                  const Gap(Insets.med),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          '${TR.of(context).details}: ${transaction.details}',
                          style: context.textTheme.bodyLarge!.copyWith(
                            color: context.colors.onSurface.withOpacity(.7),
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            transaction.readableTime,
                            style: TextStyle(
                              color: context.colors.onSurface.withOpacity(.7),
                            ),
                          ),
                          Text(
                            transaction.date,
                            style: TextStyle(
                              color: context.colors.onSurface.withOpacity(.7),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
