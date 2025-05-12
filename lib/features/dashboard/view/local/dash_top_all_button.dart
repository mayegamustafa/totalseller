import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:seller_management/features/dashboard/view/local/top_information_card.dart';
import 'package:seller_management/main.export.dart';
import 'package:seller_management/routes/go_route_name.dart';

class DashTopButton extends StatelessWidget {
  const DashTopButton({
    super.key,
    required this.dash,
  });
  final Dashboard dash;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            DashBoardButton(
              title: TR.of(context).total_balance,
              count: dash.seller.balance.formate(),
              svgIcon: AssetsConst.totalBalance,
              onTap: () => RouteNames.totalBalance.goNamed(context),
            ),
            const Gap(Insets.med),
            DashBoardButton(
              title: TR.of(context).total_withdraw,
              count: dash.overview.totalWithdrawAmount.formate(),
              svgIcon: AssetsConst.withdraw,
              onTap: () => RouteNames.withdraw.goNamed(context),
              color: const Color(0xff08b4ef),
            ),
          ],
        ),
        const Gap(Insets.med),
        Row(
          children: [
            DashBoardButton(
              title: TR.of(context).all_product,
              count:
                  '${dash.overview.physicalProduct + dash.overview.digitalProduct}',
              svgIcon: AssetsConst.totalProduct,
              onTap: () => RouteNames.product.pushNamed(context),
              color: const Color(0xff5182ff),
            ),
            const Gap(Insets.med),
            DashBoardButton(
              title: TR.of(context).total_order,
              count: '${dash.overview.placedOrder}',
              svgIcon: AssetsConst.totalOrder,
              onTap: () => RouteNames.order.goNamed(context),
              color: const Color(0xffff898b),
            ),
          ],
        ),
      ],
    );
  }
}

class DashTopAllCartMobileView extends StatelessWidget {
  const DashTopAllCartMobileView({
    super.key,
    required this.dash,
  });
  final Dashboard dash;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
          ],
        ),
        const Gap(Insets.med),
        Row(
          children: [
            Expanded(
              child: TopInformationCard(
                icon: AssetsConst.canceledOrder,
                onTap: () =>
                    RouteNames.order.pushNamed(context, query: {'sub': '6'}),
                title: '${dash.overview.cancelOrder}',
                subTitle: TR.of(context).canceled_order,
              ),
            ),
            const Gap(Insets.med),
            Expanded(
              child: TopInformationCard(
                icon: AssetsConst.totalTicket,
                onTap: () => RouteNames.messages.pushNamed(context),
                title: '${dash.overview.totalTicket}',
                subTitle: TR.of(context).total_ticket,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class DashBoardButton extends StatelessWidget {
  const DashBoardButton({
    super.key,
    required this.title,
    required this.count,
    required this.svgIcon,
    required this.onTap,
    this.color,
  });
  final String title;
  final String count;
  final String svgIcon;
  final Function() onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: Corners.medBorder,
                color: color ?? const Color(0xff6a5fff),
              ),
              child: Padding(
                padding: Insets.padAll,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: context.textTheme.titleLarge!.copyWith(
                        color: context.colors.onPrimary,
                      ),
                    ),
                    const Gap(Insets.offset),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          count,
                          style: context.textTheme.headlineSmall!.copyWith(
                            color: context.colors.onPrimary,
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: context.colors.onPrimary,
                          child: SvgPicture.asset(
                            svgIcon,
                            height: 18,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 5,
              top: -25,
              child: CircleAvatar(
                radius: 30,
                backgroundColor: context.colors.onPrimary.withOpacity(.1),
              ),
            ),
            Positioned(
              right: -10,
              top: -10,
              child: CircleAvatar(
                radius: 35,
                backgroundColor: context.colors.onPrimary.withOpacity(.1),
              ),
            ),
            Positioned(
              right: -25,
              top: 5,
              child: CircleAvatar(
                radius: 30,
                backgroundColor: context.colors.onPrimary.withOpacity(.1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
