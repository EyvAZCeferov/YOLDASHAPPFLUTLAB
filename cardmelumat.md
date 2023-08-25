card melumatlari tesdiqi - aktivlesdir +-
masini qebul olmayanda serh yazilsin ki bu senedler sehvdir 

gedis ve logistikada sorussun yuk nedir yazi olsun cekiniz 
surucu ucun cixart yuk
tipin yerini sece bilsin (yer funksiyasi tip de olsun)
surucu yer isarelesin ve qadin kisi olmasini secsin ve nomresini yazsin 
1 den cox yeri hem surucu hem de sernisin vura bilecek
gedis sirasinda gormuyecek basqasinin gedisini
gedisiniz legv olundu eyni istiqamet uzre basqa sifarislere baxin
profil de bizimle elaqe chat hissesi olsun ve zeng olsun mail de olsun
teklif ve sikayet olsun (sifaris bolmesinde) tarixce
tipi tir secende onda hecmini (ton olaraq)
sifarisci cekini yazmaya da biler
xerite de secim qoy waze ve google maps



Devider(),
                                  _authcontroller.authType == "driver"
                                      ? SizedBox()
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            GestureDetector(
                                              onTap: () =>
                                                  _controller.selectplace(1),
                                              child: Container(
                                                width: 110,
                                                height: 35,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: primarycolor,
                                                        style:
                                                            BorderStyle.solid,
                                                        width: 1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            35),
                                                    color: _controller
                                                                    .selectedplace
                                                                    .value !=
                                                                null &&
                                                            _controller
                                                                    .selectedplace
                                                                    .value ==
                                                                1
                                                        ? primarycolor
                                                        : whitecolor),
                                                child: StaticText(
                                                    color: _controller
                                                                    .selectedplace
                                                                    .value !=
                                                                null &&
                                                            _controller
                                                                    .selectedplace
                                                                    .value ==
                                                                1
                                                        ? whitecolor
                                                        : darkcolor,
                                                    size: normaltextSize,
                                                    weight: FontWeight.w500,
                                                    align: TextAlign.center,
                                                    text: "choiseplace".tr),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () =>
                                                  _controller.selectplace(2),
                                              child: Container(
                                                width: 150,
                                                height: 35,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: primarycolor,
                                                        style:
                                                            BorderStyle.solid,
                                                        width: 1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            35),
                                                    color: _controller
                                                                    .selectedplace
                                                                    .value !=
                                                                null &&
                                                            _controller
                                                                    .selectedplace
                                                                    .value ==
                                                                2
                                                        ? primarycolor
                                                        : whitecolor),
                                                child: StaticText(
                                                    color: _controller
                                                                    .selectedplace
                                                                    .value !=
                                                                null &&
                                                            _controller
                                                                    .selectedplace
                                                                    .value ==
                                                                2
                                                        ? whitecolor
                                                        : darkcolor,
                                                    size: normaltextSize,
                                                    weight: FontWeight.w500,
                                                    align: TextAlign.center,
                                                    text: "fullreservation".tr),
                                              ),
                                            ),
                                          ],
                                        ),

