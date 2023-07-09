import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yoldash/Constants/BaseAppBar.dart';
import 'package:yoldash/Controllers/HistoryController.dart';
import 'package:yoldash/Theme/ThemeService.dart';

class HistoryShow extends StatelessWidget {
  final HistoryController _controller = Get.find<HistoryController>();

  final index = int.parse(Get.parameters['index'] ?? '');
  GoogleMapController? _mapController;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: bodycolor,
      appBar: BaseAppBar(
        backbutton: true,
        title: "historydetail".tr,
        changeprof: false,
        titlebg: true,
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _controller.currentLocation ?? LatLng(0, 0),
              zoom: 15,
            ),
            onMapCreated: (GoogleMapController controller) {
              _mapController = controller;
            },
          ),
          Positioned(
            top: 20,
            right: 20,
            child: FloatingActionButton(
              onPressed: () {
                if (_mapController != null &&
                    _controller.currentLocation != null) {
                  _mapController!.animateCamera(
                    CameraUpdate.newLatLng(_controller.currentLocation!),
                  );
                }
              },
              child: Icon(Icons.my_location),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: Container(
              width: 200,
              height: 100,
              color: Colors.white,
              child: Center(
                child: Text('Özelleştirilebilir Widgetler'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
