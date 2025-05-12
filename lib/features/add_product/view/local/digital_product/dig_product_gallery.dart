import 'package:flutter/material.dart';
import 'package:seller_management/features/add_product/controller/add_digital_ctrl.dart';
import 'package:seller_management/features/settings/controller/auth_config_ctrl.dart';
import 'package:seller_management/main.export.dart';

import '../local.dart';

class DigitalProductGallery extends HookConsumerWidget {
  const DigitalProductGallery({
    super.key,
    required this.editingProduct,
  });

  final ProductModel? editingProduct;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productCtrl = useCallback(
        () => ref.read(digitalStoreCtrlProvider(editingProduct).notifier));

    final productState = ref.watch(digitalStoreCtrlProvider(editingProduct));

    final sizeGuide =
        ref.watch(localAuthConfigProvider.select((v) => v?.sizeGuide));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(Insets.lg),
        Text(
          TR.of(context).product_gallery,
          style: context.textTheme.titleLarge,
        ),
        const Gap(Insets.med),
        ShadowContainer(
          child: Padding(
            padding: Insets.padAll,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  TR.of(context).thumbnail_image,
                  style: context.textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(Insets.def),
                if (productState.featuredImage.isNotNullOrEmpty()) ...[
                  ProductImageCard(
                    image: productState.featuredImage!,
                    onDelete: productState.featuredImage?.fold(
                      (l) => null,
                      (r) => () => productCtrl().updateThumbImage(null),
                    ),
                  ),
                  const Gap(Insets.def),
                ],
                ChooseButton(
                  name: 'featured_image',
                  onTap: (files) {
                    productCtrl().updateThumbImage(files.first);
                  },
                  imageDimension: sizeGuide?.feature,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
