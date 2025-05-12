import 'package:flutter/material.dart';
import 'package:seller_management/main.export.dart';
import 'package:seller_management/routes/routes.dart';

class AfterPaymentView extends HookConsumerWidget {
  const AfterPaymentView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final trxNo = context.query('id');
    final statusQu = context.query('status');
    final data = context.query('data');

    final status = useState(statusQu);
    final isLoading = useState(false);

    // useEffect(
    //   () {
    //     Future(() {});
    //     return null;
    //   },
    //   [statusQu],
    // );

    // checkOrderStatus() async {
    //   // if (trxNo == null) return;
    //   // isLoading.value = true;

    //   // final payStatus =
    //   //     await ref.read(orderPaymentLogProvider.notifier).statusCheck(trxNo);

    //   // isLoading.value = false;
    //   // status.value = payStatus;
    //   // HapticFeedback.lightImpact();
    // }

    // useOnAppLifecycleStateChange(
    //   (_, c) {
    //     if (c == AppLifecycleState.resumed) checkOrderStatus();
    //   },
    // );

    final color = switch (status.value) {
      's' || '2' => context.colors.errorContainer,
      'w' || '1' => Colors.orange,
      _ => context.colors.error,
    };
    final icon = switch (status.value) {
      's' || '2' => Icons.done,
      'w' || '1' => Icons.hourglass_bottom_rounded,
      _ => Icons.close,
    };
    final title = switch (status.value) {
      's' || '2' => 'Deposit Success',
      'w' || '1' => 'Deposit Processing',
      _ => 'Deposit Failed',
    };
    final text = switch (status.value) {
      's' || '2' => 'Your payment has been successfully processed',
      'w' || '1' => 'Please wait while we process your payment',
      _ => 'Payment Failed, Please try again',
    };

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          // checkOrderStatus();
        },
        child: Stack(
          children: [
            if (isLoading.value) const LinearProgressIndicator(),
            SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: Insets.padAll,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    AssetsConst.paymentIllustration,
                    height: 300,
                    width: double.infinity,
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Icon(icon, size: 20, color: color),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    title,
                    style: context.textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    text,
                    style: context.textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 5),
                  if (data != null)
                    Text(
                      data,
                      style: context.textTheme.bodyLarge,
                    ),
                  const SizedBox(height: 30),
                  SubmitButton(
                    onPressed: (l) => RouteNames.home.goNamed(context),
                    child: Text(TR.of(context).goToHome),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
