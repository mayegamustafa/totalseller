import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';
import 'package:seller_management/features/add_product/controller/add_product_ctrl.dart';
import 'package:seller_management/main.export.dart';

class ProductMetaSheet extends HookConsumerWidget {
  const ProductMetaSheet({
    super.key,
    required this.editingProduct,
  });

  final ProductModel? editingProduct;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productState = ref.watch(physicalStoreCtrlProvider(editingProduct));

    final productCtrl = useCallback(
        () => ref.read(physicalStoreCtrlProvider(editingProduct).notifier));

    final formKey = useMemoized(GlobalKey<FormBuilderState>.new);
    final keywordCtrl = useTextEditingController();

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SizedBox(
        height: context.height * .8,
        child: SingleChildScrollView(
          child: ShadowContainer(
            padding: Insets.padAll,
            child: FormBuilder(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    TR.of(context).meta_data,
                    style: context.textTheme.titleLarge,
                  ),
                  const Gap(Insets.med),
                  const Divider(),
                  const Gap(Insets.med),
                  Text(
                    TR.of(context).meta_title,
                    style: context.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Gap(Insets.sm),
                  //!
                  FormBuilderTextField(
                    name: 'meta_title',
                    initialValue: productState.metaTitle,
                    decoration: InputDecoration(
                      hintText: TR.of(context).title,
                    ),
                  ),
                  const Gap(Insets.med),

                  //!

                  FormBuilderTextField(
                    name: 'meta_keywords_list',
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
                  const Gap(Insets.med),
                  Text(
                    TR.of(context).meta_description,
                    style: context.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Gap(Insets.sm),
                  //!
                  FormBuilderTextField(
                    name: 'meta_description',
                    initialValue: productState.metaDescription,
                    decoration: InputDecoration(
                      hintText: TR.of(context).description,
                    ),
                    maxLines: 3,
                  ),

                  const Gap(Insets.offset),
                  SubmitButton(
                    onPressed: (l) {
                      final state = formKey.currentState!;

                      if (!state.saveAndValidate()) return;
                      final data = {...state.value};

                      productCtrl().addInfoFromMap(data);

                      context.pop();
                    },
                    child: Text(
                      TR.of(context).submit,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
