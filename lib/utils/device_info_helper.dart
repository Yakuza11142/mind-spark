class DeviceInfoHelper {
  static bool isMobileDataActive = true;
  
  static void updateConnectionStatus(bool status) {
    isMobileDataActive = status;
  }
}
