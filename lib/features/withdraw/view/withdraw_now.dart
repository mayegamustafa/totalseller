import 'package:collection/collection.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:seller_management/features/withdraw/controller/withdraw_ctrl.dart';
import 'package:seller_management/features/withdraw/view/local/withdraw_confirm_dialog.dart';
import 'package:seller_management/features/withdraw/view/local/withdraw_method_card.dart';
import 'package:seller_management/main.export.dart';

class WithdrawNowView extends HookConsumerWidget {
  const WithdrawNowView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final methodList = ref.watch(withdrawMethodsProvider);

    final selected = useState<WithdrawMethod?>(null);
    final formKey = useMemoized(GlobalKey<FormBuilderState>.new);

    Future<void> request(QMap data) async {
      final ctrl = ref.read(withdrawCtrlProvider.notifier);
      await ctrl.request('${selected.value!.id}', data['amount']);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          TR.of(context).withdraw_now,
        ),
      ),
      body: methodList.when(
        loading: () => Loader.grid(12, 4),
        error: (err, st) =>
            ErrorView(err, st, invalidate: withdrawMethodsProvider),
        data: (methods) {
          return Padding(
            padding: Insets.padAll,
            child: Column(
              children: [
                Expanded(
                  flex: 8,
                  child: RefreshIndicator(
                    onRefresh: () async {
                      final data =
                          await ref.refresh(withdrawMethodsProvider.future);
                      final match = data
                          .firstWhereOrNull((e) => e.id == selected.value?.id);

                      selected.value = match;
                    },
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: FormBuilder(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Gap(Insets.lg),
                            Text(
                              TR.of(context).withdraw_method,
                              style: context.textTheme.titleLarge,
                            ),
                            const Gap(Insets.lg),
                            if (selected.value != null)
                              ShadowContainer(
                                child: Padding(
                                  padding: Insets.padAll,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${TR.of(context).method_details} :',
                                        style: context.textTheme.bodyLarge,
                                      ),
                                      const Divider(),
                                      const Gap(Insets.med),
                                      SpacedText(
                                        left: TR.of(context).withdraw_limit,
                                        right: selected.value!.limit,
                                      ),
                                      const Gap(Insets.med),
                                      SpacedText(
                                        left: TR.of(context).charge,
                                        right: selected.value!.chargeString,
                                      ),
                                      const Gap(Insets.med),
                                      SpacedText(
                                        left: TR.of(context).processing_time,
                                        right: selected.value!.durationString,
                                      ),
                                      const Gap(Insets.med),
                                      Text(
                                        TR.of(context).description,
                                      ),
                                      Html(
                                        data: selected.value!.description,
                                        shrinkWrap: true,
                                      ),
                                      const Divider(),
                                      const Gap(Insets.def),
                                      FormBuilderTextField(
                                        name: 'amount',
                                        textInputAction: TextInputAction.next,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        decoration: InputDecoration(
                                          hintText: TR.of(context).enter_amount,
                                        ),
                                        validator:
                                            FormBuilderValidators.compose([
                                          FormBuilderValidators.required(),
                                          (value) {
                                            final val = num.parse(value ?? '0');
                                            if (val <
                                                selected.value!.minLimit) {
                                              return TR
                                                  .of(context)
                                                  .amount_is_too_low;
                                            }
                                            if (val >
                                                selected.value!.maxLimit) {
                                              return TR
                                                  .of(context)
                                                  .amount_exceeds_max_limit;
                                            }
                                            return null;
                                          },
                                        ]),
                                      ),
                                      if (selected.value?.customInputs !=
                                          null) ...[
                                        const Gap(Insets.def),
                                        Text(
                                          '${TR.of(context).withdraw_Info} :',
                                          style: context.textTheme.bodyLarge,
                                        ),
                                        const Gap(Insets.def),
                                        _CustomInputFields(
                                          inputs: selected.value!.customInputs,
                                          key: ValueKey(selected.value!.id),
                                        ),
                                      ]
                                    ],
                                  ),
                                ),
                              )
                            else
                              DecoratedContainer(
                                color: context.colors.errorContainer
                                    .withOpacity(.05),
                                padding: Insets.padAll,
                                borderRadius: Corners.med,
                                alignment: Alignment.center,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SvgPicture.asset(
                                      AssetsConst.idea,
                                      height: 25,
                                    ),
                                    const Gap(Insets.med),
                                    Expanded(
                                      child: Text(
                                        TR.of(context).withdraw_method_title,
                                        style: context.textTheme.bodyLarge!
                                            .copyWith(
                                          color: context.colors.errorContainer,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            const Gap(Insets.xl),
                            Text(
                              TR.of(context).all_withdraw_method,
                              style: context.textTheme.titleLarge,
                            ),
                            const Gap(Insets.lg),
                            MasonryGridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              mainAxisSpacing: Insets.def,
                              crossAxisSpacing: Insets.def,
                              gridDelegate:
                                  SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: context.onMobile ? 3 : 5,
                              ),
                              itemCount: methods.length,
                              itemBuilder: (context, index) {
                                final method = methods[index];
                                return WithdrawMethodCard(
                                  method: method,
                                  isSelected: method.id == selected.value?.id,
                                  onSelected: (method) {
                                    selected.value = method;
                                    formKey.currentState?.reset();
                                  },
                                );
                              },
                            ),
                            const Gap(Insets.offset),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => context.pop(),
                        child: Text(
                          TR.of(context).cancel,
                        ),
                      ),
                    ),
                    const Gap(Insets.med),
                    Expanded(
                      child: SubmitButton.dense(
                        onPressed: selected.value == null
                            ? null
                            : (l) async {
                                final state = formKey.currentState!;
                                if (!state.saveAndValidate()) return;

                                l.value = true;

                                final data = state.value.nonNull();
                                await request(data);
                                l.value = false;

                                if (!context.mounted) return;
                                showDialog(
                                  context: context,
                                  builder: (ctx) =>
                                      WithdrawConfirmDialog(formData: data),
                                );
                              },
                        child: Text(
                          TR.of(context).submit,
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
    );
  }
}

class _CustomInputFields extends StatelessWidget {
  const _CustomInputFields({
    super.key,
    required this.inputs,
  });
  final List<CustomInput> inputs;
  @override
  Widget build(BuildContext context) {
    return SeparatedColumn(
      separatorBuilder: () => const Gap(Insets.lg),
      children: [
        for (var input in inputs)
          FormBuilderTextField(
            name: input.name,
            textInputAction: input.isTextArea()
                ? TextInputAction.newline
                : TextInputAction.next,
            maxLines: input.isTextArea() ? 3 : 1,
            decoration: InputDecoration(
              labelText: input.label,
              alignLabelWithHint: true,
            ),
            validator: input.required ? FormBuilderValidators.required() : null,
          ),
      ],
    );
  }
}
