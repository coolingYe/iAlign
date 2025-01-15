import 'package:logger/logger.dart';

class LogUtil{
  factory LogUtil() =>_getInstance();
  static  LogUtil? _instance;
  LogUtil._(){
    logger = Logger(
      filter: CustomFilter(),
      level: Level.all,
      printer: PrettyPrinter(
          methodCount: 0,
          errorMethodCount: 8,
          lineLength: 120,
          colors: true,
          printEmojis: true
      ),
    );
  }

  static LogUtil _getInstance() {
    _instance ??= LogUtil._();
    return _instance!;
  }

  late final Logger logger;

}

class CustomFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    return true;
  }
}