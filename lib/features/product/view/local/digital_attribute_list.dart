import 'package:flutter/material.dart';
import 'package:seller_management/features/product/controller/product_ctrl.dart';
import 'package:seller_management/features/product/view/local/add_attribute_value.dart';
import 'package:seller_management/features/product/view/local/add_digital_product_attribute.dart';
import 'package:seller_management/main.export.dart';

class DigitalAttributeList extends HookConsumerWidget {
  const DigitalAttributeList({
    super.key,
    required this.product,
  });

  final ProductModel product;

  Row _header(BuildContext context) {
    return Row(
      children: [
        Text(
          TR.of(context).digital_product_attribute_list,
          style: context.textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              showDragHandle: true,
              context: context,
              isScrollControlled: true,
              builder: (context) {
                return AddDigitalProductAttribute(
                  product: product,
                );
              },
            );
          },
          child: Text(
            TR.of(context).add_attribute,
            style: context.textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.bold,
              color: context.colors.primary,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productCtrl = useCallback(
        () => ref.read(productDetailsCtrlProvider(product.uid).notifier));

    return Column(
      children: [
        _header(context),
        const Gap(Insets.med),
        Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: product.digitalAttributes.length,
              itemBuilder: (context, index) {
                final attr = product.digitalAttributes[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: ShadowContainer(
                    shadowColors:
                        context.colors.secondaryContainer.withOpacity(.03),
                    blurRadius: 40,
                    padding: Insets.padAll,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                attr.name,
                                style: context.textTheme.titleMedium,
                                maxLines: 1,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  attr.price.formate(),
                                  style: context.textTheme.titleMedium,
                                ),
                                const Gap(Insets.med),
                                SizedBox.square(
                                  dimension: 30,
                                  child: IconButton.filled(
                                    onPressed: () {
                                      context.nPush(
                                        AddAttributeValueView(
                                          attribute: attr,
                                          products: product,
                                        ),
                                        isFullScreen: true,
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.arrow_outward_rounded,
                                      size: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        if (attr.shortDetails.isNotEmpty)
                          Text(attr.shortDetails),
                        const Gap(Insets.med),
                        SeparatedRow(
                          separatorBuilder: () => const Gap(Insets.med),
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            DecoratedContainer(
                              padding: Insets.padSym(5, 10),
                              color: attr.isActive
                                  ? context.colors.errorContainer
                                      .withOpacity(.1)
                                  : context.colors.error.withOpacity(.1),
                              borderRadius: Corners.med,
                              child: Text(attr.status),
                            ),
                            const Spacer(),
                            CircleIconButton(
                              iconData: Icons.edit_rounded,
                              color: context.colors.primary,
                              onTap: () {
                                showModalBottomSheet(
                                  showDragHandle: true,
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context) {
                                    return AddDigitalProductAttribute(
                                      product: product,
                                      attribute: attr,
                                    );
                                  },
                                );
                              },
                            ),
                            CircleIconButton(
                              iconData: Icons.delete,
                              color: context.colors.error,
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return DeleteAlert(
                                      title: TR
                                          .of(context)
                                          .really_want_to_delete_this_attribute,
                                      onDelete: () async {
                                        await productCtrl().deleteAttribute(
                                          attr.uid,
                                        );
                                        if (context.mounted) context.nPop();
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
