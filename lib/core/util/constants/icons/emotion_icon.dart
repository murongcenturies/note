import 'package:note/core/core.dart';


class EmotionIcon {
  final Emotion emotion;
  final String svgPath;

  const EmotionIcon({
    required this.emotion,
    required this.svgPath,
  });
}

class EmotionIcons {
  static const Map<Emotion, String> emotionIcons = {

    Emotion.sad: 'assets/emotion/sad.svg',
    Emotion.angry: 'assets/emotion/angry.svg',
    Emotion.anxious:'assets/emotion/anxious.svg',
    Emotion.calm:'assets/emotion/calm.svg',
    Emotion.joyful:'assets/emotion/joyful.svg',
    Emotion.worried:'assets/emotion/worried.svg',
    Emotion.tired:'assets/emotion/tired.svg',
    Emotion.surprised:'assets/emotion/surprised.svg',
  };

  static String getSvgPath(Emotion emotion) {
    return emotionIcons[emotion]!;
  }

  static List<EmotionIcon> getAllIcons() {
    return emotionIcons.entries.map((entry) {
      return EmotionIcon(
        emotion: entry.key,
        svgPath: entry.value,
      );
    }).toList();
  }
}
