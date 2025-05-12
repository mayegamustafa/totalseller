import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:seller_management/features/dashboard/controller/dash_ctrl.dart';
import 'package:seller_management/features/deposit/controller/deposit_ctrl.dart';
import 'package:seller_management/features/payment/controller/payment_ctrl.dart';
import 'package:seller_management/features/region/controller/region_ctrl.dart';
import 'package:seller_management/features/settings/controller/settings_ctrl.dart';
import 'package:seller_management/main.export.dart';

class DepositPaymentView extends HookConsumerWidget {
  const DepositPaymentView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashBoard = ref.watch(dashBoardCtrlProvider);
    final depositMethod = ref.watch(depositCtrlProvider);
    final formKey = useMemoized(GlobalKey<FormBuilderState>.new);
    final region = ref.watch(regionCtrlProvider);
    final settings = ref.watch(localSettingsProvider);

    if (settings == null) {
      return ErrorView(
        'Settings not found',
        null,
        invalidate: settingsCtrlProvider,
      );
    }

    final Config(minDepositAmount: min, maxDepositAmount: max) =
        settings.config;

    return Scaffold(
      appBar: AppBar(
        title: Text(TR.of(context).depositMethod),
      ),
      bottomNavigationBar: SubmitButton(
        padding: Insets.padAll,
        onPressed: depositMethod == null
            ? null
            : (l) async {
                final state = formKey.currentState!;
                if (!state.saveAndValidate()) return;

                l.value = true;

                final data = state.value.nonNull();

                final amount = data.parseNum('amount') / region.currency!.rate;
                data['amount'] = amount;

                final ctrl = ref.read(depositCtrlProvider.notifier);
                final deposit = await ctrl.makeDeposit(data);
                Logger.json(deposit?.toMap(), 'DEPOSIT');

                l.value = false;
                if (!context.mounted) return;
                if (deposit == null) return;

                if (deposit.paymentMethod.isManual) return context.pop();

                await ref
                    .read(paymentCtrlProvider.notifier)
                    .initializePayment(context, deposit);
              },
        child: Text(TR.of(context).deposit),
      ),
      body: SingleChildScrollView(
        padding: Insets.padAll,
        physics: const AlwaysScrollableScrollPhysics(),
        child: FormBuilder(
          key: formKey,
          child: Column(
            children: [
              dashBoard.when(
                error: (e, s) => ErrorView(e, s),
                loading: () => Loader.shimmer(30, 200),
                data: (dash) => Container(
                  decoration: BoxDecoration(
                    borderRadius: Corners.medBorder,
                    color: context.colors.primary.withOpacity(.05),
                  ),
                  child: Padding(
                    padding: Insets.padAll,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: Corners.medBorder,
                        color: context.colors.onPrimaryContainer,
                      ),
                      child: Padding(
                        padding: Insets.padAll,
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor:
                                      context.colors.primary.withOpacity(.05),
                                  child: Lottie.asset(
                                    AssetsConst.balanceAnimation,
                                    height: 100,
                                    width: 100,
                                  ),
                                ),
                                const Gap(Insets.med),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Total Balance: ${dash.seller.balance.formate()}',
                                      style: context.textTheme.bodyLarge,
                                    ),
                                    const Gap(Insets.sm),
                                    SizedBox(
                                      width: context.width / 1.5,
                                      child: Text(
                                        'Withdraw Limit: Min ${min.formate(rateCheck: true)} - Max ${max.formate(rateCheck: true)}',
                                        style: context.textTheme.bodyMedium,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const Gap(Insets.lg),
              ShadowContainer(
                padding: Insets.padAll,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Payment Method : ',
                          style: context.textTheme.titleLarge,
                        ),
                        const Spacer(),
                        IconButton.outlined(
                          onPressed: () => showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            showDragHandle: true,
                            builder: (c) => MethodsSheet(
                              onSelected: (v) => ref
                                  .read(depositCtrlProvider.notifier)
                                  .setMethod(v),
                              selectedMethod: depositMethod,
                            ),
                          ),
                          icon: Icon(
                            depositMethod == null
                                ? Icons.arrow_forward_ios_rounded
                                : Icons.edit_rounded,
                            color: context.colors.primary,
                          ),
                        ),
                      ],
                    ),
                    const Gap(Insets.sm),
                    if (depositMethod == null)
                      Text(
                        'Select payment method',
                        style: context.textTheme.bodyLarge?.bold,
                      )
                    else ...[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HostedImage.square(
                            depositMethod.image,
                            dimension: 100,
                          ),
                          const Gap(Insets.def),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  depositMethod.name,
                                  style: context.textTheme.bodyLarge,
                                ),
                                Text(
                                  'Charge : ${depositMethod.percentCharge.formate()}%',
                                ),
                                Text(
                                  'Currency : ${depositMethod.currency.name}',
                                ),
                                Text(
                                  'Rate :  ${1.formate(useSymbol: false, useBase: true)} = ${depositMethod.currencyRate}',
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ]
                  ],
                ),
              ),
              const Gap(Insets.med),
              if (depositMethod != null)
                ShadowContainer(
                  offset: const Offset(0, 0),
                  padding: Insets.padAll,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Deposit amount',
                        style: context.textTheme.bodyMedium,
                      ).markAsRequired(),
                      const Gap(Insets.sm),
                      FormBuilderTextField(
                        name: 'amount',
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Enter amount',
                          prefixIcon: ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxHeight: 20,
                              maxWidth: 20,
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 15,
                                child: Text(
                                  region.currency?.symbol ?? '\$',
                                  style: context.textTheme.titleMedium?.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        validator: FormBuilderValidators.compose(
                          [
                            FormBuilderValidators.required(),
                            FormBuilderValidators.min(
                              min.formateSelf(rateCheck: true),
                            ),
                            FormBuilderValidators.max(
                              max.formateSelf(rateCheck: true),
                            ),
                          ],
                        ),
                      ),
                      const Gap(Insets.med),
                      for (var field in depositMethod.customParameters) ...[
                        Text(
                          field.name.replaceAll('_', ' ').toTitleCase,
                          style: context.textTheme.bodyMedium,
                        ).markAsRequired(field.isRequired),
                        const Gap(Insets.sm),
                        Row(
                          children: [
                            Flexible(
                              child: FormBuilderTextField(
                                name: field.name,
                                textInputAction: field.type.isTextArea
                                    ? TextInputAction.newline
                                    : TextInputAction.next,
                                maxLines: field.type.isTextArea ? 3 : 1,
                                keyboardType: field.type.isEmail
                                    ? TextInputType.emailAddress
                                    : (field.type.isDate
                                        ? TextInputType.datetime
                                        : null),
                                validator: FormBuilderValidators.compose(
                                  [
                                    if (field.isRequired)
                                      FormBuilderValidators.required(),
                                    (v) {
                                      if (field.type.isEmail &&
                                          v?.isNotEmpty == true) {
                                        return FormBuilderValidators.email()
                                            .call(v);
                                      }
                                      return null;
                                    }
                                  ],
                                ),
                              ),
                            ),
                            if (field.type.isDate)
                              IconButton.filled(
                                onPressed: () async {
                                  final date = await showDatePicker(
                                    context: context,
                                    firstDate: DateTime(1950),
                                    lastDate: DateTime.now().add(30.days),
                                  );
                                  if (date != null) {
                                    formKey.currentState!.fields[field.name]
                                        ?.didChange(date.formatDate());
                                  }
                                },
                                icon: const Icon(
                                  Icons.calendar_month_rounded,
                                ),
                              ),
                          ],
                        ),
                        const Gap(Insets.med),
                      ]
                    ],
                  ),
                ),
              const Gap(Insets.med),
            ],
          ),
        ),
      ),
    );
  }
}

class MethodsSheet extends HookConsumerWidget {
  const MethodsSheet({
    super.key,
    required this.onSelected,
    this.selectedMethod,
  });

  final Function(PaymentMethod? method) onSelected;
  final PaymentMethod? selectedMethod;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(localSettingsProvider);
    final methods = settings?.paymentMethods ?? [];

    return SizedBox(
      height: context.height * .8,
      child: Padding(
        padding: Insets.padAll,
        child: Column(
          children: [
            Text('Payment Methods', style: context.textTheme.titleLarge),
            const Gap(Insets.def),
            Expanded(
              child: MasonryGridView.builder(
                shrinkWrap: true,
                gridDelegate:
                    const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                mainAxisSpacing: Insets.med,
                crossAxisSpacing: Insets.med,
                itemCount: methods.length,
                itemBuilder: (context, index) {
                  final method = methods[index];
                  final isSelected = selectedMethod?.id == method.id;
                  return Stack(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await onSelected(method);
                          if (context.mounted) context.nPop();
                        },
                        child: DecoratedContainer(
                          padding: Insets.padAll,
                          borderColor: context.colors.primary,
                          borderWidth: isSelected ? 1 : 0,
                          borderRadius: Corners.med,
                          shadows: [
                            BoxShadow(
                              blurRadius: 5,
                              color: context.colors.secondaryContainer
                                  .withOpacity(0.1),
                              offset: const Offset(0, 0),
                            ),
                          ],
                          color: context.colors.onPrimary,
                          child: Column(
                            children: [
                              HostedImage(method.image),
                              const Gap(Insets.sm),
                              Text(
                                method.name,
                                style: context.textTheme.titleMedium,
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
                      ),
                      if (isSelected)
                        Positioned(
                          top: 5,
                          right: 5,
                          child: Icon(
                            Icons.check_circle_outline,
                            color: context.colors.primary,
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
