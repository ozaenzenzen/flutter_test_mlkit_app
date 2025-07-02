import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class OCRHandlerV2 {
  OCRHandlerV2._();
  static Future<KtpocrData?> getKtpData(RecognizedText recognizedText) async {
    try {
      // final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

      // final RecognizedText recognizedText = await textRecognizer.processImage(InputImage.fromFile(file));

      Rect? nameboundingBox;
      Rect? nikboundingBox;
      for (TextBlock block in recognizedText.blocks) {
        for (TextLine line in block.lines) {
          for (var element in line.elements) {
            if (element.text.toLowerCase().contains('nama')) {
              nameboundingBox = element.boundingBox;
            }
            if (element.text.toLowerCase().contains('nik')) {
              nikboundingBox = element.boundingBox;
            }
          }
        }
      }

      String? nameData;
      String? nikData;
      for (TextBlock block in recognizedText.blocks) {
        for (TextLine line in block.lines) {
          if (isDataDetected(line, nameboundingBox)) {
            nameData = line.text;
          }
          if (isDataDetected(line, nikboundingBox)) {
            nikData = line.text;
          }
        }
      }

      return KtpocrData(
        nik: nikData,
        nama: nameData,
      );
    } catch (e) {
      return null;
    }
  }

  static bool isDataDetected(TextLine line, Rect? nameboundingBox) {
    if (nameboundingBox == null) return false;
    var nameDataBox = line.boundingBox;
    if (nameDataBox.center.dx > (nameboundingBox.centerRight.dx) && nameDataBox.center.dy < (nameboundingBox.bottomCenter.dy) && nameDataBox.center.dy > (nameboundingBox.topCenter.dy)) {
      return true;
    }
    return false;
  }
}

KtpocrData ktpocrDataFromJson(String str) => KtpocrData.fromJson(json.decode(str));

String ktpocrDataToJson(KtpocrData data) => json.encode(data.toJson());

class KtpocrData {
  String? nik;
  String? nama;

  KtpocrData({
    this.nik,
    this.nama,
  });

  factory KtpocrData.fromJson(Map<String, dynamic> json) => KtpocrData(
        nik: json["nik"],
        nama: json["nama"],
      );

  Map<String, dynamic> toJson() => {
        "nik": nik,
        "nama": nama,
      };
}
