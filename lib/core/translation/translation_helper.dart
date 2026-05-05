import 'package:get/get.dart';

import 'ar.dart';
import 'en.dart';
import 'fr.dart';
import 'translation_keys.dart';

class TranslationHelper extends Translations{
  @override
  Map<String, Map<String, String>> get keys => {
    'en': en,
    'ar': ar,
    'fr': fr
  };

}