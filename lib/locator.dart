import 'package:get_it/get_it.dart';
import 'package:seller_management/features/add_product/repository/add_product_repo.dart';
import 'package:seller_management/features/auth/repository/auth_repo.dart';
import 'package:seller_management/features/campaign/repository/campaign_repo.dart';
import 'package:seller_management/features/chat/repository/chat_repo.dart';
import 'package:seller_management/features/dashboard/repository/dash_repo.dart';
import 'package:seller_management/features/deposit/repository/deposit_repo.dart';
import 'package:seller_management/features/kyc/repository/kyc_repo.dart';
import 'package:seller_management/features/order/repository/order_repo.dart';
import 'package:seller_management/features/product/repository/product_repo.dart';
import 'package:seller_management/features/region/repository/region_repo.dart';
import 'package:seller_management/features/seller_info/repository/seller_info_repo.dart';
import 'package:seller_management/features/settings/repository/settings_repo.dart';
import 'package:seller_management/features/subscription/repository/subscription_repo.dart';
import 'package:seller_management/features/support_ticket/repository/ticket_repository.dart';
import 'package:seller_management/features/total_balance/repository/total_balance_repo.dart';
import 'package:seller_management/features/withdraw/repository/withdraw_repo.dart';
import 'package:seller_management/main.export.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locate = GetIt.instance;

configureDependencies() async {
  final pref = await SharedPreferences.getInstance();

  locate.registerSingleton<SharedPreferences>(pref);
  locate.registerSingleton<EventStreamer>(EventStreamer());

  locate.registerSingleton<LocalDB>(LocalDB());
  locate.registerSingleton<FilePickerRepo>(FilePickerRepo());
  locate.registerSingleton<DioClient>(DioClient());
  locate.registerSingleton<RemoteDB>(RemoteDB());
  locate.registerSingleton<RegionRepo>(RegionRepo());
  locate.registerSingleton<AuthRepo>(AuthRepo());
  locate.registerSingleton<DashboardRepo>(DashboardRepo());
  locate.registerSingleton<OrderRepository>(OrderRepository());
  locate.registerSingleton<SettingsRepo>(SettingsRepo());
  locate.registerSingleton<SellerRepo>(SellerRepo());
  locate.registerSingleton<AddProductRepo>(AddProductRepo());
  locate.registerSingleton<ChatRepo>(ChatRepo());
  locate.registerSingleton<TicketRepo>(TicketRepo());
  locate.registerSingleton<ProductRepo>(ProductRepo());
  locate.registerSingleton<TransactionRepo>(TransactionRepo());
  locate.registerSingleton<SubscriptionRepo>(SubscriptionRepo());
  locate.registerSingleton<CampaignRepo>(CampaignRepo());
  locate.registerSingleton<WithdrawRepo>(WithdrawRepo());

  locate.registerSingleton<PDFCtrl>(PDFCtrl());
  locate.registerSingleton<KycRepo>(KycRepo());
  locate.registerSingleton<DepositRepo>(DepositRepo());
}
