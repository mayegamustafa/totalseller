import 'package:flutter/material.dart';
import 'package:seller_management/main.export.dart';

class ProductStocks extends StatelessWidget {
  const ProductStocks({
    super.key,
    required this.product,
  });
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          TR.of(context).product_attribute,
          style: context.textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const Gap(Insets.med),
        ShadowContainer(
          child: Padding(
            padding: Insets.padAll,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            TR.of(context).attribute,
                            style: context.textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            TR.of(context).stock,
                            style: context.textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            TR.of(context).price,
                            style: context.textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: product.stock.length,
                  itemBuilder: (context, index) {
                    final stock = product.stock[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      stock.attribute,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  stock.qty,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    stock.price.formate(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
