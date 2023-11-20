import 'package:dowidardriver/ClassModules/cm_StringConstants/cm_StringConstantsVwHome.dart';
import 'package:get/get_navigation/src/root/internacionalization.dart';

import '../cm_StringConstants/cm_StringConstantsVwCommomLayout.dart';
import '../cm_StringConstants/cm_StringConstantsVwLogin.dart';
import '../cm_StringConstants/cm_StringConstantsVwOrderDetails.dart';
import '../cm_StringConstants/cm_StringConstantsVwProfile.dart';
import '../cm_StringConstants/cm_StringConstantsVwSettings.dart';

class cm_LanguageController extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          // Home Screen
          // 'hi': 'hi',

          "${cm_StringConstantsVwHome.strHome}": 'Home',
          "${cm_StringConstantsVwHome.strCurrentOrders}": 'Current Orders',
          "${cm_StringConstantsVwHome.strNewOrders}": 'New Orders',
          "${cm_StringConstantsVwHome.strStatus}": 'Status',
          "${cm_StringConstantsVwHome.strSwitchon}": 'Switch on',
          "${cm_StringConstantsVwHome.strAlert}": 'Alert',
          "${cm_StringConstantsVwHome.strLocationLive}": 'Location Live',
          "${cm_StringConstantsVwHome.strError}": 'Error',
          "${cm_StringConstantsVwHome.strLocationoff}": 'Location Off',
          "${cm_StringConstantsVwHome.strError}": 'Error',
          "${cm_StringConstantsVwHome.strRedCancelled}": 'Red = Cancelled',
          "${cm_StringConstantsVwHome.strBlueProcessing}": 'Blue = Processing',
          "${cm_StringConstantsVwHome.strGreenPending}": 'Green = Enroute',
          "${cm_StringConstantsVwHome.strYoudont_haveanyorders}":
              cm_StringConstantsVwHome.strYoudont_haveanyorders ?? 'You don\'t have any orders',
          "${cm_StringConstantsVwHome.strOrderNO}": 'Order NO',
          "${cm_StringConstantsVwHome.strResturent}": 'Restaurant',
          "${cm_StringConstantsVwHome.CreatedAt}": 'Created At',
          "${cm_StringConstantsVwHome.strAddress}": 'Address',
          "${cm_StringConstantsVwHome.strOrderAccepted}": 'Accept',
          "${cm_StringConstantsVwHome.strOrderRejected}": 'Reject',
          "${cm_StringConstantsVwHome.strYellowWaiting}": 'Yellow = waiting',
          "${cm_StringConstantsVwHome.strPurpleAccepted}": 'Purple = accepted',
          "${cm_StringConstantsVwHome.strYoudont_haveOrderhistory}": 'You don\'t have orders history',

          "${cm_StringConstantsVwHome.strYoudont_haveNoneworders}":
              cm_StringConstantsVwHome.strYoudont_haveNoneworders ?? 'You don\'t have any new orders',
          // Vw Common layout
          "${cm_StringConstantsVwCommomLayout.strHome}": 'Home',
          "${cm_StringConstantsVwCommomLayout.strOrdersHistory}": 'Orders History',
          "${cm_StringConstantsVwCommomLayout.strProfile}": 'Profile',
          "${cm_StringConstantsVwCommomLayout.strSettings}": 'Settings',
          "${cm_StringConstantsVwCommomLayout.strAlert}": 'Alert',
          //VwProfile
          "${cm_StringConstantsVwProfile.strMyPrsofile}": 'My Profile',
          "${cm_StringConstantsVwProfile.strTitle}": 'Title',
          "${cm_StringConstantsVwProfile.strStatus}": 'Status',
          "${cm_StringConstantsVwProfile.strPhoneNumber}": 'Phone Number',

          //VwOrderDetails
          "${cm_StringConstantsVwOrderDetails.strOrderDetails}": 'Order Details',
          "${cm_StringConstantsVwOrderDetails.strRestaurantInfo}": 'Restaurant Info',
          "${cm_StringConstantsVwOrderDetails.strRestaurantName}": 'Restaurant Name:',
          "${cm_StringConstantsVwOrderDetails.strLocation}": 'Location',
          "${cm_StringConstantsVwOrderDetails.strPhone}": 'Phone',
          "${cm_StringConstantsVwOrderDetails.strClientInfo}": 'Client Info',
          "${cm_StringConstantsVwOrderDetails.strClientName}": 'Client Name:',
          "${cm_StringConstantsVwOrderDetails.strClientEmail}": 'Client Email:',
          "${cm_StringConstantsVwOrderDetails.strClientAddress}": 'Client Address:',
          "${cm_StringConstantsVwOrderDetails.strClientLocation}": 'Location',
          "${cm_StringConstantsVwOrderDetails.strClientPhone}": 'Phone',
          "${cm_StringConstantsVwOrderDetails.strOrderInfo}": 'Order Info',
          "${cm_StringConstantsVwOrderDetails.strOrderNumber}": 'Order Number:',
          "${cm_StringConstantsVwOrderDetails.strOrderStatus}": 'Order Status:',
          "${cm_StringConstantsVwOrderDetails.strOrderCreatedAt}": 'Order Created At:',
          "${cm_StringConstantsVwOrderDetails.strPaymentType}": 'Payment Type:',
          "${cm_StringConstantsVwOrderDetails.strItems}": 'Items',
          "${cm_StringConstantsVwOrderDetails.strItemName}": 'Item Name',
          "${cm_StringConstantsVwOrderDetails.strResturent}": 'Restaurant:',
          "${cm_StringConstantsVwOrderDetails.strDelivered}": 'Delivered:',
          "${cm_StringConstantsVwOrderDetails.strYourOrderDeliverd}": 'Already Delivered',
          "${cm_StringConstantsVwOrderDetails.strItemQty}": 'Item Qty:',
          "${cm_StringConstantsVwOrderDetails.strItemPrice}": 'Item Name',
          "${cm_StringConstantsVwOrderDetails.strTotal}": 'Total:',


          //Vw Settings
          "${cm_StringConstantsVwSettings.strSettings}": 'Settings',
          "${cm_StringConstantsVwSettings.strLogout}": 'Logout',
          "${cm_StringConstantsVwSettings.strChangeLanguage}": 'Change Language',
          //VwLogin
          "${cm_StringConstantsVwLogin.strEnterCred}": 'Enter credentials for login',
          "${cm_StringConstantsVwLogin.strLogin}": 'Login',
          "${cm_StringConstantsVwLogin.strPassword}": 'Password',
          "${cm_StringConstantsVwLogin.strPhoneNumber}": 'PhoneNumber',




        },
        'ar_SA': {
          // Home Screen
          //'hi': 'الصفحة',
          "${cm_StringConstantsVwHome.strHome}": 'الصفحة الرئيسية',
          "${cm_StringConstantsVwHome.strCurrentOrders}": 'الطلبات الحالية',
          "${cm_StringConstantsVwHome.strNewOrders}": 'طلبات جديدة',
          "${cm_StringConstantsVwHome.strStatus}": 'الحالة',
          "${cm_StringConstantsVwHome.strSwitchon}": 'تشغيل',
          "${cm_StringConstantsVwHome.strAlert}": 'تنبيه',
          "${cm_StringConstantsVwHome.strLocationLive}": 'الموقع المباشر',
          "${cm_StringConstantsVwHome.strError}": 'خطأ',
          "${cm_StringConstantsVwHome.strLocationoff}": 'إيقاف الموقع',
          "${cm_StringConstantsVwHome.strError}": 'خطأ',
          "${cm_StringConstantsVwHome.strRedCancelled}": 'أحمر = تم الإلغاء',
          "${cm_StringConstantsVwHome.strBlueProcessing}": 'أزرق = قيد المعالجة',
          "${cm_StringConstantsVwHome.strGreenPending}": 'أخضر = قيد الانتظار',
          "${cm_StringConstantsVwHome.strYoudont_haveanyorders}":
              cm_StringConstantsVwHome.strYoudont_haveanyorders ?? 'ليس لديك أي طلبات',
          "${cm_StringConstantsVwHome.strOrderNO}": 'رقم الطلب',
          "${cm_StringConstantsVwHome.strResturent}": 'المطعم',
          "${cm_StringConstantsVwHome.CreatedAt}": 'تم الإنشاء في',
          "${cm_StringConstantsVwHome.strAddress}": 'عنوان',
          "${cm_StringConstantsVwHome.strOrderAccepted}": 'يقبل',
          "${cm_StringConstantsVwHome.strOrderRejected}": 'يرفض',
          "${cm_StringConstantsVwHome.strYellowWaiting}": 'الأصفر = الانتظار',
          "${cm_StringConstantsVwHome.strPurpleAccepted}": 'الأرجواني = مقبول',
          "${cm_StringConstantsVwHome.strYoudont_haveNoneworders}": 'ليس لديك أي طلبات جديدة',
          "${cm_StringConstantsVwHome.strYoudont_haveOrderhistory}": "ليس لديك تاريخ طلبات.",

          //VwCommonLayout

          "${cm_StringConstantsVwCommomLayout.strHome}": 'الصفحة الرئيسية',
          "${cm_StringConstantsVwCommomLayout.strOrdersHistory}": 'تاريخ الطلبات',
          "${cm_StringConstantsVwCommomLayout.strProfile}": 'الملف الشخصي',
          "${cm_StringConstantsVwCommomLayout.strSettings}": 'الإعدادات',
          "${cm_StringConstantsVwCommomLayout.strAlert}": 'تنبيه',

          //VwProfile
          "${cm_StringConstantsVwProfile.strMyPrsofile}": 'ملفي الشخصي',
          "${cm_StringConstantsVwProfile.strTitle}": 'العنوان',
          "${cm_StringConstantsVwProfile.strStatus}": 'الحالة',
          "${cm_StringConstantsVwProfile.strPhoneNumber}": 'رقم الهاتف',

          //VwOrderDetails
          "${cm_StringConstantsVwOrderDetails.strOrderDetails}": 'تفاصيل الطلب',
          "${cm_StringConstantsVwOrderDetails.strRestaurantInfo}": 'معلومات المطعم',
          "${cm_StringConstantsVwOrderDetails.strRestaurantName}": 'اسم المطعم:',
          "${cm_StringConstantsVwOrderDetails.strLocation}": 'الموقع',
          "${cm_StringConstantsVwOrderDetails.strPhone}": 'الهاتف',
          "${cm_StringConstantsVwOrderDetails.strClientInfo}": 'معلومات العميل',
          "${cm_StringConstantsVwOrderDetails.strClientName}": 'اسم العميل:',
          "${cm_StringConstantsVwOrderDetails.strClientEmail}": 'بريد العميل الإلكتروني:',
          "${cm_StringConstantsVwOrderDetails.strClientAddress}": 'عنوان العميل:',
          "${cm_StringConstantsVwOrderDetails.strClientLocation}": 'الموقع',
          "${cm_StringConstantsVwOrderDetails.strClientPhone}": 'الهاتف',
          "${cm_StringConstantsVwOrderDetails.strOrderInfo}": 'معلومات الطلب',
          "${cm_StringConstantsVwOrderDetails.strOrderNumber}": 'رقم الطلب:',
          "${cm_StringConstantsVwOrderDetails.strOrderStatus}": 'حالة الطلب:',
          "${cm_StringConstantsVwOrderDetails.strOrderCreatedAt}": 'تاريخ إنشاء الطلب:',
          "${cm_StringConstantsVwOrderDetails.strPaymentType}": 'طريقة الدفع:',
          "${cm_StringConstantsVwOrderDetails.strItems}": 'العناصر',
          "${cm_StringConstantsVwOrderDetails.strItemName}": 'اسم العنصر',
          "${cm_StringConstantsVwOrderDetails.strResturent}": 'المطعم:',
          "${cm_StringConstantsVwOrderDetails.strDelivered}": 'تم التوصيل:',
          "${cm_StringConstantsVwOrderDetails.strYourOrderDeliverd}": 'تم التوصيل:',
          "${cm_StringConstantsVwOrderDetails.strItemQty}": 'البند الكمية:',
          "${cm_StringConstantsVwOrderDetails.strItemPrice}": 'معدل البند:',
          "${cm_StringConstantsVwOrderDetails.strTotal}": 'المجموع:',

          //VwSettings

          "${cm_StringConstantsVwSettings.strSettings}": 'الإعدادات',
          "${cm_StringConstantsVwSettings.strLogout}": 'تسجيل الخروج',
          "${cm_StringConstantsVwSettings.strChangeLanguage}": 'تغيير اللغة',

          //VwLogin
          "${cm_StringConstantsVwLogin.strEnterCred}": 'أدخل بيانات الاعتماد لتسجيل الدخول',
          "${cm_StringConstantsVwLogin.strLogin}": 'تسجيل الدخول',
          "${cm_StringConstantsVwLogin.strPassword}": 'كلمة المرور',
          "${cm_StringConstantsVwLogin.strPhoneNumber}": 'رقم الهاتف',


        },
      };
}
