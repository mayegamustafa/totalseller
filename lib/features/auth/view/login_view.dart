import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:seller_management/features/auth/controller/auth_ctrl.dart';
import 'package:seller_management/features/settings/controller/settings_ctrl.dart';
import 'package:seller_management/main.export.dart';
import 'package:seller_management/routes/routes.dart';

class LoginView extends HookConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsData = ref.watch(settingsCtrlProvider);
    final authCtrl = useCallback(() => ref.read(authCtrlProvider.notifier));
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final doLogOut = context.query('logout');
    final msg = context.query('msg');

    Future<void> init() async {
      if (msg != null) {
        Toaster.showInfo(msg);
        await Future.delayed(3.seconds);
      }
      if (doLogOut == 'true') {
        ref.read(authCtrlProvider.notifier).logout(false);
      }
    }

    useEffect(() {
      Future.delayed(0.ms, () => init());

      return null;
    }, const []);

    Future submit() async {
      final state = formKey.currentState!;
      if (!state.saveAndValidate()) return;
      final {'name': name, 'pass': pass} = state.value;

      await authCtrl().login(name, pass);
    }

    return SafeArea(
      child: Scaffold(
        body: settingsData.when(
          loading: () => const Loader(),
          error: (err, st) => ErrorView(
            err,
            st,
            onReload: () => ref.read(settingsCtrlProvider.notifier).reload(),
          ),
          data: (settings) {
            return RefreshIndicator(
              onRefresh: () async => ref.invalidate(settingsCtrlProvider),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: SvgPicture.asset(
                        AssetsConst.login,
                        width: context.width,
                        height: context.height / 3,
                      ),
                    ),
                    const Gap(Insets.offset),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: FormBuilder(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              TR.of(context).login,
                              style: context.textTheme.titleLarge,
                            ),
                            Text(
                              TR.of(context).please_sign_in,
                              style: context.textTheme.bodyLarge,
                            ),
                            const Gap(Insets.lg),
                            FormBuilderTextField(
                              name: 'name',
                              initialValue: 'demoseller',
                              decoration: InputDecoration(
                                hintText: TR.of(context).enter_user_name,
                              ),
                            ),
                            const Gap(Insets.lg),
                            FormBuilderTextField(
                              name: 'pass',
                              initialValue: '123123',
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: TR.of(context).enter_password,
                              ),
                            ),
                            const Gap(Insets.xl),
                            Center(
                              child: SizedBox(
                                height: 50,
                                width: context.width / 1.6,
                                child: SubmitButton(
                                  style: FilledButton.styleFrom(
                                    shape: const StadiumBorder(),
                                  ),
                                  onPressed: (load) async {
                                    load.value = true;
                                    await submit();
                                    load.value = false;
                                  },
                                  child: Text(TR.of(context).login),
                                ),
                              ),
                            ),
                            const Gap(Insets.sm),
                            Center(
                              child: GestureDetector(
                                onTap: () =>
                                    RouteNames.passwordReset.pushNamed(context),
                                child: Text(
                                    '${TR.of(context).forgot_password}?',
                                    style:
                                        context.textTheme.bodyLarge!.copyWith(
                                      color: context.colors.primary,
                                    )),
                              ),
                            ),
                            const Gap(Insets.offset),
                            if (settings.config.registration)
                              Center(
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            TR.of(context).do_not_have_account,
                                        style: context.textTheme.bodyLarge,
                                      ),
                                      TextSpan(
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () => RouteNames.signUp
                                              .goNamed(context),
                                        text:
                                            ' ${TR.of(context).create_account}',
                                        style: context.textTheme.bodyLarge!
                                            .copyWith(
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
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
