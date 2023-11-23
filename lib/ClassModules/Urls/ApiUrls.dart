class ApiUrls {
  static String Pb_BaseAPIURL = "https://dowidar.tregix.com/api";
  static String userLogin = "/login?";
  static String getAllOrders = "/driver/orders?";
  static String orderDetails = "/order/get?";
  static String newOrders = "/driver/accept-reject-order";
  static String orderStatus = "/order/update-status";
  static String driverLocation = "/driver/update-driver-location";
  static String driverStatus = "/driver/update-status";
  static String chatmsg = Pb_BaseAPIURL + "/chat/send-message";
  static String updateDeviceToken = "/user/setDeviceToken";

  static String? Pb_Token;
}
