import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:trello/models/model.dart';
import 'package:trello/utils/logger.dart';

class UtilDevice {
  static Future<DeviceModel?> loadDevice() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    DeviceModel? device;
    try {
      if (Platform.isAndroid) {
        final android = await deviceInfoPlugin.androidInfo;
        device = DeviceModel(
          uuid: android.androidId,
          model: "Android",
          version: android.version.sdkInt.toString(),
          type: android.model,
        );
      } else if (Platform.isIOS) {
        final IosDeviceInfo ios = await deviceInfoPlugin.iosInfo;
        device = DeviceModel(
          uuid: ios.identifierForVendor,
          name: ios.name,
          model: ios.systemName,
          version: ios.systemVersion,
          type: ios.utsname.machine,
        );
      }
    } catch (e) {
      UtilLogger.log("ERROR", e);
    }
    return device;
  }

  static Future<String?> getDeviceToken() async {
    try {
      return null;
    } catch (error) {
      UtilLogger.log("ERROR", error);
    }
  }

  ///Singleton factory
  static final _instance = UtilDevice._internal();

  factory UtilDevice() {
    return _instance;
  }

  UtilDevice._internal();
}
