import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:seller_management/main.export.dart';
import 'package:seller_management/routes/go_route_name.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({
    super.key,
    required this.orderInfo,
  });

  final OrderModel orderInfo;

  @override
  Widget build(BuildContext context) {
    final tr = TR.of(context);
    return GestureDetector(
      onTap: () => RouteNames.orderDetails.pushNamed(context, pathParams: {
        'id': orderInfo.orderId,
      }),
      child: Padding(
        padding: Insets.padH,
        child: ShadowContainer(
          child: Padding(
            padding: Insets.padAll,
            child: Row(
              children: [
                Expanded(
                  flex: 7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${tr.order}: ${orderInfo.orderId}',
                            style: context.textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: context.colors.primary,
                            ),
                          ),
                          const Gap(Insets.sm),
                          GestureDetector(
                            onTap: () async {
                              await Clipboard.setData(
                                ClipboardData(text: orderInfo.orderId),
                              );

                              Toaster.showInfo(tr.order_id_copied);
                            },
                            child: Icon(
                              Icons.copy,
                              size: 18,
                              color: context.colors.primary,
                            ),
                          ),
                        ],
                      ),
                      const Gap(Insets.med),
                      Text(tr.customer_info),
                      Text(
                        '${tr.name}: ${orderInfo.billing?.fullName}',
                      ),
                      Row(
                        children: [
                          Text(
                            '${tr.phone}: ${orderInfo.billing?.phone}',
                          ),
                          const Gap(Insets.sm),
                          if (orderInfo.billing?.phone != null)
                            GestureDetector(
                              onTap: () async {
                                await Clipboard.setData(
                                  ClipboardData(
                                    text: orderInfo.billing!.phone!,
                                  ),
                                );
                                Toaster.showInfo(tr.phone_number_copied);
                              },
                              child: Icon(
                                Icons.copy,
                                size: 18,
                                color: context.colors.primary,
                              ),
                            ),
                        ],
                      ),
                      Text(
                        '${tr.email}: ${orderInfo.billing?.email}',
                      ),
                      Text(
                        '${tr.order_placement}: ${orderInfo.date}',
                        style: TextStyle(
                          color: context.colors.onSurface.withOpacity(.7),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        orderInfo.paymentStatus,
                        style: TextStyle(
                          color: orderInfo.paymentStatus == 'Unpaid'
                              ? context.colors.error
                              : context.colors.errorContainer,
                        ),
                      ),
                      if (orderInfo.shipping != null)
                        Text(
                          orderInfo.shipping!.method,
                          textAlign: TextAlign.end,
                        ),
                      Text(
                        orderInfo.deliveryStatus,
                      ),
                      Text(
                        '${tr.total}: ${orderInfo.orderAmount.formate()}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
