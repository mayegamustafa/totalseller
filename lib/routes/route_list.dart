import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:seller_management/features/add_product/view/add_product_view.dart';
import 'package:seller_management/features/auth/view/change_password.dart';
import 'package:seller_management/features/auth/view/login_view.dart';
import 'package:seller_management/features/auth/view/sign_up.dart';
import 'package:seller_management/features/campaign/view/campaign_view.dart';
import 'package:seller_management/features/chat/view/customer_chat_list_view.dart';
import 'package:seller_management/features/chat/view/customer_chat_view.dart';
import 'package:seller_management/features/dashboard/view/dash_view.dart';
import 'package:seller_management/features/dashboard/view/home_init_page.dart';
import 'package:seller_management/features/deposit/view/deposit_payment_view.dart';
import 'package:seller_management/features/deposit/view/deposit_view.dart';
import 'package:seller_management/features/kyc/view/kyc_logs_view.dart';
import 'package:seller_management/features/kyc/view/verify_kyc_view.dart';
import 'package:seller_management/features/order/view/order_details_view.dart';
import 'package:seller_management/features/order/view/order_view.dart';
import 'package:seller_management/features/password_reset/view/new_password.dart';
import 'package:seller_management/features/password_reset/view/password_reset.dart';
import 'package:seller_management/features/payment/view/after_payment_page.dart';
import 'package:seller_management/features/product/view/product_view.dart';
import 'package:seller_management/features/profile/view/profile_view.dart';
import 'package:seller_management/features/region/view/currency_view.dart';
import 'package:seller_management/features/seller_info/view/seller_profile_view.dart';
import 'package:seller_management/features/settings/controller/settings_ctrl.dart';
import 'package:seller_management/features/subscription/view/plan_update_view.dart';
import 'package:seller_management/features/subscription/view/subscription_view.dart';
import 'package:seller_management/features/support_ticket/view/ticket_list.dart';
import 'package:seller_management/features/support_ticket/view/ticket_view.dart';
import 'package:seller_management/features/total_balance/view/total_balance_view.dart';
import 'package:seller_management/features/withdraw/view/withdraw_now.dart';
import 'package:seller_management/features/withdraw/view/withdraw_view.dart';
import 'package:seller_management/main.export.dart';
import 'package:seller_management/navigation/navigation_root.dart';
import 'package:seller_management/routes/page/no_sub.dart';
import 'package:seller_management/routes/page/seller_banned.dart';
import 'package:seller_management/routes/routes.dart';

import '../features/add_product/view/add_digital_product.dart';
import '../features/chat/view/messages_tab_view.dart';
import '../features/kyc/view/kyc_view.dart';
import '../features/password_reset/view/otp_alert.dart';
import '../features/product/view/product_details_view.dart';
import '../features/region/view/language_view.dart';
import '../features/seller_info/view/store_info_update_view.dart';
import '../features/support_ticket/view/create_ticket.dart';

final routeListProvider = Provider.family
    .autoDispose<List<RouteBase>, GlobalKey<NavigatorState>>((ref, rootKey) {
  final GlobalKey<NavigatorState> shellNavigator =
      GlobalKey(debugLabel: 'shell');

  // final dash = ref.watch(dashBoardCtrlProvider);
  // .selectAsync((data) => data.seller.shop.isShopActive));

  final canRegister = ref.watch(
    settingsCtrlProvider.selectAsync((data) => data.config.registration),
  );

  final routeList = [
    GoRoute(
      path: RouteNames.splash.path,
      name: RouteNames.splash.name,
      pageBuilder: (context, state) =>
          NoTransitionPage(key: state.pageKey, child: const SplashView()),
    ),
    GoRoute(
      path: RouteNames.error.path,
      name: RouteNames.error.name,
      pageBuilder: (context, state) => NoTransitionPage(
        key: state.pageKey,
        child: ErrorRoutePage(
          error: state.uri.queryParameters['e'],
        ),
      ),
    ),
    GoRoute(
      path: RouteNames.verifyKyc.path,
      name: RouteNames.verifyKyc.name,
      pageBuilder: (context, state) => NoTransitionPage(
        key: state.pageKey,
        name: state.name,
        child: const VerifyKYCView(),
      ),
      routes: [
        GoRoute(
          path: RouteNames.kycLogs.path,
          name: RouteNames.kycLogs.name,
          pageBuilder: (context, s) => NoTransitionPage(
            key: s.pageKey,
            name: s.name,
            child: const KYCLogsView(),
          ),
        ),
        GoRoute(
          path: RouteNames.kycLog.path,
          name: RouteNames.kycLog.name,
          pageBuilder: (context, s) => NoTransitionPage(
            key: s.pageKey,
            name: s.name,
            child: s.extra is KYCLog
                ? KYCView(s.extra! as KYCLog)
                : const NotFoundPage(),
          ),
        ),
      ],
    ),
    GoRoute(
      path: RouteNames.noSUbscription.path,
      name: RouteNames.noSUbscription.name,
      pageBuilder: (context, state) => NoTransitionPage(
        key: state.pageKey,
        name: state.name,
        child: const NoSubPage(),
      ),
    ),
    GoRoute(
      path: RouteNames.maintenance.path,
      name: RouteNames.maintenance.name,
      pageBuilder: (context, state) => NoTransitionPage(
        name: state.name,
        key: state.pageKey,
        child: const MaintenancePage(),
      ),
    ),
    GoRoute(
      path: RouteNames.invalidPurchase.path,
      name: RouteNames.invalidPurchase.name,
      pageBuilder: (context, state) => NoTransitionPage(
        name: state.name,
        key: state.pageKey,
        child: const InvalidPurchasePage(),
      ),
    ),
    GoRoute(
      path: RouteNames.sellerBanned.path,
      name: RouteNames.sellerBanned.name,
      pageBuilder: (context, state) => NoTransitionPage(
        name: state.name,
        key: state.pageKey,
        child: const SellerBanned(),
      ),
    ),
    GoRoute(
      path: RouteNames.panelNotActive.path,
      name: RouteNames.panelNotActive.name,
      pageBuilder: (context, state) => NoTransitionPage(
        name: state.name,
        key: state.pageKey,
        child: const PanelInactive(),
      ),
    ),
    GoRoute(
      path: RouteNames.shopNotActive.path,
      name: RouteNames.shopNotActive.name,
      pageBuilder: (context, state) => NoTransitionPage(
        name: state.name,
        key: state.pageKey,
        child: const NotActiveStore(),
      ),
    ),
    GoRoute(
      path: RouteNames.afterPayment.path,
      name: RouteNames.afterPayment.name,
      pageBuilder: (context, state) {
        return NoTransitionPage(
          name: state.name,
          key: state.pageKey,
          child: const AfterPaymentView(),
        );
      },
    ),
    GoRoute(
      path: RouteNames.login.path,
      name: RouteNames.login.name,
      pageBuilder: (context, state) => NoTransitionPage(
        key: state.pageKey,
        child: const LoginView(),
      ),
      routes: [
        GoRoute(
          path: RouteNames.signUp.path,
          name: RouteNames.signUp.name,
          redirect: (context, state) async {
            if (await canRegister) return null;
            return state.namedLocation(RouteNames.login.name);
          },
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const SignUpView(),
          ),
        ),
        GoRoute(
          parentNavigatorKey: rootKey,
          path: RouteNames.passwordReset.path,
          name: RouteNames.passwordReset.name,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: PasswordResetView(),
          ),
        ),
        GoRoute(
          parentNavigatorKey: rootKey,
          path: RouteNames.otpScreen.path,
          name: RouteNames.otpScreen.name,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: OTPScreenView(),
          ),
        ),
        GoRoute(
          parentNavigatorKey: rootKey,
          path: RouteNames.newPassword.path,
          name: RouteNames.newPassword.name,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: NewPasswordView(),
          ),
        ),
      ],
    ),
    ShellRoute(
      navigatorKey: shellNavigator,
      builder: (context, state, child) =>
          NavigationRoot(child, key: state.pageKey),
      routes: [
        //! Home section
        GoRoute(
          path: RouteNames.home.path,
          name: RouteNames.home.name,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const DashBoardView(),
          ),
          routes: [
            GoRoute(
              parentNavigatorKey: rootKey,
              path: RouteNames.updatePass.path,
              name: RouteNames.updatePass.name,
              pageBuilder: (context, state) => NoTransitionPage(
                key: state.pageKey,
                child: const PasswordChangeView(),
              ),
            ),
            GoRoute(
              parentNavigatorKey: rootKey,
              path: RouteNames.campaign.path,
              name: RouteNames.campaign.name,
              pageBuilder: (context, state) {
                final extra = state.extra;
                if (extra is CampaignModel) {
                  return NoTransitionPage(
                    key: state.pageKey,
                    child: CampaignView(extra),
                  );
                }
                return NoTransitionPage(
                  key: state.pageKey,
                  child: const ErrorRoutePage(
                    error: 'Invalid Data',
                  ),
                );
              },
            ),
            GoRoute(
                parentNavigatorKey: rootKey,
                path: RouteNames.withdraw.path,
                name: RouteNames.withdraw.name,
                pageBuilder: (context, state) => NoTransitionPage(
                      key: state.pageKey,
                      child: const WithdrawView(),
                    ),
                routes: [
                  GoRoute(
                    parentNavigatorKey: rootKey,
                    path: RouteNames.withdrawNow.path,
                    name: RouteNames.withdrawNow.name,
                    pageBuilder: (context, state) => NoTransitionPage(
                      key: state.pageKey,
                      child: const WithdrawNowView(),
                    ),
                  ),
                ]),
            GoRoute(
                parentNavigatorKey: rootKey,
                path: RouteNames.deposit.path,
                name: RouteNames.deposit.name,
                pageBuilder: (context, state) => NoTransitionPage(
                      key: state.pageKey,
                      child: const DepositView(),
                    ),
                routes: [
                  GoRoute(
                    parentNavigatorKey: rootKey,
                    path: RouteNames.depositPayment.path,
                    name: RouteNames.depositPayment.name,
                    pageBuilder: (context, state) => NoTransitionPage(
                      key: state.pageKey,
                      child: const DepositPaymentView(),
                    ),
                  ),
                ]),
            // GoRoute(
            //   parentNavigatorKey: rootKey,
            //   path: RouteNames.voucher.path,
            //   name: RouteNames.voucher.name,
            //   pageBuilder: (context, state) => NoTransitionPage(
            //     key: state.pageKey,
            //     child: const VoucherView(),
            //   ),
            // ),
            GoRoute(
              parentNavigatorKey: rootKey,
              path: RouteNames.totalBalance.path,
              name: RouteNames.totalBalance.name,
              pageBuilder: (context, state) => NoTransitionPage(
                key: state.pageKey,
                child: const TotalBalanceView(),
              ),
            ),
          ],
        ),

        //! Order section
        GoRoute(
            path: RouteNames.order.path,
            name: RouteNames.order.name,
            pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  child: const OrderView(),
                ),
            routes: [
              GoRoute(
                parentNavigatorKey: rootKey,
                path: RouteNames.orderDetails.path,
                name: RouteNames.orderDetails.name,
                pageBuilder: (context, state) => NoTransitionPage(
                  child: OrderDetailsView(state.pathParameters['id'] ?? ''),
                ),
              ),
            ]),

        //! Product section
        GoRoute(
          path: RouteNames.product.path,
          name: RouteNames.product.name,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: ProductView(),
          ),
          routes: [
            GoRoute(
              parentNavigatorKey: rootKey,
              path: RouteNames.productDetails.path,
              name: RouteNames.productDetails.name,
              onExit: (c, s) {
                DashInitPage.route = '';
                return true;
              },
              pageBuilder: (context, state) => NoTransitionPage(
                child: ProductDetailsView(state.pathParameters['id'] ?? ''),
              ),
            ),
            GoRoute(
              parentNavigatorKey: rootKey,
              path: RouteNames.addProduct.path,
              name: RouteNames.addProduct.name,
              pageBuilder: (context, state) {
                final extra = state.extra;
                if (extra is ProductModel?) {
                  return NoTransitionPage(
                    key: state.pageKey,
                    child: AddProductView(editingProduct: extra),
                  );
                }
                return NoTransitionPage(
                  key: state.pageKey,
                  child: const ErrorRoutePage(error: 'Invalid data'),
                );
              },
            ),
            GoRoute(
              parentNavigatorKey: rootKey,
              path: RouteNames.addDigitalProduct.path,
              name: RouteNames.addDigitalProduct.name,
              pageBuilder: (context, state) {
                final extra = state.extra;
                if (extra is ProductModel?) {
                  return NoTransitionPage(
                    key: state.pageKey,
                    child: AddDigitalProductView(extra),
                  );
                }
                return NoTransitionPage(
                  key: state.pageKey,
                  child: const ErrorRoutePage(error: 'Invalid data'),
                );
              },
            ),
          ],
        ),

        //! Massage section
        GoRoute(
          path: RouteNames.messages.path,
          name: RouteNames.messages.name,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: MessagesTabView(),
          ),
          routes: [
            GoRoute(
              parentNavigatorKey: rootKey,
              path: RouteNames.customerChats.path,
              name: RouteNames.customerChats.name,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: CustomerChatListView(),
              ),
              routes: [
                GoRoute(
                  parentNavigatorKey: rootKey,
                  path: RouteNames.customerChat.path,
                  name: RouteNames.customerChat.name,
                  onExit: (c, s) {
                    DashInitPage.route = '';
                    return true;
                  },
                  pageBuilder: (context, state) => NoTransitionPage(
                    child: CustomerChatView(id: state.pathParameters['id']!),
                  ),
                ),
              ],
            ),
            GoRoute(
              parentNavigatorKey: rootKey,
              path: RouteNames.tickets.path,
              name: RouteNames.tickets.name,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: TicketListView(),
              ),
              routes: [
                GoRoute(
                  parentNavigatorKey: rootKey,
                  path: RouteNames.ticket.path,
                  name: RouteNames.ticket.name,
                  pageBuilder: (context, state) => NoTransitionPage(
                    child: TicketView(state.pathParameters['id']!),
                  ),
                ),
                GoRoute(
                  parentNavigatorKey: rootKey,
                  path: RouteNames.createTicket.path,
                  name: RouteNames.createTicket.name,
                  pageBuilder: (context, state) => const NoTransitionPage(
                    child: CreateTicketView(),
                  ),
                ),
              ],
            ),
          ],
        ),
        //! Profile section
        GoRoute(
          path: RouteNames.profile.path,
          name: RouteNames.profile.name,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: ProfileView(),
          ),
          routes: [
            GoRoute(
              parentNavigatorKey: rootKey,
              path: RouteNames.accountSettings.path,
              name: RouteNames.accountSettings.name,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: SellerProfileView(),
              ),
            ),
            // GoRoute(
            //   parentNavigatorKey: rootKey,
            //   path: RouteNames.changeAccount.path,
            //   name: RouteNames.changeAccount.name,
            //   pageBuilder: (context, state) => const NoTransitionPage(
            //     child: ChangeAccountInformationView(),
            //   ),
            // ),
            GoRoute(
                parentNavigatorKey: rootKey,
                path: RouteNames.subscription.path,
                name: RouteNames.subscription.name,
                pageBuilder: (context, state) => const NoTransitionPage(
                      child: SubscriptionView(),
                    ),
                routes: [
                  GoRoute(
                    parentNavigatorKey: rootKey,
                    path: RouteNames.planUpdate.path,
                    name: RouteNames.planUpdate.name,
                    pageBuilder: (context, state) => const NoTransitionPage(
                      child: PlanUpdateView(),
                    ),
                  ),
                ]),
            GoRoute(
              parentNavigatorKey: rootKey,
              path: RouteNames.storeInformation.path,
              name: RouteNames.storeInformation.name,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: StoreInfoUpdateView(),
              ),
            ),
            GoRoute(
              parentNavigatorKey: rootKey,
              path: RouteNames.language.path,
              name: RouteNames.language.name,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: LanguageView(),
              ),
            ),
            GoRoute(
              parentNavigatorKey: rootKey,
              path: RouteNames.currency.path,
              name: RouteNames.currency.name,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: CurrencyView(),
              ),
            ),
          ],
        ),
      ],
    ),
  ];
  return routeList;
});

// Future<bool> showExitDialog(BuildContext context) async {
//   final result = await showDialog<bool>(
//     context: context,
//     builder: (BuildContext context) {
//       return const ExitDialog();
//     },
//   );

//   return result ?? false;
// }
