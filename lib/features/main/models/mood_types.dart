import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_project/constants/fontsize.dart';

class EmotionData {
  final String key;
  final Text emoji;
  final String detail;
  final FaIcon icon;
  final Color backgroundColor;

  EmotionData({
    required this.key,
    required this.emoji,
    required this.detail,
    required this.icon,
    required this.backgroundColor,
  });
}

enum EmotionType {
  heart,
  sun,
  cloud,
  cry,
  cloudSun,
  ;

  /// 각 케이스별 EmotionData 반환
  EmotionData get data {
    switch (this) {
      case EmotionType.heart:
        return EmotionData(
          key: 'heart',
          emoji: Text(
            "😍",
            style: TextStyle(
              fontSize: FontSize.fs28,
            ),
          ),
          detail: '행복해요',
          backgroundColor: Colors.red.shade500,
          icon: FaIcon(
            FontAwesomeIcons.solidHeart,
            color: Colors.pink.shade100,
            size: FontSize.fs72,
          ),
        );
      case EmotionType.sun:
        return EmotionData(
          key: 'sun',
          emoji: Text(
            "😄",
            style: TextStyle(
              fontSize: FontSize.fs28,
            ),
          ),
          detail: '즐거워요',
          backgroundColor: Colors.blue.shade500,
          icon: FaIcon(
            FontAwesomeIcons.solidSun,
            color: Colors.orange.shade400,
            size: FontSize.fs72,
          ),
        );
      case EmotionType.cloud:
        return EmotionData(
          key: 'cloud',
          emoji: Text(
            "😔",
            style: TextStyle(
              fontSize: FontSize.fs28,
            ),
          ),
          detail: '우울해요',
          backgroundColor: Colors.grey.shade500,
          icon: FaIcon(
            FontAwesomeIcons.cloud,
            color: Colors.grey.shade700,
            size: FontSize.fs72,
          ),
        );
      case EmotionType.cry:
        return EmotionData(
          key: 'cry',
          emoji: Text(
            "😢",
            style: TextStyle(
              fontSize: FontSize.fs28,
            ),
          ),
          detail: '슬퍼요',
          backgroundColor: Colors.black,
          icon: FaIcon(
            FontAwesomeIcons.umbrella,
            color: Colors.blue.shade900,
            size: FontSize.fs72,
          ),
        );
      case EmotionType.cloudSun:
        return EmotionData(
          key: 'cloudSun',
          emoji: Text(
            "🙂",
            style: TextStyle(
              fontSize: FontSize.fs28,
            ),
          ),
          detail: '평범해요',
          backgroundColor: Colors.green,
          icon: FaIcon(
            FontAwesomeIcons.cloudSun,
            color: Colors.yellow.shade600,
            size: FontSize.fs72,
          ),
        );
    }
  }

  static EmotionType fromKey(String key) {
    for (var emotion in EmotionType.values) {
      if (emotion.data.key == key) {
        return emotion;
      }
    }
    throw Exception('Unknown emotion key: $key');
  }
}
