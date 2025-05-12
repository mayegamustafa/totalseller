import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:seller_management/features/auth/controller/auth_ctrl.dart';
import 'package:seller_management/features/settings/controller/settings_ctrl.dart';
import 'package:seller_management/main.export.dart';
import 'package:seller_management/routes/go_route_name.dart';

class SignUpView extends HookConsumerWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(GlobalKey<FormBuilderState>.new);
    final authCtrl = useCallback(() => ref.read(authCtrlProvider.notifier));

    final hidePass = useState(true);
    final hideCPass = useState(true);

    return SafeArea(
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () async => ref.invalidate(settingsCtrlProvider),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: FormBuilder(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(Insets.offset),
                  IconButton(
                    onPressed: () => context.pop(),
                    icon: const Icon(Icons.arrow_back),
                  ),
                  const Gap(Insets.xl),
                  Center(
                    child: SvgPicture.asset(
                      AssetsConst.signUp,
                      width: context.width,
                      height: context.height / 4,
                    ),
                  ),
                  const Gap(Insets.offset),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        TR.of(context).create_account,
                        style: context.textTheme.headlineSmall,
                      ),
                      Text(
                        TR.of(context).please_fill_the_input,
                        style: context.textTheme.bodyLarge,
                      ),
                      const Gap(Insets.lg),
                      Text(
                        TR.of(context).user_name,
                        style: context.textTheme.bodyLarge,
                      ).markAsRequired(),
                      const Gap(Insets.sm),
                      FormBuilderTextField(
                        name: 'username',
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: TR.of(context).enter_user_name,
                        ),
                        validator: FormBuilderValidators.compose(
                          [
                            FormBuilderValidators.required(),
                          ],
                        ),
                      ),
                      const Gap(Insets.lg),
                      Text(TR.of(context).email,
                              style: context.textTheme.bodyLarge)
                          .markAsRequired(),
                      const Gap(Insets.sm),
                      FormBuilderTextField(
                        name: 'email',
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: TR.of(context).enter_email,
                        ),
                        validator: FormBuilderValidators.compose(
                          [
                            FormBuilderValidators.required(),
                          ],
                        ),
                      ),
                      const Gap(Insets.lg),
                      Text(
                        TR.of(context).password,
                        style: context.textTheme.bodyLarge,
                      ).markAsRequired(),
                      const Gap(Insets.sm),
                      FormBuilderTextField(
                        name: 'password',
                        textInputAction: TextInputAction.next,
                        obscureText: hidePass.value,
                        decoration: InputDecoration(
                          hintText: TR.of(context).enter_password,
                          suffixIcon: IconButton(
                            focusNode: FocusNode(skipTraversal: true),
                            onPressed: () => hidePass.value = !hidePass.value,
                            icon: const Icon(Icons.visibility),
                          ),
                        ),
                        validator: FormBuilderValidators.compose(
                          [
                            FormBuilderValidators.required(),
                          ],
                        ),
                      ),
                      const Gap(Insets.lg),
                      Text(
                        TR.of(context).confirm_password,
                        style: context.textTheme.bodyLarge,
                      ).markAsRequired(),
                      const Gap(Insets.sm),
                      FormBuilderTextField(
                        name: 'password_confirmation',
                        obscureText: hideCPass.value,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          hintText: TR.of(context).confirm_password,
                          suffixIcon: IconButton(
                            focusNode: FocusNode(skipTraversal: true),
                            onPressed: () => hideCPass.value = !hideCPass.value,
                            icon: const Icon(Icons.visibility),
                          ),
                        ),
                        validator: FormBuilderValidators.compose(
                          [
                            FormBuilderValidators.required(),
                          ],
                        ),
                      ),
                      const Gap(Insets.xl),
                      Center(
                        child: SubmitButton(
                          width: context.width / 1.6,
                          style: FilledButton.styleFrom(
                            shape: const StadiumBorder(),
                          ),
                          onPressed: (l) async {
                            final state = formKey.currentState!;
                            if (!state.saveAndValidate()) return;

                            final data = state.value;
                            l.value = true;

                            await authCtrl().register(data);

                            l.value = false;
                          },
                          child: Text(
                            TR.of(context).sign_up,
                          ),
                        ),
                      ),
                      const Gap(Insets.offset),
                      Center(
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text:
                                    '${TR.of(context).already_have_account}? ',
                              ),
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap =
                                      () => RouteNames.login.pushNamed(context),
                                text: TR.of(context).sign_in,
                                style: TextStyle(
                                  color: context.colors.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Gap(Insets.offset),
                    ],
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
