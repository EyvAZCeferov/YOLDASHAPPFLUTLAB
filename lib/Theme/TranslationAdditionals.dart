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
          'mobile_phone': 'Telefon nömrəsi',
          "sendcode": "Kod göndər",
          "doesnothaveaccount": "Hesabınız yoxdur?",
          "doeshaveaccount": "Hesabınız var?",
          "register": "Qeydiyyatdan keç",
          "name_surname": "Ad soyad",
          "gender": "Cins",
          "gender_male": "Kişi",
          "gender_female": "Qadın",
          "birthday": "Doğum tarixi",
          "email": "Email",
          "back": "Geri",
          "enter_verification_code": "Doğrulama kodunu daxil edin",
          "sendedcodephone": "@phoneNumber nömrəsinə kod göndərildi",
          "dontgetcode": "Kod almırsınız?",
          "resend": "Yenidən göndər",
          "submit": "Təsdiqlə"
        }
      };
}
