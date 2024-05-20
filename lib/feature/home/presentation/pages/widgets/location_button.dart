import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/config/icons/icons_broken.dart';
import 'package:weather/config/routes/app_routes.dart';
import 'package:weather/core/utils/app_colors.dart';
import 'package:weather/core/utils/get_current_location.dart';
import '../../../../../core/utils/constants.dart';

class LocationButton extends StatelessWidget {
  const LocationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: Constants.defaultPadding),
      child: GestureDetector(
        onTap: () async {
          if (determinePosition() != null) {
            final location = await determinePosition().then((location) {
              Navigator.pushNamed(context, Routes.detailsView,
                  arguments: ScreenArguments(
                    latitude: location.longitude.toString(),
                    longitude: location.longitude.toString(),
                  ));
            });
          } else {
            return Future.error('location not found');
          }
        },
        child: CircleAvatar(
          radius: 16.h,
          backgroundColor: AppColors.grey50,
          child: Icon(
            IconBroken.Location,
            color: AppColors.black,
            size: 28.sp,
          ),
        ),
      ),
    );
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // serviceEnabled = await Geolocator.isLocationServiceEnabled();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }
}
