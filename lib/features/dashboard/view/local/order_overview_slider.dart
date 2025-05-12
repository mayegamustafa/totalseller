import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:seller_management/routes/go_route_name.dart';

import '../../../../main.export.dart';

class OrderOverviewSlider extends StatelessWidget {
  const OrderOverviewSlider({
    super.key,
    required this.overview,
  });

  final Overview overview;
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: [
        SliderButton(
          title: TR.of(context).total_order,
          count: '${overview.placedOrder}',
          svgIcon: AssetsConst.totalOrder,
          onTap: () => RouteNames.order.pushNamed(context),
          color: const Color(0xff6a5fff),
        ),
        SliderButton(
          title: TR.of(context).digital_order,
          count: '${overview.digitalOrder}',
          svgIcon: AssetsConst.digitalOrder,
          onTap: () => RouteNames.order.pushNamed(context, query: {'tab': '1'}),
          color: const Color(0xff08b4ef),
        ),
        SliderButton(
          title: TR.of(context).shipped_order,
          count: '${overview.shippedOrder}',
          svgIcon: AssetsConst.shippedOrder,
          onTap: () => RouteNames.order.pushNamed(context, query: {'sub': '5'}),
          color: const Color(0xff5182ff),
        ),
        SliderButton(
          title: TR.of(context).delivered_order,
          count: '${overview.deliveredOrder}',
          svgIcon: AssetsConst.deliveredOrder,
          onTap: () => RouteNames.order.pushNamed(context, query: {'sub': '6'}),
          color: const Color(0xff6a5fff),
        ),
        SliderButton(
          title: TR.of(context).canceled_order,
          count: '${overview.cancelOrder}',
          svgIcon: AssetsConst.canceledOrder,
          onTap: () => RouteNames.order.pushNamed(context, query: {'sub': '7'}),
          color: const Color(0xffff898b),
        ),
      ],
      options: CarouselOptions(
        aspectRatio: 2.8,
        viewportFraction: 1,
        autoPlay: true,
        autoPlayCurve: Curves.easeInExpo,
      ),
    );
  }
}

class SliderButton extends StatelessWidget {
  const SliderButton({
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
    return Padding(
      padding: Insets.padH,
      child: GestureDetector(
        onTap: onTap,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: Corners.medBorder,
                color: color,
              ),
              child: Padding(
                padding: Insets.padAll,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
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
                          style: context.textTheme.headlineSmall!
                              .copyWith(color: context.colors.onPrimary),
                        ),
                        CircleAvatar(
                          backgroundColor: context.colors.onPrimary,
                          child: SvgPicture.asset(
                            svgIcon,
                            height: 18,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 60,
              child: Opacity(
                opacity: .1,
                child: SvgPicture.asset(
                  svgIcon,
                  height: 100,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
