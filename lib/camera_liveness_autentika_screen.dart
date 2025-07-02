// import 'dart:convert';
// import 'dart:io';
// import 'dart:typed_data';

// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test_mlkit_app/helper.dart';
// import 'package:flutter_test_mlkit_app/lottie_assets.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:lottie/lottie.dart';
// import 'package:saas_mlkit/saas_mlkit.dart';

// class CameraLivenessAutentikaScreen extends StatefulWidget {
//   final bool testMode;
//   final Function(String? image)? onImageCaptured;
//   final int motionCount;

//   const CameraLivenessAutentikaScreen({super.key, this.testMode = false, this.onImageCaptured, this.motionCount = 3});

//   @override
//   State<CameraLivenessAutentikaScreen> createState() => _CameraLivenessAutentikaScreenState();
// }

// class _CameraLivenessAutentikaScreenState extends State<CameraLivenessAutentikaScreen> {
//   CameraController? controller;

//   final List<String> motionList = <String>['blink', 'openMouth', 'shakeHead'];

//   bool validated = false;
//   bool faceLoss = false;

//   String? currentMotion;
//   List<List<dynamic>>? selectedMotion;
//   int motionProgress = 0;

//   void randomizeMotionV2() {
//     allMotion.shuffle();
//     selectedMotion = allMotion.take(widget.motionCount).toList();
//     selectedMotion!.add(<dynamic>[MotionType.takePict]);
//   }

//   List<List<dynamic>> allMotion = <List<dynamic>>[
//     <dynamic>[
//       MotionType.blink,
//       'Kedipkan mata Anda',
//       // Assets.eyeBlink,
//       LottieAssets.motionBlinkEyes,
//     ],
//     <dynamic>[
//       MotionType.openMouth,
//       'Buka mulut Anda',
//       // Assets.openMouth,
//       LottieAssets.motionOpenMouth,
//     ],
//     <dynamic>[
//       MotionType.shakeHead,
//       'Tengokkan wajah Anda',
//       // Assets.shakeHead,
//       LottieAssets.motionShakeHead,
//     ],
//   ];

//   String? captured;

//   void actionTakePicture({required BuildContext context, void Function(String? base64Image)? onImageCaptured}) async {
//     if (controller != null) {
//       XFile? data = await Helper().takePicture(controller!);

//       if (data != null) {
//         debugPrint('data captured $data');
//         XFile? imageCaptured;
//         imageCaptured = data;
//         File tempImage;
//         tempImage = File(
//           imageCaptured.path, // DISINI ERRORNYA
//         );
//         Uint8List bytes = await tempImage.readAsBytes();
//         captured = base64Encode(bytes);
//         debugPrint('tempImage ${tempImage.path}');

//         onImageCaptured?.call(captured);

//         // verifikasiWajahController.fotoWajah = tempImage;
//         // selfiePict = tempImage;
//         // Get.back();
//         // Get.to(
//         //   () => const VerifikasiWajahResultScreen(),
//         //   binding: VerifikasiWajahBinding(),
//         // );
//       } else {
//         //
//       }
//     }
//   }

//   bool isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     // randomizeMotionV2();
//   }

//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }

//   // Widget Function() cameraLivenessAutentika() {
//   //   return () {
//   //     return SaasLivenessAutentika(
//   //       activePrintLog: true,
//   //       loadingCallback: (value) {
//   //         setState(() {
//   //           isLoading = value;
//   //         });
//   //       },
//   //       onControllerCreated: (cameraController) {
//   //         setState(() {
//   //           controller = cameraController;
//   //           randomizeMotionV2();
//   //         });
//   //       },
//   //       // onFaceDetected: () {
//   //       //   //
//   //       // },
//   //       onFaceLoss: () {
//   //         setState(() {
//   //           currentMotion = null;
//   //           validated = false;
//   //           motionProgress = 0;
//   //           faceLoss = true;
//   //         });
//   //       },
//   //       onShakeHeadDetected: () {
//   //         setState(() {
//   //           if (motionProgress != (widget.motionCount - 1)) {
//   //             debugPrint('motionProgress onShakeHeadDetected $motionProgress');
//   //             motionProgress++;
//   //           } else {
//   //             validated = true;
//   //           }
//   //         });
//   //       },
//   //       onBlinkDetected: () {
//   //         setState(() {
//   //           if (motionProgress != (widget.motionCount - 1)) {
//   //             debugPrint('motionProgress onBlinkDetected $motionProgress');
//   //             motionProgress++;
//   //           } else {
//   //             validated = true;
//   //           }
//   //         });
//   //       },
//   //       onOpenMouthDetected: () {
//   //         setState(() {
//   //           if (motionProgress != (widget.motionCount - 1)) {
//   //             debugPrint('motionProgress onOpenMouthDetected $motionProgress');
//   //             motionProgress++;
//   //           } else {
//   //             validated = true;
//   //           }
//   //         });
//   //       },
//   //       onNodDetected: () {
//   //         setState(() {
//   //           if (motionProgress != (widget.motionCount - 1)) {
//   //             debugPrint('motionProgress onNodDetected $motionProgress');
//   //             motionProgress++;
//   //           } else {
//   //             validated = true;
//   //           }
//   //         });
//   //       },
//   //     );
//   //   };
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(widget.testMode ? "Flutter Test Liveness Autentika Test Mode" : "Flutter Test Liveness Autentika", style: GoogleFonts.mukta())),
//       body: (widget.testMode)
//           ? Stack(
//               children: [
//                 SaasLivenessAutentika(
//                   activePrintLog: true,
//                   gapTime: 3,
//                   loadingCallback: (value) {
//                     setState(() {
//                       isLoading = value;
//                     });
//                   },
//                   onControllerCreated: (cameraController) {
//                     setState(() {
//                       controller = cameraController;
//                       randomizeMotionV2();
//                     });
//                   },
//                   // onFaceDetected: () {
//                   //   //
//                   // },
//                   onFaceLoss: () {
//                     setState(() {
//                       currentMotion = null;
//                       validated = false;
//                       motionProgress = 0;
//                       faceLoss = true;
//                     });
//                   },
//                   onShakeHeadDetected: () {
//                     setState(() {
//                       if (motionProgress != (widget.motionCount - 1)) {
//                         debugPrint('motionProgress onShakeHeadDetected $motionProgress');
//                         motionProgress++;
//                       } else {
//                         validated = true;
//                       }
//                     });
//                   },
//                   onBlinkDetected: () {
//                     setState(() {
//                       if (motionProgress != (widget.motionCount - 1)) {
//                         debugPrint('motionProgress onBlinkDetected $motionProgress');
//                         motionProgress++;
//                       } else {
//                         validated = true;
//                       }
//                     });
//                   },
//                   onOpenMouthDetected: () {
//                     setState(() {
//                       if (motionProgress != (widget.motionCount - 1)) {
//                         debugPrint('motionProgress onOpenMouthDetected $motionProgress');
//                         motionProgress++;
//                       } else {
//                         validated = true;
//                       }
//                     });
//                   },
//                   onNodDetected: () {
//                     setState(() {
//                       if (motionProgress != (widget.motionCount - 1)) {
//                         debugPrint('motionProgress onNodDetected $motionProgress');
//                         motionProgress++;
//                       } else {
//                         validated = true;
//                       }
//                     });
//                   },
//                 ),
//                 (isLoading)
//                     ? Container(
//                         color: Colors.black45,
//                         child: const Center(
//                           child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [Text("Ikuti gerakan pada animasi di bawah", style: TextStyle(color: Colors.white, fontSize: 20)), SizedBox(height: 10), CircularProgressIndicator()]),
//                         ),
//                       )
//                     : const SizedBox(),
//                 if (controller != null) ...<Widget>[
//                   if (validated) ...<Widget>[
//                     Align(
//                       alignment: Alignment.bottomCenter,
//                       child: InkResponse(
//                         onTap: () async {
//                           actionTakePicture(
//                             context: context,
//                             onImageCaptured: (base64Image) {
//                               widget.onImageCaptured?.call(base64Image);
//                               Navigator.pop(context);
//                             },
//                           );
//                         },
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: <Widget>[
//                             Container(
//                               width: 64,
//                               height: 64,
//                               decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
//                               child: Center(child: Container(margin: const EdgeInsets.all(6.81), decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: const Color(0xFF6F6F6F), width: 2)))),
//                             ),
//                             const SizedBox(height: 100),
//                           ],
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 40),
//                   ] else ...<Widget>[
//                     if (faceLoss) ...<Widget>[
//                       Align(
//                         alignment: Alignment.bottomCenter,
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: <Widget>[
//                             Text("Liveness failed, please retry", style: GoogleFonts.mukta(fontSize: 34, color: Colors.red), textAlign: TextAlign.center),
//                             const SizedBox(height: 12),
//                             IconButton.filled(
//                               onPressed: () {
//                                 currentMotion = null;
//                                 validated = false;
//                                 motionProgress = 0;
//                                 faceLoss = false;
//                                 randomizeMotionV2();
//                                 // setState(() {
//                                 //   build(context);
//                                 // });
//                                 // setState(() {
//                                 //   reassemble();
//                                 // });
//                                 // initializeCamera();
//                               },
//                               icon: const Icon(Icons.refresh, size: 50),
//                             ),
//                             const SizedBox(height: 80),
//                           ],
//                         ),
//                       ),
//                     ] else ...<Widget>[
//                       Align(
//                         alignment: Alignment.bottomCenter,
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: <Widget>[
//                             Text(
//                               // currentMotionInstruction(),
//                               selectedMotion![motionProgress][1],
//                               style: GoogleFonts.mukta(fontSize: 34, color: Colors.white),
//                             ),
//                             const SizedBox(height: 12),
//                             // if (currentMotion != null && validated == false) ...<Widget>[
//                             if (validated == false) ...<Widget>[
//                               SizedBox(
//                                 height: 89,
//                                 width: 89,
//                                 child: Lottie.asset(
//                                   // currentMotionAnimation(),
//                                   selectedMotion![motionProgress][2],
//                                   // package: 'qoin_saas',
//                                 ),
//                               ),
//                             ],
//                             const SizedBox(height: 80),
//                           ],
//                         ),
//                       ),
//                     ],
//                     const SizedBox(height: 40),
//                   ],
//                 ],
//                 // Align(
//                 //   alignment: Alignment.topCenter,
//                 //   child: Column(
//                 //     children: [
//                 //       const SizedBox(height: 15),
//                 //       Text(
//                 //         "Current background progress:\n $backgroundProgress",
//                 //         style: GoogleFonts.mukta(
//                 //           fontSize: 18,
//                 //           color: Colors.white,
//                 //         ),
//                 //         textAlign: TextAlign.center,
//                 //       ),
//                 //     ],
//                 //   ),
//                 // ),
//               ],
//             )
//           : SaasLivenessAutentika(
//               activePrintLog: true,
//               onControllerCreated: (cameraController) {
//                 //
//               },
//               // onFaceDetected: () {
//               //   //
//               // },
//               onFaceLoss: () {
//                 setState(() {
//                   currentMotion = null;
//                   validated = false;
//                   motionProgress = 0;
//                   faceLoss = true;
//                 });
//               },
//               onShakeHeadDetected: () {
//                 setState(() {
//                   if (motionProgress != (widget.motionCount - 1)) {
//                     debugPrint('motionProgress onShakeHeadDetected $motionProgress');
//                     motionProgress++;
//                   } else {
//                     validated = true;
//                   }
//                 });
//               },
//               onBlinkDetected: () {
//                 setState(() {
//                   if (motionProgress != (widget.motionCount - 1)) {
//                     debugPrint('motionProgress onBlinkDetected $motionProgress');
//                     motionProgress++;
//                   } else {
//                     validated = true;
//                   }
//                 });
//               },
//               onOpenMouthDetected: () {
//                 setState(() {
//                   if (motionProgress != (widget.motionCount - 1)) {
//                     debugPrint('motionProgress onOpenMouthDetected $motionProgress');
//                     motionProgress++;
//                   } else {
//                     validated = true;
//                   }
//                 });
//               },
//               onNodDetected: () {
//                 setState(() {
//                   if (motionProgress != (widget.motionCount - 1)) {
//                     debugPrint('motionProgress onNodDetected $motionProgress');
//                     motionProgress++;
//                   } else {
//                     validated = true;
//                   }
//                 });
//               },
//             ),
//     );
//   }
// }
