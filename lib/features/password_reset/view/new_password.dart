import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:seller_management/main.export.dart';
import 'package:seller_management/routes/routes.dart';

import '../../auth/controller/password_reset_ctrl.dart';

class NewPasswordView extends HookConsumerWidget {
  const NewPasswordView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final resetCtrl =
        useCallback(() => ref.read(passwordResetCtrlProvider.notifier));

    return Scaffold(
      body: FormBuilder(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const Gap(80),
              SvgPicture.asset(
                AssetsConst.passwordReset,
                height: 80,
              ),
              const Gap(Insets.med),
              Text(
                TR.of(context).reset_password,
                style: context.textTheme.headlineMedium,
              ),
              const Gap(Insets.offset),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    TR.of(context).new_password,
                    style: context.textTheme.bodyLarge,
                  ),
                  const Gap(Insets.med),
                  FormBuilderTextField(
                    name: 'password',
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: TR.of(context).enter_new_password,
                    ),
                    validator: FormBuilderValidators.required(),
                  ),
                  const Gap(Insets.lg),
                  Text(
                    TR.of(context).confirm_password,
                    style: context.textTheme.bodyLarge,
                  ),
                  const Gap(Insets.med),
                  FormBuilderTextField(
                    name: 'password_confirmation',
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      hintText: TR.of(context).enter_confirm_password,
                    ),
                    validator: FormBuilderValidators.required(),
                  ),
                ],
              ),
              const Gap(Insets.xl),
              SizedBox(
                height: 50,
                width: context.width / 1.6,
                child: SubmitButton(
                  style: FilledButton.styleFrom(
                    shape: const StadiumBorder(),
                  ),
                  onPressed: (l) async {
                    final state = formKey.currentState!;
                    if (!state.saveAndValidate()) return;

                    l.value = true;
                    resetCtrl().setPassword(state.value);

                    final result = await resetCtrl().resetPass();
                    l.value = false;

                    if (context.mounted) {
                      if (result) {
                        RouteNames.login.pushNamed(context);
                      } else {
                        RouteNames.newPassword.goNamed(context);
                        state.reset();
                      }
                    }
                  },
                  child: Text(
                    TR.of(context).change_password,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
