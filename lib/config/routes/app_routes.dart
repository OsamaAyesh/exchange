
import 'package:exchange/features/splash/presentation/pages/maintinance_screen.dart';

import '../../features/auth/presentation/pages/login_screen.dart';
import '../../features/home/bankTransfers/presentation/pages/add_transaction_new_screen.dart';
import '../../features/home/bankTransfers/presentation/pages/all_transactions_screen.dart';
import '../../features/home/bankTransfers/presentation/pages/update_transaction_bank.dart';
import '../../features/home/dailyBoxes/presentation/pages/box_screen.dart';
import '../../features/home/dailyBoxes/presentation/pages/boxes_daily.dart';
import '../../features/home/dailyBoxes/presentation/pages/details_box_screen.dart';
import '../../features/home/dailyBoxes/presentation/pages/update_process.dart';
import '../../features/home/home_screen.dart';
import '../../features/home/notifications/presentation/pages/notification_screen.dart';
import '../../features/home/profile/presentation/pages/profile_screen.dart';
import '../../features/home/profile/presentation/pages/update_data.dart';
import '../../features/home/profile/presentation/pages/update_password.dart';
import '../../features/home/summaryProcess/presentation/pages/summary_process.dart';
import '../../features/splash/presentation/pages/splash_screen.dart';

class Routes{

  //pages features - Splash
  static const String initialRoute="/splash_screen";

  //pages features - auth
  static const String loginScreen="/login_screen";

  //pages features - home
  static const String homeScreen="/home_screen";
  static const String notificationScreen="/notification_screen";
  static const String summaryProcess="/summary_process";
  static const String boxesDailyScreen="/boxes_daily";
  static const String boxScreen="/box_screen";
  // static const String detailsBoxScreen="/details_box";
  static const String detailsBoxScreen="/details_box_screen";
  static const String updateProcessScreen="/update_process";
  static const String profileScreen="/profile_screen";
  static const String updateDataScreen="/update_data";
  static const String updatePassword="/update_password";
  static const String addTransactionNewScreen="/add_transaction_new_screen";
  static const String allTransactionScreen="/all_transaction_new_screen";
  static const String updateTransactionScreen="/update_transaction-screen";
  static const String maintenanceScreen="/maintinance_screen";

}
final routes={
  //pages features - on boarding
  Routes.initialRoute:(context)=>const SplashScreen(),
  //Auth Routes
  Routes.loginScreen:(context)=>const LoginScreen(),
  //Home Routes
  Routes.homeScreen:(context)=>const HomeScreen(),
  Routes.notificationScreen:(context)=>const NotificationScreen(),
  Routes.summaryProcess:(context)=>const SummaryProcess(),
  Routes.boxesDailyScreen:(context)=>const BoxesDailyScreen(),
  Routes.boxScreen:(context)=> BoxScreen(idBox: 0,nameBox: "",),
  Routes.detailsBoxScreen:(context)=> DetailsBoxScreen(idBox: 1, nameBox: '',),
  Routes.updateProcessScreen:(context)=>UpdateProcess(numberProcess: '0923902', sourceId: 1, commission: '', amount: '', increaseAmount: '', total: '', notes: '', idBox: 1, serviceName: '', id: 0, typeName: '', typeId: 0, boxName: '', commissionid: 0,),
  Routes.profileScreen:(context)=>const ProfileScreen(),
  Routes.updateDataScreen:(context)=> const UpdateData(),
  Routes.updatePassword:(context)=>const UpdatePassword(),
  Routes.addTransactionNewScreen:(context)=>const AddTransactionNewScreen(),
  Routes.allTransactionScreen:(context)=> const AllTransactionsScreen(),
  Routes.updateTransactionScreen:(context)=> UpdateTransactionBank(refNumberController: '', accountIdController: 0, userIdController: 0, nameReceiveController: '', dateController: '', amountController: '', currencyController: '', notesController: "", imagePath: '', id: '',),
  Routes.maintenanceScreen:(context)=> MaintenanceScreen(),
};