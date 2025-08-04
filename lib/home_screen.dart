import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_mlkit_app/camera_ocr_screen.dart';
import 'package:flutter_test_mlkit_app/camera_liveness_autentika_screen.dart';
import 'package:flutter_test_mlkit_app/camera_liveness_screen.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:mnc_identifier_ocr/mnc_identifier_ocr.dart';
// import 'package:mnc_identifier_ocr/model/ocr_result_model.dart';
import 'package:saas_mlkit/src/features/rnd/saas_ocr_camera_mlkit_ver.dart';
import 'package:saas_mlkit/src/features/rnd/saas_ocr_camera_rnd1.dart';
import 'package:saas_mlkit/src/features/rnd/saas_ocr_camera_rnd2.dart';
import 'package:saas_mlkit/src/features/rnd/ocr/ktp_scanner_widget.dart';
import 'package:saas_mlkit/src/features/rnd/ocr/simple_ktp_scanner_widget.dart';

class HomeScreen extends StatefulWidget {
  final int motionCount;
  final Function(String)? onSuccess;
  final Function(String)? onFailed;

  const HomeScreen({super.key, required this.motionCount, this.onSuccess, this.onFailed});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CameraController? cameraController;
  bool faceFound = false;
  List<List<dynamic>>? selectedMotion;
  int motionProgress = 0;

  String? dataOcr;
  String? dataOcr2;

  String? dataGambar;
  String? dataGambarCard;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Flutter Test Liveness",
          style: GoogleFonts.mukta(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                (dataGambarCard != null || dataGambar != null || dataOcr != null || dataOcr2 != null)
                    ? const SizedBox(height: 10)
                    : SizedBox(
                        height: MediaQuery.of(context).size.height * .35,
                      ),
                (dataGambarCard != null)
                    ? Column(
                        children: [
                          Container(
                            height: 300,
                            width: 300,
                            color: Colors.blue,
                            child: Image.memory(base64Decode(dataGambarCard!)),
                          ),
                          const SizedBox(height: 10),
                        ],
                      )
                    : const SizedBox(),
                (dataGambar != null)
                    ? Container(
                        height: 100,
                        width: 100,
                        color: Colors.blue,
                        child: Image.memory(base64Decode(dataGambar!)),
                      )
                    : const SizedBox(),
                (dataOcr != null)
                    ? Column(
                        children: [
                          Text("dataOcr\n\n $dataOcr"),
                          const SizedBox(height: 10),
                        ],
                      )
                    : const SizedBox(),
                (dataOcr2 != null)
                    ? Text("dataOcr KTP Mapping\n\n $dataOcr2")
                    : const SizedBox(
                        // height: MediaQuery.of(context).size.height * .35,
                        ),
                SizedBox(height: 20),
                Text(
                  "Flutter Test Liveness & OCR App",
                  style: GoogleFonts.mukta(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 20),
                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const SaasOCRCameraMLKitVer();
                            },
                          ),
                        );
                      },
                      child: Text("Test OCR ML Kit", style: GoogleFonts.mukta()),
                    ),
                    const SizedBox(width: 15),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              // return const SaasOcrCameraRND2();
                              return const SaasOcrCameraRND1();
                              // return const CameraOCRScreen(testMode: false);
                              // return const QoinSaasOCRCameraMLKitVer();
                              // return CameraScreenTest();
                              // return Test2Widget();
                              // return const CameraScreen(
                              //   testMode: false,
                              // );
                            },
                          ),
                        );
                      },
                      child: Text("Test OCR", style: GoogleFonts.mukta()),
                    ),
                    const SizedBox(width: 15),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          dataOcr = null;
                          dataOcr2 = null;
                          dataGambar = null;
                          dataGambarCard = null;
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return CameraOCRScreen(
                                testMode: true,
                                // callback: (String? textDetected) {
                                //   setState(() {
                                //     dataOcr = textDetected;
                                //   });
                                // },
                                callbackKTPMapping: (mapping) {
                                  setState(() {
                                    dataOcr2 = mapping;
                                  });
                                },
                                callbackSIMMapping: (mapping) {
                                  setState(() {
                                    dataOcr2 = mapping;
                                  });
                                },
                                callbackImage: (String? image) {
                                  if (image == null || image == "") {
                                    //
                                  } else {
                                    setState(() {
                                      dataGambar = image;
                                    });
                                  }
                                },
                                callbackImageCard: (String? image) {
                                  if (image == null || image == "") {
                                    //
                                  } else {
                                    setState(() {
                                      dataGambarCard = image;
                                    });
                                  }
                                },
                              );
                            },
                          ),
                        );
                      },
                      child: Text("Test OCR Test Mode", style: GoogleFonts.mukta()),
                    ),
                    const SizedBox(width: 15),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          dataGambar = null;
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return CameraLivenessScreen(
                                testMode: false,
                                callback: (String image) {
                                  setState(() {
                                    dataGambar = image;
                                  });
                                },
                              );
                              // return const TextRecognizerView();
                            },
                          ),
                        );
                      },
                      child: Text("Test Liveness (Face Recognition)", style: GoogleFonts.mukta()),
                    ),
                    const SizedBox(width: 15),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          dataGambar = null;
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return CameraLivenessScreen(
                                testMode: true,
                                callback: (String image) {
                                  setState(() {
                                    dataGambar = image;
                                  });
                                },
                              );
                              // return const TextRecognizerView();
                            },
                          ),
                        );
                      },
                      child: Text("Test Liveness (Face Recognition) Test Mode", style: GoogleFonts.mukta()),
                    ),
                    const SizedBox(width: 15),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          dataGambar = null;
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return SimpleKTPScanner();
                              // return KTPScannerWidget();
                              // return CameraLivenessScreen(
                              //   testMode: true,
                              //   callback: (String image) {
                              //     setState(() {
                              //       dataGambar = image;
                              //     });
                              //   },
                              // );
                              // return const TextRecognizerView();
                            },
                          ),
                        );
                      },
                      child: Text("RND: KTP Scanner Widget", style: GoogleFonts.mukta()),
                    ),
                  ],
                ),
                // const SizedBox(width: 15),
                // ElevatedButton(
                //   onPressed: () async {
                //     // try {
                //     //   OcrResultModel res = await MncIdentifierOcr.startCaptureKtp(withFlash: true, cameraOnly: true);
                //     //   debugPrint('result: ${res.toJson()}');
                //     // } catch (e) {
                //     //   debugPrint('something goes wrong $e');
                //     // }
                //     // setState(() {
                //     //   dataGambar = null;
                //     // });
                //     // Navigator.push(
                //     //   context,
                //     //   MaterialPageRoute(
                //     //     builder: (context) {
                //     //       return CameraLivenessScreen(
                //     //         testMode: true,
                //     //         callback: (String image) {
                //     //           setState(() {
                //     //             dataGambar = image;
                //     //           });
                //     //         },
                //     //       );
                //     //       // return const TextRecognizerView();
                //     //     },
                //     //   ),
                //     // );
                //     setState(() {
                //       dataGambar = null;
                //     });
                //     // Navigator.push(
                //     //   context,
                //     //   MaterialPageRoute(
                //     //     builder: (context) {
                //     //       return CameraLivenessAutentikaScreen(
                //     //         testMode: true,
                //     //         onImageCaptured: (image) {
                //     //           setState(() {
                //     //             dataGambar = image;
                //     //           });
                //     //         },
                //     //       );
                //     //     },
                //     //   ),
                //     // );
                //   },
                //   child: Text(
                //     "Test Liveness Autentika",
                //     style: GoogleFonts.mukta(),
                //   ),
                // ),
                (dataGambarCard != null || dataGambar != null || dataOcr != null || dataOcr2 != null) ? const SizedBox(height: 40) : const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
