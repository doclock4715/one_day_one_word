import 'package:one_day_one_word/core/constants/lists.dart';
import 'package:one_day_one_word/core/localization/application_strings.dart';

abstract class BaseState {
  final WordContent wordContent = WordContent.instance;
  final ApplicationStrings applicationStrings = ApplicationStrings.instance;
}
