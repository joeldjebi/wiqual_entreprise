// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:share_plus/share_plus.dart';

import '../../core/constantes/assets_color.dart';
import '../../main.dart';
import '../../widet/top_menu.dart';
import '../map/index.dart';
import '../point_de_vente/point_de_vente_controller.dart';
import '../point_de_vente/store_point_de_vente.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  PointDeVenteController pointDeVenteController =
      Get.put(PointDeVenteController());

  final double latitude = 37.7749;
  final double longitude = -122.4194;

  bool isRefreshing = false;

  Position? currentPosition;

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    pointDeVenteController.fetchDataPointDeVente();
  }

  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Le service de localisation n'est pas activé, afficher un message ou demander à l'utilisateur de l'activer
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        // L'utilisateur n'a pas autorisé l'accès à la localisation, afficher un message ou prendre une action appropriée
        return;
      }
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      currentPosition = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Color(0xfff7f7f8),
        body: Column(
          children: [
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                TopMenu().build(context),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Bienvenue sur CODICERT',
                      style: myTextStyle.copyWith(
                        fontSize: 20,
                        color: AppColors.textColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Text(
                      'Votre application de localisation',
                      style: myTextStyle.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Color(0xff000000),
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                // SizedBox(
                //   height: MediaQuery.of(context).size.height * 0.02,
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     Container(
                //       width: MediaQuery.of(context).size.width * 0.3,
                //       decoration: BoxDecoration(
                //         color: AppColors.primaryBackground,
                //         border: Border.all(
                //           color: AppColors.primaryBackground,
                //           style: BorderStyle.solid,
                //           width: 1.0,
                //         ),
                //         borderRadius: BorderRadius.circular(5.0),
                //       ),
                //       child: Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: Column(
                //           children: [
                //             SizedBox(
                //               height: MediaQuery.of(context).size.height * 0.01,
                //             ),
                //             Text(
                //               "Aujourd'hui",
                //               style: myTextStyle.copyWith(
                //                 fontWeight: FontWeight.bold,
                //                 color: AppColors.secondBackground,
                //                 fontSize:
                //                     MediaQuery.of(context).size.width * 0.035,
                //               ),
                //             ),
                //             SizedBox(
                //               height: MediaQuery.of(context).size.height * 0.06,
                //             ),
                //             Text(
                //               "12",
                //               style: myTextStyle.copyWith(
                //                 fontWeight: FontWeight.bold,
                //                 color: AppColors.secondBackground,
                //                 fontSize: 20,
                //               ),
                //             ),
                //             SizedBox(
                //               height: MediaQuery.of(context).size.height * 0.01,
                //             ),
                //           ],
                //         ),
                //       ),
                //     ),
                //     Container(
                //       width: MediaQuery.of(context).size.width * 0.3,
                //       decoration: BoxDecoration(
                //         color: Color(0xFFF05A22),
                //         border: Border.all(
                //           color: Color(0xFFF05A22),
                //           style: BorderStyle.solid,
                //           width: 1.0,
                //         ),
                //         borderRadius: BorderRadius.circular(5.0),
                //       ),
                //       child: Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: Column(
                //           children: [
                //             SizedBox(
                //               height: MediaQuery.of(context).size.height * 0.01,
                //             ),
                //             Text(
                //               "Ce mois",
                //               style: myTextStyle.copyWith(
                //                 fontWeight: FontWeight.bold,
                //                 color: AppColors.secondBackground,
                //                 fontSize:
                //                     MediaQuery.of(context).size.width * 0.035,
                //               ),
                //             ),
                //             SizedBox(
                //               height: MediaQuery.of(context).size.height * 0.06,
                //             ),
                //             Text(
                //               "12",
                //               style: myTextStyle.copyWith(
                //                 fontWeight: FontWeight.bold,
                //                 color: AppColors.secondBackground,
                //                 fontSize: 20,
                //               ),
                //             ),
                //             SizedBox(
                //               height: MediaQuery.of(context).size.height * 0.01,
                //             ),
                //           ],
                //         ),
                //       ),
                //     ),
                //     Container(
                //       width: MediaQuery.of(context).size.width * 0.3,
                //       decoration: BoxDecoration(
                //         border: Border.all(
                //           color: AppColors.secondBackgroundActive,
                //           style: BorderStyle.solid,
                //           width: 1.0,
                //         ),
                //         color: AppColors.secondBackgroundActive,
                //         borderRadius: BorderRadius.circular(5.0),
                //       ),
                //       child: Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: Column(
                //           children: [
                //             SizedBox(
                //               height: MediaQuery.of(context).size.height * 0.01,
                //             ),
                //             Text(
                //               "Cette année",
                //               style: myTextStyle.copyWith(
                //                 fontWeight: FontWeight.bold,
                //                 color: AppColors.secondBackground,
                //                 fontSize:
                //                     MediaQuery.of(context).size.width * 0.035,
                //               ),
                //             ),
                //             SizedBox(
                //               height: MediaQuery.of(context).size.height * 0.06,
                //             ),
                //             Text(
                //               "12",
                //               style: myTextStyle.copyWith(
                //                 fontWeight: FontWeight.bold,
                //                 color: AppColors.secondBackground,
                //                 fontSize: 20,
                //               ),
                //             ),
                //             SizedBox(
                //               height: MediaQuery.of(context).size.height * 0.01,
                //             ),
                //           ],
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  // Définissez l'état de rafraîchissement comme actif
                  setState(() {
                    isRefreshing = true;
                  });

                  // Placez ici le code pour rafraîchir vos données
                  await pointDeVenteController.fetchDataPointDeVente();

                  // Terminez le rafraîchissement
                  setState(() {
                    isRefreshing = false;
                  });
                },
                child: FutureBuilder(
                  future: pointDeVenteController.fetchDataPointDeVente(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: Container(
                          height: 50,
                          child: Center(
                            child: LoadingAnimationWidget.discreteCircle(
                              color: AppColors.primaryBackground,
                              size: 20,
                              secondRingColor: AppColors.primaryBackground,
                              thirdRingColor: AppColors.secondBackground,
                            ),
                          ),
                        ),
                      );
                    }
                    if (snapshot.hasData) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ListView.builder(
                          itemCount: pointDeVenteController
                              .dataListPointDeVente.length,
                          itemBuilder: (context, index) {
                            final data = pointDeVenteController
                                .dataListPointDeVente[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColors.bgColorShimmer,
                                    style: BorderStyle.solid,
                                    width: 1.0,
                                  ),
                                  color: AppColors.bgColorShimmer,
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, bottom: 8),
                                  child: ListTile(
                                    leading: data['photo'] != null
                                        ? CircleAvatar(
                                            radius: 30.0,
                                            backgroundImage: NetworkImage(
                                                'https://mobile-app.wiqual.org/' +
                                                    data['photo'].toString()),
                                            backgroundColor: Colors.transparent,
                                          )
                                        : CircleAvatar(
                                            radius: 30.0,
                                            backgroundImage: AssetImage(
                                              'assets/images/icon.png',
                                            ),
                                            backgroundColor: Colors.transparent,
                                          ),
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data['name'],
                                          style: myTextStyle.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xff000000),
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.04,
                                          ),
                                        ),
                                        // Text(
                                        //   data.title.length >= 18
                                        //       ? data.title.substring(0, 18)
                                        //       : data.title,
                                        //   style: myTextStyle.copyWith(
                                        //     fontWeight: FontWeight.bold,
                                        //     color: Color(0xff000000),
                                        //     fontSize: 14,
                                        //   ),
                                        // ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.01,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              data['town'] + ', ',
                                              style: myTextStyle.copyWith(
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xff000000),
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.03,
                                              ),
                                            ),
                                            Text(
                                              data['address'],
                                              style: myTextStyle.copyWith(
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xff000000),
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.03,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.001,
                                        ),
                                        Text(
                                          data['created_at'],
                                          style: myTextStyle.copyWith(
                                            color: AppColors.textColor,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.025,
                                          ),
                                        ),
                                      ],
                                    ),
                                    trailing: IconButton(
                                      onPressed: () {
                                        if (currentPosition != null) {
                                          Get.to(
                                            MapScreen(
                                              latitude:
                                                  double.parse(data['lat']),
                                              longitude:
                                                  double.parse(data['long']),
                                            ),
                                            // MapScreen(
                                            //   latitude: currentPosition!.latitude,
                                            //   longitude: currentPosition!.longitude,
                                            // ),
                                          );
                                        }
                                      },
                                      icon: Icon(
                                        Icons.location_on,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return Center(
                        child: Text('Aucun enregistrement...'),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(StorePointDeVentePage());
          },
          backgroundColor: AppColors.primaryBackground,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
