import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:seller_management/features/add_product/controller/add_digital_ctrl.dart';
import 'package:seller_management/main.export.dart';

class MetaDataCard extends HookConsumerWidget {
  const MetaDataCard({
    super.key,
    required this.editingProduct,
  });

  final ProductModel? editingProduct;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productState = ref.watch(digitalStoreCtrlProvider(editingProduct));
    final productCtrl = useCallback(
        () => ref.read(digitalStoreCtrlProvider(editingProduct).notifier));
    final keywordCtrl = useTextEditingController();

    return ExpansionTile(
      maintainState: true,
      tilePadding: const EdgeInsets.all(0),
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      title: Text(
        TR.of(context).meta_data,
        style: context.textTheme.titleLarge,
      ),
      children: [
        Text(
          TR.of(context).meta_title,
          style: context.textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const Gap(Insets.med),
        FormBuilderTextField(
          name: 'meta_title',
          initialValue: productState.metaTitle,
          decoration: InputDecoration(
            hintText: TR.of(context).enter_meta_title,
          ),
        ),
        const Gap(Insets.lg),
        Text(
          TR.of(context).meta_keyword,
          style: context.textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const Gap(Insets.med),
        FormBuilderTextField(
          name: 'meta_keywords',
          controller: keywordCtrl,
          decoration: InputDecoration(
            hintText: TR.of(context).type_keywords,
            suffixIcon: GestureDetector(
              onTap: () {
                final txt = keywordCtrl.text;
                if (txt.isEmpty) return;
                productCtrl().updateMetaKeyword(txt);
                keywordCtrl.clear();
              },
              child: Icon(
                Icons.add,
                color: context.colors.primary,
                size: 20,
              ),
            ),
          ),
        ),
        if (productState.metaKeywords != null)
          SizedBox(
            height: 50,
            child: ListView.separated(
              itemCount: productState.metaKeywords!.length,
              scrollDirection: Axis.horizontal,
              separatorBuilder: (_, __) => const Gap(Insets.sm),
              itemBuilder: (context, index) {
                final keyword = productState.metaKeywords![index];
                return Center(
                  child: SimpleChip(
                    label: keyword,
                    onDeleteTap: () {
                      productCtrl().updateMetaKeyword(keyword);
                    },
                  ),
                );
              },
            ),
          ),
        const Gap(Insets.lg),
        Text(
          TR.of(context).meta_description,
          style: context.textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const Gap(Insets.med),
        FormBuilderTextField(
          name: 'meta_description',
          initialValue: productState.metaDescription,
          maxLines: 3,
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
            hintText: TR.of(context).meta_description,
          ),
        ),
        const Gap(Insets.med),
      ],
    );
  }
}
