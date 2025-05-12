import 'package:flutter/material.dart';
import 'package:seller_management/main.export.dart';
import 'package:seller_management/routes/go_route_name.dart';

class DepositAppbar extends StatelessWidget {
  const DepositAppbar({
    super.key,
    required this.dashBoard,
  });

  final AsyncValue<Dashboard> dashBoard;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.primary,
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          const Gap(50),
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back, color: context.colors.onPrimary),
              ),
              Text(
                'Deposit',
                style: context.textTheme.titleLarge!.copyWith(
                  color: context.colors.onPrimary,
                ),
              ),
            ],
          ),
          Text(
            'Balance',
            style: TextStyle(
              color: context.colors.onPrimary,
            ),
          ),
          dashBoard.when(
            error: (e, s) => ErrorView(e, s),
            loading: () => Loader.shimmer(30, 200),
            data: (d) => Text(
              d.seller.balance.formate(),
              style: context.textTheme.titleLarge!.copyWith(
                color: context.colors.onPrimary,
              ),
            ),
          ),
          const Gap(Insets.lg),
          FilledButton.icon(
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(
                context.colors.onPrimaryContainer,
              ),
              shape: const WidgetStatePropertyAll(
                StadiumBorder(),
              ),
            ),
            onPressed: () {
              RouteNames.depositPayment.pushNamed(context);
            },
            icon: Icon(
              Icons.add,
              color: context.colors.onSurface,
            ),
            label: Text(
              'Deposit',
              style: TextStyle(
                color: context.colors.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
