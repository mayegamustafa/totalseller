import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:seller_management/main.export.dart';
import 'package:seller_management/routes/go_route_name.dart';

import '../controller/subscription_ctrl.dart';
import 'local/plan_loder.dart';
import 'sub_history_table.dart';

class SubscriptionView extends HookConsumerWidget {
  const SubscriptionView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final picked = useState<DateTimeRange?>(null);
    final subscriptions = ref.watch(subscriptionListCtrlProvider);
    final firstTime = useState(false);
    final reload = useState(false);

    Future<void> checkIfFirst() async {
      final data = await ref.read(isFirstSubscriptionProvider.future);
      firstTime.value = data;
    }

    useEffect(() {
      checkIfFirst();
      return null;
    }, [reload.value]);

    Future<void> filterList() async {
      await ref.read(subscriptionListCtrlProvider.notifier).filter(picked.value);
    }

    Future<DateTimeRange?> dateTimeRangePicker() async {
      return showDateRangePicker(
        context: context,
        firstDate: DateTime(2020),
        lastDate: DateTime(DateTime.now().year + 2),
        builder: (_, child) {
          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 350, maxHeight: 500),
              child: child!,
            ),
          );
        },
      );
    }

    return subscriptions.when(
      error: (e, s) => Scaffold(body: ErrorView(e, s)),
      loading: () => const Scaffold(body: PlanLoader()),
      data: (subs) {
        return Scaffold(
          appBar: KAppBar(
            leading: IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.arrow_back),
            ),
            title: Text(TR.of(context).subscription),
            actions: [
              if (!firstTime.value)
                TextButton.icon(
                  style: TextButton.styleFrom(
                    foregroundColor: context.colors.onPrimary,
                  ),
                  onPressed: () => RouteNames.planUpdate.pushNamed(context, query: {'toBuy': 'false'}),
                  icon: const Icon(Icons.add),
                  label: Text(
                    TR.of(context).plan_update,
                    style: context.textTheme.bodyLarge!.copyWith(color: context.colors.onSurface),
                  ),
                ),
            ],
            bottom: PreferredSize(
              preferredSize: const Size(double.infinity, 20),
              child: Padding(
                padding: Insets.padH,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: TextFormField(
                            onTap: () async {
                              picked.value = await dateTimeRangePicker();
                              filterList();
                            },
                            readOnly: true,
                            decoration: InputDecoration(
                              fillColor: context.colors.onPrimary,
                              hintText: picked.value != null
                                  ? '${picked.value!.start.formatDate()} - ${picked.value!.end.formatDate()}'
                                  : TR.of(context).search_by_date,
                            ),
                          ),
                        ),
                        if (picked.value != null) ...[
                          const Gap(Insets.med),
                          IconButton(
                            onPressed: () {
                              picked.value = null;
                              filterList();
                            },
                            icon: const Icon(Icons.clear_rounded),
                          ),
                        ],
                      ],
                    ),
                    const Gap(Insets.lg),
                  ],
                ),
              ),
            ),
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              ref.read(subscriptionListCtrlProvider.notifier).reload();
              reload.value = !reload.value;
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: Insets.padAll,
              child: Column(
                children: [
                  if (firstTime.value) ...[
                    const Gap(Insets.offset),
                    Text(
                      TR.of(context).do_not_have_any_subscription,
                      style: context.textTheme.titleLarge,
                    ),
                    const Gap(Insets.lg),
                    SubmitButton(
                      onPressed: (l) => RouteNames.planUpdate.pushNamed(context),
                      child: Text(TR.of(context).subscribe_now),
                    )
                  ] else
                    SubscriptionHistoryTable(subscriptions: subs)
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
