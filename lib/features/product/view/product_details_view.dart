import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:seller_management/features/product/controller/product_ctrl.dart';
import 'package:seller_management/features/product/view/local/digital_attribute_list.dart';
import 'package:seller_management/features/product/view/local/product_stocks.dart';
import 'package:seller_management/main.export.dart';
import 'package:seller_management/routes/go_route_name.dart';

import 'local/count_button.dart';
import 'local/tax_dialog.dart';

class ProductDetailsView extends HookConsumerWidget {
  const ProductDetailsView(this.id, {super.key});

  final String id;

  Future<dynamic> _showTaxDialog(BuildContext context, List<Tax> taxes) {
    return showDialog(
      context: context,
      builder: (context) => TaxDialog(taxes: taxes),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productDetails = ref.watch(productDetailsCtrlProvider(id));
    final productCtrl =
        useCallback(() => ref.read(productDetailsCtrlProvider(id).notifier));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          TR.of(context).product_details,
        ),
        actions: [
          productDetails.maybeWhen(
            orElse: () => const SizedBox.shrink(),
            data: (data) => TextButton.icon(
              onPressed: () {
                if (data.isPhysical) {
                  RouteNames.addProduct.pushNamed(context, extra: data);
                } else {
                  RouteNames.addDigitalProduct.pushNamed(context, extra: data);
                }
              },
              icon: Icon(
                Icons.edit,
                size: 20,
                color: context.colors.onPrimary,
              ),
              label: Text(
                TR.of(context).edit,
                style: TextStyle(
                  color: context.colors.onPrimary,
                ),
              ),
            ),
          )
        ],
      ),
      body: productDetails.when(
        loading: Loader.new,
        error: ErrorView.new,
        data: (product) => RefreshIndicator(
          onRefresh: () async => productCtrl().reload(),
          child: SingleChildScrollView(
            child: Padding(
              padding: Insets.padH.copyWith(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //! image
                  CarouselSlider.builder(
                    options: CarouselOptions(
                      enlargeFactor: 0,
                      clipBehavior: Clip.none,
                      viewportFraction: 1,
                      initialPage: 0,
                      height: 250,
                      autoPlay: true,
                    ),
                    itemCount: product.featuredImage.length,
                    itemBuilder: (context, index, realIndex) {
                      return ClipRRect(
                        borderRadius: Corners.smBorder,
                        child: HostedImage(product.featuredImage),
                      );
                    },
                  ),
                  const Gap(Insets.lg),

                  //! basic info
                  Text(
                    product.name,
                    style: context.textTheme.titleLarge,
                  ),
                  const Gap(Insets.sm),
                  if (product.isPhysical) ...[
                    const Gap(Insets.sm),
                    Text(
                      'Price : ${product.price}',
                      style: context.textTheme.titleMedium?.copyWith(
                        color: context.colors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap(Insets.sm),
                    Text(
                      'Discount price : ${product.discount} (${product.discountPercentage}%)',
                      style: context.textTheme.bodyLarge,
                    ),
                  ],
                  const Gap(Insets.sm),
                  if (product.tax.isNotEmpty)
                    GestureDetector(
                      onTap: () => _showTaxDialog(context, product.tax),
                      child: DecoratedContainer(
                        borderColor: context.colors.primary,
                        borderWidth: 1,
                        borderRadius: Corners.sm,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 3,
                        ),
                        child: Text(
                          'Tax info',
                          style: context.textTheme.titleMedium?.copyWith(
                            color: context.colors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  const Gap(Insets.sm),
                  Text(
                    'Weight : ${product.weight}',
                    style: context.textTheme.bodyLarge,
                  ),
                  const Gap(Insets.sm),
                  Text(
                    'Shipping Fee : ${product.shippingFee}',
                    style: context.textTheme.bodyLarge,
                  ),
                  const Gap(Insets.sm),
                  //! category
                  if (product.category.name.isNotEmpty)
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        color: context.colors.onSurface.withOpacity(.1),
                        borderRadius: Corners.smBorder,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5),
                        child: Text(
                          product.category.name,
                        ),
                      ),
                    ),
                  //! subcategory
                  if (product.subCategory != null)
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        color: context.colors.onSurface.withOpacity(.1),
                        borderRadius: Corners.smBorder,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 5,
                      ),
                      child: Text(product.subCategory!.name),
                    ),
                  const Gap(Insets.med),

                  //! stock
                  if (product.stock.isNotEmpty) ProductStocks(product: product),
                  const Gap(Insets.lg),

                  //! counts
                  Row(
                    children: [
                      CountButton(
                        title: TR.of(context).total_order,
                        count: product.totalOrderCount.toString(),
                        color: context.colors.primary,
                      ),
                      const Gap(Insets.sm),
                      CountButton(
                        title: TR.of(context).placed_order,
                        count: product.totalPlacedOrder.toString(),
                        color: context.colors.secondary,
                      ),
                      const Gap(Insets.sm),
                      CountButton(
                        title: TR.of(context).delivered_order,
                        count: product.totalDeliveredOrder.toString(),
                        color: context.colors.errorContainer,
                      ),
                    ],
                  ),

                  //! digitalAttributes
                  if (product.digitalAttributes.isNotEmpty) ...[
                    const Gap(Insets.lg),
                    DigitalAttributeList(product: product),
                    const Gap(Insets.lg),
                  ],

                  //! short description

                  if (product.shortDescription.isNotEmpty) ...[
                    const Gap(Insets.lg),
                    Text(
                      TR.of(context).short_description,
                      style: context.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(),
                    Html(
                      data: product.shortDescription,
                      style: {
                        "*": Style(
                          fontSize: FontSize(16),
                          lineHeight: const LineHeight(1.3),
                          fontWeight: FontWeight.w400,
                          color: context.colors.onSurface,
                          backgroundColor: context.colors.surface,
                        ),
                      },
                    ),
                  ],

                  //! meta
                  if (product.metaTitle.isNotEmpty) ...[
                    const Gap(Insets.lg),
                    Text(
                      TR.of(context).meta_title,
                      style: context.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(),
                    Text(product.metaTitle),
                  ],
                  if (product.metaKeywords.isNotEmpty) ...[
                    const Gap(Insets.lg),
                    Text(
                      TR.of(context).meta_keyword,
                      style: context.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: product.metaKeywords.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: Wrap(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: Corners.smBorder,
                                color: context.colors.onSurface.withOpacity(.1),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10.0,
                                vertical: 5,
                              ),
                              child: Text(
                                product.metaKeywords[index].titleCaseSingle,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],

                  //! custom Info
                  if (product.customInfo.isNotEmpty) ...[
                    ExpansionTile(
                      tilePadding: const EdgeInsets.all(0),
                      expandedCrossAxisAlignment: CrossAxisAlignment.start,
                      title: Text(
                        'Product options',
                        style: context.textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      children: [
                        const Divider(),
                        ...product.customInfo.map(
                          (e) {
                            var tr = TR.of(context);
                            return SelectionArea(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: SizedBox(
                                  width: context.width,
                                  child: ShadowContainer(
                                    blurRadius: 40,
                                    shadowColors: context
                                        .colors.secondaryContainer
                                        .withOpacity(.03),
                                    child: Padding(
                                      padding: Insets.padAll,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(tr.fieldName(': ${e.name}')),
                                          Text(
                                            tr.fieldLabel(
                                              ': ${e.type.name.titleCaseSingle}',
                                            ),
                                          ),
                                          Text(
                                            e.isRequired
                                                ? tr.required
                                                : tr.notRequired,
                                          ),
                                          if (e.options != null)
                                            Text(
                                              tr.field_options(
                                                ': ${e.options}',
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ],

                  //! description
                  if (product.description.isNotEmpty) ...[
                    const Gap(Insets.lg),
                    Text(
                      TR.of(context).description,
                      style: context.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(),
                    Html(
                      data: product.description,
                      style: {
                        "*": Style(
                          fontSize: FontSize(16),
                          lineHeight: const LineHeight(1.3),
                          fontWeight: FontWeight.w400,
                          color: context.colors.onSurface,
                          backgroundColor: context.colors.surface,
                        ),
                      },
                    ),
                  ],
                  const Gap(Insets.lg),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
