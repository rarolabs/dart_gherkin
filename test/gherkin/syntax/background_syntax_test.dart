import 'package:gherkin/src/gherkin/runnables/background.dart';
import 'package:gherkin/src/gherkin/runnables/debug_information.dart';
import 'package:gherkin/src/gherkin/runnables/runnable.dart';
import 'package:gherkin/src/gherkin/syntax/background_syntax.dart';
import 'package:test/test.dart';

void main() {
  group("isMatch", () {
    test('matches correctly', () {
      final syntax = BackgroundSyntax();
      expect(syntax.isMatch("Background: "), true);
      expect(syntax.isMatch("Background: "), true);
      expect(syntax.isMatch("Background: something"), true);
      expect(syntax.isMatch(" Background:   something"), true);
    });

    test('does not match', () {
      final syntax = BackgroundSyntax();
      expect(syntax.isMatch("Background"), false);
      expect(syntax.isMatch("Background something"), false);
      expect(syntax.isMatch("#Background: something"), false);
    });
  });

  group("toRunnable", () {
    test('creates BackgroundRunnable', () {
      final syntax = BackgroundSyntax();
      final Runnable runnable = syntax.toRunnable("Background: A backgroun 123",
          RunnableDebugInformation(null, 0, null));
      expect(runnable, isNotNull);
      expect(runnable, predicate((x) => x is BackgroundRunnable));
      expect(runnable.name, equals("A backgroun 123"));
    });

    test('creates BackgroundRunnable with empty name', () {
      final syntax = BackgroundSyntax();
      final Runnable runnable = syntax.toRunnable(
          "Background:   ", RunnableDebugInformation(null, 0, null));
      expect(runnable, isNotNull);
      expect(runnable, predicate((x) => x is BackgroundRunnable));
      expect(runnable.name, equals(""));
    });

    test('creates BackgroundRunnable with no name', () {
      final syntax = BackgroundSyntax();
      final Runnable runnable = syntax.toRunnable(
          "Background:", RunnableDebugInformation(null, 0, null));
      expect(runnable, isNotNull);
      expect(runnable, predicate((x) => x is BackgroundRunnable));
      expect(runnable.name, equals(""));
    });
  });
}
