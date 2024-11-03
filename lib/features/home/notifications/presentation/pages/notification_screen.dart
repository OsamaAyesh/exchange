// import 'package:exchange/core/utils/app_colors.dart';
// import 'package:exchange/core/utils/app_strings.dart';
// import 'package:exchange/core/utils/assets_manger.dart';
// import 'package:exchange/core/utils/screen_util_new.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import '../widgets/widget_notification.dart';
//
// class NotificationScreen extends StatelessWidget {
//   const NotificationScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         centerTitle: true,
//         automaticallyImplyLeading: false,
//         title: Text(
//           AppStrings.notificationScreen1,
//           style: GoogleFonts.cairo(
//             fontSize: 16.sp,
//             color: AppColors.primaryColor,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         actions: [
//           IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: const Icon(
//               Icons.arrow_forward,
//               color: AppColors.primaryColor,
//             ),
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//
//           SizedBox(
//             height: ScreenUtilNew.height(32),
//           ),
//           Center(
//             child: Image.asset(
//               AssetsManger.noNotificationImage,
//               height: ScreenUtilNew.height(316),
//               width: ScreenUtilNew.width(254),
//             ),
//           ),
//           Text(
//             AppStrings.notificationScreen2,
//             style: GoogleFonts.cairo(
//                 color: const Color(0XFF858585),
//                 fontWeight: FontWeight.w400,
//                 fontSize: 24.sp),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: 8,
//                 itemBuilder: (context, index) {
//               return const WidgetNotification();
//             }),
//           )
//         ],
//       ),
//     );
//   }
// }
// import 'package:exchange/features/home/notifications/domain/use_cases/get_notification_controller.dart';
// import 'package:exchange/features/home/notifications/presentation/widgets/widget_notification.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import '../../../../../core/utils/app_colors.dart';
// import '../../data/models/notfication_model.dart'; // تأكد من تعديل المسار حسب هيكل المشروع
//
// class NotificationScreen extends StatefulWidget {
//   const NotificationScreen({super.key});
//
//   @override
//   State<NotificationScreen> createState() => _NotificationScreenState();
// }
//
// class _NotificationScreenState extends State<NotificationScreen> {
//   final ScrollController scrollController = ScrollController();
//   List<NotificationModel> notifications = [];
//   int page = 1;
//   bool isLoading = false;
//   bool isLoadMore = false;
//   bool allDataLoaded = false;
//
//   @override
//   void initState() {
//     super.initState();
//     scrollController.addListener(_scrollListener);
//     _fetchData(page);
//   }
//
//   @override
//   void dispose() {
//     scrollController.dispose();
//     super.dispose();
//   }
//
//   Future<void> _scrollListener() async {
//     if (scrollController.position.pixels ==
//             scrollController.position.maxScrollExtent &&
//         !isLoadMore &&
//         !allDataLoaded) {
//       setState(() {
//         isLoadMore = true;
//       });
//       await _fetchData(page + 1);
//       setState(() {
//         isLoadMore = false;
//       });
//     }
//   }
//
//   Future<void> _fetchData(int pageNumber) async {
//     if (isLoading || allDataLoaded) return;
//
//     setState(() {
//       isLoading = true;
//     });
//
//     List<NotificationModel>? newItems =
//         await GetNotificationController().fetchNotifications(pageNumber);
//
//     if (newItems != null && newItems.isNotEmpty) {
//       setState(() {
//         page = pageNumber;
//         notifications.addAll(newItems);
//       });
//     } else {
//       setState(() {
//         allDataLoaded = true;
//       });
//     }
//
//     setState(() {
//       isLoading = false;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         automaticallyImplyLeading: false,
//         actions: [
//           IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: const Icon(
//               Icons.arrow_forward_ios,
//               color: AppColors.primaryColor,
//             ),
//           )
//         ],
//         centerTitle: true,
//         title: Text(
//           'الإشعارات',
//           style: GoogleFonts.cairo(
//             fontSize: 16.sp,
//             fontWeight: FontWeight.bold,
//             color: AppColors.primaryColor,
//           ),
//         ),
//       ),
//       body: Column(
//         children: [
//           SizedBox(height: ScreenUtil().setHeight(8)),
//           Expanded(
//             child: notifications.isEmpty && isLoading
//                 ? const Center(
//                     child: CircularProgressIndicator(
//                       color: AppColors.primaryColor,
//                       backgroundColor: AppColors.secondaryColor,
//                     ),
//                   )
//                 : ListView.builder(
//                     controller: scrollController,
//                     itemCount: notifications.length + (isLoadMore ? 1 : 0),
//                     itemBuilder: (context, index) {
//                       if (index < notifications.length) {
//                         return WidgetNotification(
//                             title: notifications[index].data!.title!,
//                             subTitle: notifications[index].data!.data!);
//                         Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 16.w),
//                           child: Card(
//                             elevation: 2,
//                             child: ListTile(
//                               title: Text(
//                                 notifications[index].data!.title!,
//                                 style: TextStyle(fontWeight: FontWeight.bold),
//                               ),
//                               subtitle: Text("notifications[index].message"!),
//                               trailing: Text("notifications[index].date"),
//                             ),
//                           ),
//                         );
//                       } else {
//                         return const SizedBox
//                             .shrink(); // لا تعرض شيئًا إذا لم يكن هناك تحميل
//                       }
//                     },
//                   ),
//           ),
//           if (isLoadMore) // Show CircularProgressIndicator when loading more data
//             Padding(
//               padding: EdgeInsets.symmetric(vertical: 16.h),
//               child: CircularProgressIndicator(
//                 color: AppColors.primaryColor,
//                 backgroundColor: AppColors.secondaryColor,
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
// import 'package:exchange/features/home/notifications/domain/use_cases/get_notification_controller.dart';
// import 'package:exchange/features/home/notifications/presentation/widgets/widget_notification.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import '../../../../../core/utils/app_colors.dart';
// import '../../../../../core/utils/app_strings.dart';
// import '../../../../../core/utils/assets_manger.dart';
// import '../../../../../core/utils/screen_util_new.dart';
// import '../../data/models/notfication_model.dart'; // تأكد من تعديل المسار حسب هيكل المشروع
//
// class NotificationScreen extends StatefulWidget {
//   const NotificationScreen({super.key});
//
//   @override
//   State<NotificationScreen> createState() => _NotificationScreenState();
// }
//
// class _NotificationScreenState extends State<NotificationScreen> {
//   final ScrollController scrollController = ScrollController();
//   List<NotificationModel> notifications = [];
//   int page = 1;
//   bool isLoading = false;
//   bool isLoadMore = false;
//   bool allDataLoaded = false;
//
//   @override
//   void initState() {
//     super.initState();
//     scrollController.addListener(_scrollListener);
//     _fetchData(page);
//   }
//
//   @override
//   void dispose() {
//     scrollController.dispose();
//     super.dispose();
//   }
//
//   Future<void> _scrollListener() async {
//     if (scrollController.position.pixels ==
//             scrollController.position.maxScrollExtent &&
//         !isLoadMore &&
//         !allDataLoaded) {
//       setState(() {
//         isLoadMore = true;
//       });
//       await _fetchData(page + 1);
//       setState(() {
//         isLoadMore = false;
//       });
//     }
//   }
//
//   Future<void> _fetchData(int pageNumber) async {
//     if (isLoading || allDataLoaded) return;
//
//     setState(() {
//       isLoading = true;
//     });
//
//     List<NotificationModel>? newItems =
//         await GetNotificationController().fetchNotifications(pageNumber);
//
//     if (newItems != null && newItems.isNotEmpty) {
//       setState(() {
//         page = pageNumber;
//         notifications.addAll(newItems);
//       });
//     } else {
//       setState(() {
//         allDataLoaded = true;
//       });
//     }
//
//     setState(() {
//       isLoading = false;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         automaticallyImplyLeading: false,
//         actions: [
//           IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: const Icon(
//               Icons.arrow_forward_ios,
//               color: AppColors.primaryColor,
//             ),
//           )
//         ],
//         centerTitle: true,
//         title: Text(
//           'الإشعارات',
//           style: GoogleFonts.cairo(
//             fontSize: 16.sp,
//             fontWeight: FontWeight.bold,
//             color: AppColors.primaryColor,
//           ),
//         ),
//       ),
//       body: Column(
//         children: [
//           SizedBox(height: ScreenUtil().setHeight(8)),
//           Expanded(
//             child: notifications.isEmpty && isLoading
//                 ? const Center(
//                     child: CircularProgressIndicator(
//                       color: AppColors.primaryColor,
//                       backgroundColor: AppColors.secondaryColor,
//                     ),
//                   )
//                 : notifications.isEmpty
//                     ? Column(
//                         children: [
//                           SizedBox(
//                             height: ScreenUtilNew.height(32),
//                           ),
//                           Center(
//                             child: Image.asset(
//                               AssetsManger.noNotificationImage,
//                               height: ScreenUtilNew.height(316),
//                               width: ScreenUtilNew.width(254),
//                             ),
//                           ),
//                           Text(
//                             AppStrings.notificationScreen2,
//                             style: GoogleFonts.cairo(
//                                 color: const Color(0XFF858585),
//                                 fontWeight: FontWeight.w400,
//                                 fontSize: 24.sp),
//                           ),
//                         ],
//                       )
//                     : ListView.builder(
//                         controller: scrollController,
//                         itemCount: notifications.length + (isLoadMore ? 1 : 0),
//                         itemBuilder: (context, index) {
//                           if (index < notifications.length) {
//                             return WidgetNotification(
//                               title: notifications[index].data!.title!,
//                               subTitle: notifications[index].data!.data!,
//                             );
//                           } else {
//                             return const SizedBox
//                                 .shrink(); // لا تعرض شيئًا إذا لم يكن هناك تحميل
//                           }
//                         },
//                       ),
//           ),
//           if (isLoadMore) // Show CircularProgressIndicator when loading more data
//             Padding(
//               padding: EdgeInsets.symmetric(vertical: 16.h),
//               child: CircularProgressIndicator(
//                 color: AppColors.primaryColor,
//                 backgroundColor: AppColors.secondaryColor,
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
import 'package:exchange/features/home/notifications/domain/use_cases/get_notification_controller.dart';
import 'package:exchange/features/home/notifications/presentation/widgets/widget_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../data/models/notfication_model.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final ScrollController scrollController = ScrollController();
  List<NotificationModel> notifications = [];
  Set<String> readNotificationIds = {}; // لتخزين المعرفات المقروءة
  int page = 1;
  bool isLoading = false;
  bool isLoadMore = false;
  bool allDataLoaded = false;



  Future<void> _scrollListener() async {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent &&
        !isLoadMore &&
        !allDataLoaded) {
      setState(() {
        isLoadMore = true;
      });
      await _fetchData(page + 1);
      setState(() {
        isLoadMore = false;
      });
    }
  }

  // Future<void> _fetchData(int pageNumber) async {
  //   if (isLoading || allDataLoaded) return;
  //
  //   setState(() {
  //     isLoading = true;
  //   });
  //
  //   List<NotificationModel>? newItems = await GetNotificationController().fetchNotifications(pageNumber);
  //
  //   if (newItems != null && newItems.isNotEmpty) {
  //     setState(() {
  //       page = pageNumber;
  //       notifications.addAll(newItems);
  //     });
  //   } else {
  //     setState(() {
  //       allDataLoaded = true;
  //     });
  //   }
  //
  //   setState(() {
  //     isLoading = false;
  //   });
  // }
  Future<void> _fetchData(int pageNumber) async {
    // هذا الشرط يمنع الجلب فقط إذا كانت كل البيانات محمّلة بالفعل
    if (allDataLoaded) return;

    // قم بتحديث حالة التحميل لعرض مؤشر التحميل بشكل صحيح
    setState(() {
      isLoading = true;
    });

    List<NotificationModel>? newItems = await GetNotificationController().fetchNotifications(pageNumber);

    if (newItems != null && newItems.isNotEmpty) {
      setState(() {
        notifications.addAll(newItems);
        page = pageNumber;
      });

      // التحقق من عدد العناصر على الصفحة الأولى فقط لضمان جلب الصفحة الثانية إذا كانت البيانات قليلة
      if (pageNumber == 1 && newItems.length < 15) {
        print("Fetching additional data for page 2 due to fewer items on page 1...");
        await _fetchData(2);
      }
    } else {
      setState(() {
        allDataLoaded = true;
      });
    }

    // بعد الانتهاء من الجلب، تأكد من إيقاف التحميل
    setState(() {
      isLoading = false;
    });
  }

  // Future<void> _fetchData(int pageNumber) async {
  //   // if (isLoading || allDataLoaded) return;
  //   setState(() {
  //     isLoading = true;
  //   });
  //
  //   List<NotificationModel>? newItems = await GetNotificationController().fetchNotifications(pageNumber);
  //   if (newItems != null && newItems.isNotEmpty) {
  //     setState(() {
  //       notifications.addAll(newItems);
  //       page = pageNumber;
  //       setState(() {
  //
  //       });
  //     });
  //
  //     if (pageNumber == 1 && newItems.length < 15) {
  //       print("less");
  //       await _fetchData(2);
  //       setState(() {
  //
  //       });
  //       print(page);
  //       print("less2");
  //     }
  //
  //   } else {
  //     setState(() {
  //       allDataLoaded = true;
  //     });
  //   }
  //
  //   setState(() {
  //     isLoading = false;
  //   });
  // }

  // Future<void> _fetchData(int pageNumber) async {
  //   if (isLoading || allDataLoaded) return;
  //
  //   setState(() {
  //     isLoading = true;
  //   });
  //
  //   List<NotificationModel>? newItems = await GetNotificationController().fetchNotifications(pageNumber);
  //
  //   if (newItems != null && newItems.isNotEmpty) {
  //     setState(() {
  //       page = pageNumber;
  //       notifications.addAll(newItems);
  //     });
  //     print(notifications.length);
  //     if(pageNumber==1){
  //       page=2;
  //       await _fetchData(page);
  //     }
  //     print(notifications.length);
  //
  //     // // تحقق مما إذا كانت الصفحة الأولى أقل من العدد المتوقع، وإذا كانت أقل اطلب الصفحة التالية مباشرة
  //     // if (pageNumber == 1 && newItems.length < 20) { // 20 هو العدد المتوقع من العناصر في كل صفحة
  //     // }
  //
  //   } else {
  //     setState(() {
  //       allDataLoaded = true;
  //     });
  //   }
  //
  //   setState(() {
  //     isLoading = false;
  //   });
  // }

  void _markNotificationAsRead(String notificationId) {
    if (!readNotificationIds.contains(notificationId)) {
      readNotificationIds.add(notificationId);
      GetNotificationController().markAsRead(notificationId); // تحديث حالة الإشعار
    }
  }
  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener);
    _fetchData(page);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_forward_ios,
              color: AppColors.primaryColor,
            ),
          ),
        ],
        centerTitle: true,
        title: Text(
          'الإشعارات',
          style: GoogleFonts.cairo(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: ScreenUtil().setHeight(8)),
          Expanded(
            child: notifications.isEmpty && isLoading
                ? const Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
                backgroundColor: AppColors.secondaryColor,
              ),
            )
                : ListView.builder(
              controller: scrollController,
              itemCount: notifications.length + (isLoadMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index < notifications.length) {
                  final notification = notifications[index];
                  // هنا يتم استدعاء دالة markAsRead عند عرض الإشعار
                  _markNotificationAsRead(notification.id!);
                  return WidgetNotification(
                    title: notification.data!.title!,
                    subTitle: notification.data!.data!,
                    read:notification.readAt ,
                  );
                } else {
                  return const SizedBox.shrink(); // لا تعرض شيئًا إذا لم يكن هناك تحميل
                }
              },
            ),
          ),
          if (isLoadMore) // Show CircularProgressIndicator when loading more data
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: const CircularProgressIndicator(
                color: AppColors.primaryColor,
                backgroundColor: AppColors.secondaryColor,
              ),
            ),
        ],
      ),
    );
  }
}
