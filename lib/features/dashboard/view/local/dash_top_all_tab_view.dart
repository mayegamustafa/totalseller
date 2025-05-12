import 'package:flutter/material.dart';
import 'package:seller_management/features/dashboard/view/local/top_information_card.dart';
import 'package:seller_management/main.export.dart';
import 'package:seller_management/routes/go_route_name.dart';

class DashTopAllCartTabView extends StatelessWidget {
  const DashTopAllCartTabView({
    super.key,
    required this.dash,
  });
  final Dashboard dash;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TopInformationCard(
                icon: AssetsConst.totalBalance,
                onTap: () => RouteNames.totalBalance.goNamed(context),
                title: dash.seller.balance.formate(),
                subTitle: TR.of(context).total_balance,
              ),
            ),
            const Gap(Insets.med),
            Expanded(
              child: TopInformationCard(
                icon: AssetsConst.withdraw,
                onTap: () => RouteNames.withdraw.goNamed(context),
                title: dash.overview.totalWithdrawAmount.formate(),
                subTitle: TR.of(context).total_withdraw,
              ),
            ),
            const Gap(Insets.med),
            Expanded(
              child: TopInformationCard(
                icon: AssetsConst.totalProduct,
                onTap: () => RouteNames.product.pushNamed(context),
                title: '${dash.overview.physicalProduct}',
                subTitle: TR.of(context).physical_product,
              ),
            ),
          ],
        ),
        const Gap(Insets.med),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TopInformationCard(
                icon: AssetsConst.digitalProduct,
                onTap: () =>
                    RouteNames.product.pushNamed(context, query: {'tab': '1'}),
                title: '${dash.overview.digitalProduct}',
                subTitle: TR.of(context).digital_product,
              ),
            ),
            const Gap(Insets.med),
            Expanded(
              child: TopInformationCard(
                icon: AssetsConst.totalOrder,
                onTap: () => RouteNames.order.pushNamed(context),
                title: '${dash.overview.placedOrder}',
                subTitle: TR.of(context).total_order,
              ),
            ),
            const Gap(Insets.med),
            Expanded(
              child: TopInformationCard(
                icon: AssetsConst.digitalOrder,
                onTap: () =>
                    RouteNames.order.pushNamed(context, query: {'tab': '1'}),
                title: '${dash.overview.digitalOrder}',
                subTitle: TR.of(context).digital_order,
              ),
            ),
          ],
        ),
        const Gap(Insets.med),
        Row(
          children: [
            Expanded(
              child: TopInformationCard(
                icon: AssetsConst.deliveredOrder,
                onTap: () =>
                    RouteNames.order.pushNamed(context, query: {'sub': '5'}),
                title: '${dash.overview.deliveredOrder}',
                subTitle: TR.of(context).delivered_order,
              ),
            ),
            const Gap(Insets.med),
            Expanded(
              child: TopInformationCard(
                icon: AssetsConst.shippedOrder,
                onTap: () =>
                    RouteNames.order.pushNamed(context, query: {'sub': '4'}),
                title: '${dash.overview.shippedOrder}',
                subTitle: TR.of(context).shipped_order,
              ),
            ),
            const Gap(Insets.med),
            Expanded(
              child: TopInformationCard(
                icon: AssetsConst.canceledOrder,
                onTap: () =>
                    RouteNames.order.pushNamed(context, query: {'sub': '6'}),
                title: '${dash.overview.cancelOrder}',
                subTitle: TR.of(context).canceled_order,
              ),
            ),
          ],
        ),
        const Gap(Insets.med),
        Row(
          children: [
            Expanded(
              child: TopInformationCard(
                icon: AssetsConst.totalTicket,
                onTap: () => RouteNames.messages.pushNamed(context),
                title: '${dash.overview.totalTicket}',
                subTitle: TR.of(context).total_ticket,
              ),
            ),
            const Gap(Insets.med),
            const Expanded(child: SizedBox()),
            const Gap(Insets.med),
            const Expanded(child: SizedBox())
          ],
        ),
      ],
    );
  }
}
