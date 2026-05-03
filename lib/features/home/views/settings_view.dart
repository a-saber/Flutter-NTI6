import 'package:flutter/material.dart';
import 'package:flutter_nti6/core/cache/cache_helper.dart';
import 'package:flutter_nti6/core/cache/cache_keys.dart';
import 'package:get/get.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('settings'.tr),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () async {
                await Get.updateLocale(Locale('ar'));
                await CacheHelper.setValue(key: CacheKeys.lang, value: 'ar');

                },
              child: Text('To Arabic')),
          ElevatedButton(
              onPressed: () async{
                await Get.updateLocale(Locale('en'));
                await CacheHelper.setValue(key: CacheKeys.lang, value: 'en');
              },
              child: Text('To English')),
          ElevatedButton(
              onPressed: ()async {
                await Get.updateLocale(Locale('fr'));
                await CacheHelper.setValue(key: CacheKeys.lang, value: 'fr');
              },
              child: Text('To French')),
        ],
      ),
    );
  }
}
