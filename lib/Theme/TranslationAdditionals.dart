import 'package:get/get.dart';

class TranslationAdditionals extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'login': 'Login',
        },
        'az_AZ': {
          'login': 'Daxil ol',
          'login_with_mobile_number': 'Mobil nömrə ilə daxil ol',
          'mobile_phone': 'Mobil nömrə',
          "sendcode": "Kod göndər"
        }
      };
}
