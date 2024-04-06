// 引入格式化日期时间库
import 'package:intl/intl.dart';

// 日期时间格式化类，用于将日期时间格式化为不同的字符串格式
abstract class FormatDateTime {
  // 私有构造函数，防止实例化
  FormatDateTime._();

  // 固定格式字符串 (编辑时间 12:00)
  static const String _fixFormat = '编辑时间 12:00';

  // 时间格式化器 (用于格式化时分)
  static final DateFormat _timeFormat = DateFormat('HH:mm');

  // 日期和月份格式化器 (用于格式化日和月)
  static final DateFormat _dayAndMonthFormat = DateFormat('dd MMM');

  // 完整日期格式化器 (用于格式化日、月、年)
  static final DateFormat _fullFormat = DateFormat('dd MMM yy');

  /// 获取格式化后的日期时间字符串
  static String getFormatDateTime(DateTime dateTime) {
    // 获取当前时间
    final now = DateTime.now();

    // 判断日期是否为同一天
    if (dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day) {
      // 判断时间是否为中午 12 点
      if (dateTime.hour == 12 && dateTime.minute == 0) {
        return _fixFormat;
      } else {
        // 格式化为 "编辑时间 HH:mm"
        return 'Edited ${_timeFormat.format(dateTime)}';
      }
    } else if (dateTime.year == now.year) {
      // 格式化为 "编辑时间 dd MMM" (例如，编辑时间 08 二月)
      return 'Edited ${_dayAndMonthFormat.format(dateTime)}';
    } else {
      // 格式化为 "编辑时间 dd MMM yy" (例如，编辑时间 28 二月 2024)
      return 'Edited ${_fullFormat.format(dateTime)}';
    }
  }
}
