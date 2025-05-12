import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:seller_management/features/settings/controller/settings_ctrl.dart';
import 'package:seller_management/main.export.dart';
import 'package:seller_management/routes/routes.dart';

import '../controller/order_ctrl.dart';
import 'local/product_package_card.dart';
import 'local/status_note_card.dart';

class OrderDetailsView extends HookConsumerWidget {
  const OrderDetailsView(this.id, {super.key});
  final String id;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderDetails = ref.watch(orderDetailsCtrlNotifier(id));
    final orderCtrl =
        useCallback(() => ref.read(orderDetailsCtrlNotifier(id).notifier));

    final selectedValue = useState<int?>(null);

    final statusList =
        ref.watch(localSettingsProvider.select((v) => v?.config.validStatus));

    final noteCtrl = useTextEditingController();

    final tr = TR.of(context);
    return orderDetails.when(
      loading: () => Loader.fullScreen(true),
      error: (e, s) => Scaffold(body: ErrorView(e, s)),
      data: (order) {
        final delivery = order.deliveryInfo;
        return Scaffold(
          appBar: AppBar(
            title: Text(tr.order_details),
            actions: [
              if (order.isPhysical)
                IconButton(
                  onPressed: () {
                    orderCtrl().downloadInvoice();
                  },
                  icon: const Icon(Icons.print),
                ),
            ],
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(orderDetailsCtrlNotifier);
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: Insets.padH,
                child: Column(
                  children: [
                    const Gap(Insets.med),
                    //! billing
                    if (order.billing != null)
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: Corners.smBorder,
                          border: Border.all(
                            width: 0,
                            color: context.colors.primary,
                          ),
                        ),
                        width: double.infinity,
                        margin: Insets.padSym(4),
                        padding: Insets.padAll,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tr.ship_and_bill_to,
                              style: context.textTheme.bodyLarge!.copyWith(
                                color:
                                    context.colors.onSurface.withOpacity(0.8),
                              ),
                            ),
                            ...[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${tr.order}: ${order.orderId}',
                                    style:
                                        context.textTheme.bodyLarge!.copyWith(
                                      color: context.colors.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      await Clipboard.setData(
                                        ClipboardData(text: order.orderId),
                                      );
                                      Toaster.showInfo(tr.order_id_copied);
                                    },
                                    child: Icon(
                                      Icons.copy,
                                      color: context.colors.primary,
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(),
                              if (!order.billing!.isNamesEmpty)
                                Text(
                                  'Name: ${order.billing!.fullName}',
                                  style: context.textTheme.titleMedium,
                                ),
                              if (order.billing?.phone != null)
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          '${tr.phone}: ${order.billing!.phone}',
                                          style: context.textTheme.titleMedium,
                                        ),
                                        const Gap(Insets.med),
                                        GestureDetector(
                                          onTap: () => URLHelper.call(
                                              order.billing!.phone!),
                                          child: CircleAvatar(
                                            backgroundColor: context
                                                .colors.primary
                                                .withOpacity(.1),
                                            radius: 13,
                                            child: Icon(
                                              size: 18,
                                              Icons.arrow_outward_rounded,
                                              color: context.colors.primary,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              if (order.billing!.email.isNotEmpty)
                                Row(
                                  children: [
                                    Text(
                                      '${tr.email}: ${order.billing!.email}',
                                      style: context.textTheme.titleMedium,
                                    ),
                                    const Gap(Insets.sm),
                                    GestureDetector(
                                      onTap: () =>
                                          URLHelper.mail(order.billing!.email),
                                      child: CircleAvatar(
                                        backgroundColor: context.colors.primary
                                            .withOpacity(.1),
                                        radius: 13,
                                        child: Icon(
                                          Icons.arrow_outward_rounded,
                                          size: 18,
                                          color: context.colors.primary,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              if (order.billing!.address.isNotEmpty)
                                Text(
                                  '${tr.street_name} : ${order.billing!.address}',
                                  style: context.textTheme.titleMedium,
                                ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${tr.order_placement}: ',
                                    style:
                                        context.textTheme.titleMedium!.copyWith(
                                      color: context.colors.onSurface
                                          .withOpacity(0.8),
                                    ),
                                  ),
                                  Text(
                                    order.date,
                                    style:
                                        context.textTheme.titleMedium!.copyWith(
                                      color: context.colors.onSurface
                                          .withOpacity(0.8),
                                    ),
                                  ),
                                ],
                              ),
                            ]
                          ],
                        ),
                      ),
                    //! customer
                    if (order.customer != null)
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: Corners.smBorder,
                          border: Border.all(
                            width: 0,
                            color: context.colors.primary,
                          ),
                        ),
                        margin: Insets.padSym(4),
                        padding: Insets.padAll,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tr.customer_info,
                              style: context.textTheme.bodyLarge!.copyWith(
                                color:
                                    context.colors.onSurface.withOpacity(0.8),
                              ),
                            ),
                            if (order.customer!.name.isNotEmpty)
                              Text(
                                '${tr.customer_name}: ${order.customer!.name}',
                                style: context.textTheme.titleMedium,
                              ),
                            if (order.customer!.phone != null)
                              Row(
                                children: [
                                  Text(
                                    '${tr.phone}: ${order.customer!.phone}',
                                    style: context.textTheme.titleMedium,
                                  ),
                                  const Gap(Insets.med),
                                  GestureDetector(
                                    onTap: () =>
                                        URLHelper.call(order.customer!.phone!),
                                    child: CircleAvatar(
                                      backgroundColor: context.colors.primary
                                          .withOpacity(.1),
                                      radius: 13,
                                      child: Icon(
                                        size: 18,
                                        Icons.arrow_outward_rounded,
                                        color: context.colors.primary,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            if (order.customer!.email.isNotEmpty)
                              Row(
                                children: [
                                  Text(
                                    '${tr.email}: ${order.customer!.email}',
                                    style: context.textTheme.titleMedium,
                                  ),
                                  const Gap(Insets.sm),
                                  GestureDetector(
                                    onTap: () =>
                                        URLHelper.mail(order.customer!.email),
                                    child: CircleAvatar(
                                      backgroundColor: context.colors.primary
                                          .withOpacity(.1),
                                      radius: 13,
                                      child: Icon(
                                        Icons.arrow_outward_rounded,
                                        size: 18,
                                        color: context.colors.primary,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            FilledButton.icon(
                              onPressed: () {
                                RouteNames.customerChat.pushNamed(
                                  context,
                                  pathParams: {'id': '${order.customer!.id}'},
                                );
                              },
                              style: FilledButton.styleFrom(
                                backgroundColor:
                                    context.colors.primary.withOpacity(.1),
                                foregroundColor: context.colors.primary,
                              ),
                              icon: Text(tr.chat),
                              label: SvgPicture.asset(
                                AssetsConst.sms,
                                height: 25,
                                colorFilter: ColorFilter.mode(
                                  context.colors.primary,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                    //! DeliveryMan info Section ---------------------------------------------
                    if (delivery != null)
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: Corners.smBorder,
                          border: Border.all(
                            width: 0,
                            color: context.colors.primary,
                          ),
                        ),
                        margin: Insets.padSym(4),
                        padding: Insets.padAll,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Delivery Information',
                              style: context.textTheme.bodyLarge!.copyWith(
                                color:
                                    context.colors.onSurface.withOpacity(0.8),
                              ),
                            ),
                            const Gap(Insets.sm),
                            SpacedText(
                              left: 'Delivery Man',
                              right: delivery.assignTo?.fullName ?? 'n/a',
                            ),
                            SpacedText(
                              left: 'Pickup location',
                              right: delivery.pickupLocation ?? 'n/a',
                            ),
                            SpacedText(
                              left: 'Note',
                              right: delivery.note ?? 'n/a',
                            ),
                            const Gap(Insets.med),
                            const DashedDivider(),
                            ExpansionTile(
                              title: const Text('Timeline'),
                              tilePadding: EdgeInsets.zero,
                              children: [
                                for (int i = 0;
                                    i < delivery.timeLine.length;
                                    i++)
                                  Builder(builder: (_) {
                                    final e =
                                        delivery.timeLine.entries.toList()[i];
                                    return Row(
                                      children: [
                                        Column(
                                          children: [
                                            Visibility.maintain(
                                              visible: i != 0,
                                              child: Container(
                                                width: 3,
                                                constraints:
                                                    const BoxConstraints(
                                                  maxHeight: 20,
                                                ),
                                                color: context.colors.primary,
                                              ),
                                            ),
                                            CircleAvatar(
                                              radius: 18,
                                              backgroundColor: context
                                                  .colors.primary
                                                  .withOpacity(.1),
                                              child: Icon(
                                                Icons.shopping_cart_rounded,
                                                color: context.colors.primary,
                                                size: 18,
                                              ),
                                            ),
                                            Visibility.maintain(
                                              visible: i !=
                                                  delivery.timeLine.length - 1,
                                              child: Container(
                                                width: 3,
                                                constraints:
                                                    const BoxConstraints(
                                                  maxHeight: 25,
                                                ),
                                                color: context.colors.primary,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Flexible(
                                          child: ListTile(
                                            title: Text(
                                              e.value.actionBy,
                                              maxLines: 1,
                                            ),
                                            subtitle: Text(
                                              e.value.details,
                                              maxLines: 2,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                              ],
                            ),
                          ],
                        ),
                      ),

                    //! Custom info Section ---------------------------------------------
                    if (order.customInfo.isNotEmpty)
                      SelectionArea(
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: Corners.smBorder,
                            border: Border.all(
                              width: 0,
                              color: context.colors.primary,
                            ),
                          ),
                          margin: Insets.padSym(4),
                          padding: Insets.padAll,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Custom Information',
                                style: context.textTheme.bodyLarge!.copyWith(
                                  color:
                                      context.colors.onSurface.withOpacity(0.8),
                                ),
                              ),
                              ...order.customInfo.entries.map((e) {
                                var MapEntry(:key, :value) = e;
                                if (value is List) value = value.join(', ');
                                if (value == null) {
                                  return const SizedBox.shrink();
                                }
                                return Text('$key : $value');
                              }),
                            ],
                          ),
                        ),
                      ),

                    //! Product Package Section ---------------------------------------------

                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: order.details.length,
                      itemBuilder: (context, index) => ProductPackageCard(
                        product: order.details[index],
                        orderInfo: order,
                      ),
                    ),

                    const Gap(Insets.sm),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: Corners.smBorder,
                        border: Border.all(
                          width: 0,
                          color: context.colors.primary,
                        ),
                      ),
                      padding: Insets.padAll,
                      child: Column(
                        children: [
                          SpacedText(
                            style: context.textTheme.titleMedium,
                            left: tr.payment_method,
                            right: order.paymentVia,
                          ),
                          const Gap(Insets.med),
                          SpacedText(
                            style: context.textTheme.titleMedium,
                            styleBuilder: (left, right) => (
                              left,
                              right?.copyWith(
                                color: order.paymentStatus == 'Unpaid'
                                    ? context.colors.error
                                    : context.colors.errorContainer,
                              ),
                            ),
                            left: tr.payment_status,
                            right: order.paymentStatus,
                          ),
                          const Divider(height: 10),
                          SpacedText(
                            style: context.textTheme.titleMedium,
                            left: tr.sub_total,
                            right: order.orderAmount.formate(),
                          ),
                          const Gap(Insets.med),
                          SpacedText(
                            style: context.textTheme.titleMedium,
                            left: tr.shipping_charge,
                            right: order.shippingCharge.formate(),
                          ),
                          const Gap(Insets.med),
                          SpacedText(
                            style: context.textTheme.titleMedium,
                            left: tr.total,
                            right: order.finalAmount.formate(),
                          ),
                          if (order.isPhysical) ...[
                            const Gap(Insets.med),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  tr.download_invoice,
                                  style: context.textTheme.bodyLarge,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    orderCtrl().downloadInvoice();
                                  },
                                  child: Icon(
                                    Icons.print_outlined,
                                    color: context.colors.primary,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                    const Gap(Insets.med),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      clipBehavior: Clip.none,
                      shrinkWrap: true,
                      itemCount: order.orderStatus.length,
                      itemBuilder: (context, index) {
                        final orderStatus = order.orderStatus[index];
                        return StatusNoteCard(orderStatus: orderStatus);
                      },
                    ),
                    const Gap(Insets.sm),
                    ShadowContainer(
                      padding: Insets.padAll,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tr.delivery_status,
                            style: context.textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Gap(Insets.med),
                          DropDownField<int>(
                            hintText: tr.select_item,
                            itemCount: statusList?.length,
                            value: selectedValue.value,
                            itemBuilder: (context, index) {
                              final item = statusList![index];
                              return DropdownMenuItem<int>(
                                value: item.value,
                                child: Text(
                                  item.key.toTitleCase,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              );
                            },
                            onChanged: (value) => selectedValue.value = value,
                          ),
                          const Gap(Insets.med),
                          TextFormField(
                            controller: noteCtrl,
                            maxLines: 3,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                              hintText: tr.write_short_note,
                            ),
                          ),
                          const Gap(Insets.med),
                          SubmitButton(
                            onPressed: (l) async {
                              if (selectedValue.value == null) {
                                Toaster.showError(
                                  tr.please_select_status_first,
                                );
                                return;
                              }
                              l.value = true;
                              await orderCtrl().orderStatusUpdate(
                                status: selectedValue.value.toString(),
                                note: noteCtrl.text,
                              );

                              l.value = false;
                              selectedValue.value = null;
                              noteCtrl.clear();
                            },
                            child: Text(tr.submit),
                          ),
                        ],
                      ),
                    ),
                    const Gap(Insets.lg),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
