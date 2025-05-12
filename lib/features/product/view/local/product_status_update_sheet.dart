import 'package:flutter/material.dart';
import 'package:seller_management/features/add_product/controller/add_digital_ctrl.dart';
import 'package:seller_management/features/add_product/controller/add_product_ctrl.dart';
import 'package:seller_management/main.export.dart';

class ProductStatusUpdateSheet extends HookConsumerWidget {
  const ProductStatusUpdateSheet({
    required this.product,
    super.key,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = useState(product.isPublished);

    final updateDigital = useCallback(
      () async {
        final ctrl = ref.read(digitalStoreCtrlProvider(product).notifier);
        ctrl.updateStatus(selected.value);
        await ctrl.updateProductData(product.uid);
      },
      [selected.value],
    );
    final updatePhysical = useCallback(
      () async {
        final ctrl = ref.read(physicalStoreCtrlProvider(product).notifier);
        ctrl.updateStatus(selected.value);
        await ctrl.updateProductData(product.uid);
      },
      [selected.value],
    );

    return Padding(
      padding: Insets.padAll,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Update Status',
            style: context.textTheme.titleLarge,
          ),
          const Gap(Insets.med),
          DropDownField<bool>(
            hintText: 'Select',
            itemCount: 2,
            value: selected.value,
            onChanged: (v) {
              selected.value = v ?? false;
            },
            itemBuilder: (c, i) {
              return DropdownMenuItem(
                value: i == 0 ? true : false,
                child: Text(i == 0 ? 'Published' : 'Inactive'),
              );
            },
          ),
          const Gap(Insets.offset),
          SubmitButton(
            onPressed: (l) async {
              l.value = true;
              if (product.isDigital) {
                await updateDigital();
              } else {
                await updatePhysical();
              }
              l.value = false;

              if (context.mounted) context.nPop();
            },
            child: Text(TR.of(context).update),
          ),
        ],
      ),
    );
  }
}
