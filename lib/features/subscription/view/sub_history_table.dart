import 'package:flutter/material.dart';
import 'package:seller_management/features/subscription/controller/subscription_ctrl.dart';
import 'package:seller_management/main.export.dart';

class SubscriptionHistoryTable extends HookConsumerWidget {
  const SubscriptionHistoryTable({
    super.key,
    required this.subscriptions,
  });

  final PagedItem<SubscriptionInfo> subscriptions;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subsListCtrl =
        useCallback(() => ref.read(subscriptionListCtrlProvider.notifier));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          TR.of(context).subscription_history,
          style: context.textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const Gap(Insets.med),
        Container(
          decoration: BoxDecoration(
            color: context.colors.primary,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Center(
                  child: Text(
                    TR.of(context).date,
                    style: context.onTab
                        ? context.textTheme.bodyLarge!
                            .copyWith(color: context.colors.onPrimary)
                        : context.textTheme.labelMedium!.copyWith(
                            color: context.colors.onPrimary,
                          ),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Center(
                  child: Text(
                    TR.of(context).plan,
                    style: context.onTab
                        ? context.textTheme.bodyLarge!
                            .copyWith(color: context.colors.onPrimary)
                        : context.textTheme.labelMedium!.copyWith(
                            color: context.colors.onPrimary,
                          ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  TR.of(context).total_product,
                  style: context.onTab
                      ? context.textTheme.bodyLarge!
                          .copyWith(color: context.colors.onPrimary)
                      : context.textTheme.labelMedium!.copyWith(
                          color: context.colors.onPrimary,
                        ),
                ),
              ),
            ],
          ),
        ),
        const Gap(Insets.lg),
        ListViewWithFooter(
          shrinkWrap: true,
          pagination: subscriptions.pagination,
          onNext: (url) => subsListCtrl().listByUrl(url),
          onPrevious: (url) => subsListCtrl().listByUrl(url),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: subscriptions.length,
          itemBuilder: (context, index) {
            final data = subscriptions[index];
            return Column(
              children: [
                ExpansionTile(
                  title: Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data.readableTime,
                              style: context.onTab
                                  ? context.textTheme.bodyLarge
                                  : context.textTheme.labelMedium,
                            ),
                            Text(
                              data.date,
                              style: context.onTab
                                  ? context.textTheme.bodyLarge
                                  : context.textTheme.labelMedium,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Center(
                          child: Text(
                            data.plan.name,
                            style: context.onTab
                                ? context.textTheme.bodyLarge
                                : context.textTheme.labelMedium,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Center(
                          child: Text(
                            data.totalProduct.toString(),
                            style: context.onTab
                                ? context.textTheme.bodyLarge
                                : context.textTheme.labelMedium,
                          ),
                        ),
                      ),
                    ],
                  ),
                  trailing: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 20,
                    color: context.colors.primary,
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                '${TR.of(context).expire_date}:',
                                style: context.onTab
                                    ? context.textTheme.bodyLarge!.copyWith(
                                        fontWeight: FontWeight.bold,
                                      )
                                    : context.textTheme.labelMedium!.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                              ),
                              const Gap(Insets.sm),
                              Text(
                                data.expiryDate,
                                style: context.onTab
                                    ? context.textTheme.bodyLarge
                                    : context.textTheme.labelMedium,
                              )
                            ],
                          ),
                          const Gap(Insets.sm),
                          Row(
                            children: [
                              Text(
                                '${TR.of(context).status}:',
                                style: context.onTab
                                    ? context.textTheme.bodyLarge!.copyWith(
                                        fontWeight: FontWeight.bold,
                                      )
                                    : context.textTheme.labelMedium!.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                              ),
                              const Gap(Insets.sm),
                              Container(
                                decoration: BoxDecoration(
                                  color: data.statusColor.withOpacity(.1),
                                  borderRadius: Corners.smBorder,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 5),
                                  child: Text(
                                    data.status,
                                    style: context.onTab
                                        ? context.textTheme.bodyLarge!.copyWith(
                                            color: data.statusColor,
                                          )
                                        : context.textTheme.labelMedium!
                                            .copyWith(
                                            color: data.statusColor,
                                          ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
