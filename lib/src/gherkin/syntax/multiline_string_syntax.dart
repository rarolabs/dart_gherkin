import '../runnables/debug_information.dart';
import '../runnables/multi_line_string.dart';
import '../runnables/runnable.dart';
import '../exceptions/syntax_error.dart';
import './comment_syntax.dart';
import './regex_matched_syntax.dart';
import './syntax_matcher.dart';
import './text_line_syntax.dart';

class MultilineStringSyntax extends RegExMatchedGherkinSyntax {
  @override
  final RegExp pattern = RegExp(
      r"^\s*("
      '"""'
      r"|'''|```)\s*$",
      multiLine: false,
      caseSensitive: false);

  @override
  bool get isBlockSyntax => true;

  @override
  bool hasBlockEnded(SyntaxMatcher syntax) {
    if (syntax is MultilineStringSyntax) {
      return true;
    } else if (!(syntax is TextLineSyntax || syntax is CommentSyntax)) {
      throw GherkinSyntaxException(
          "Multiline string block does not expect ${syntax.runtimeType} syntax.  Expects a text line");
    }
    return false;
  }

  @override
  Runnable toRunnable(String line, RunnableDebugInformation debug) {
    final runnable = MultilineStringRunnable(debug);
    return runnable;
  }

  @override
  EndBlockHandling endBlockHandling(SyntaxMatcher syntax) =>
      syntax is MultilineStringSyntax
          ? EndBlockHandling.ignore
          : EndBlockHandling.continueProcessing;
}
