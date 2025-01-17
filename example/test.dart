import 'dart:async';
import 'package:gherkin/gherkin.dart';
import 'package:glob/glob.dart';
import 'supporting_files/hooks/hook_example.dart';
import 'supporting_files/parameters/power_of_two.parameter.dart';
import 'supporting_files/steps/given_the_numbers.step.dart';
import 'supporting_files/steps/given_the_powers_of_two.step.dart';
import 'supporting_files/steps/then_expect_numeric_result.step.dart';
import 'supporting_files/steps/when_numbers_are_added.step.dart';
import 'supporting_files/worlds/custom_world.world.dart';

Future<void> main() {
  final config = TestConfiguration()
    ..features = [Glob(r"features/**.feature")]
    ..reporters = [
      StdoutReporter(MessageLevel.error),
      ProgressReporter(),
      TestRunSummaryReporter(),
      JsonReporter(path: './report.json')
    ]
    ..hooks = [HookExample()]
    ..customStepParameterDefinitions = [PowerOfTwoParameter()]
    ..createWorld = (TestConfiguration config) {
      return Future.value(CalculatorWorld());
    }
    ..stepDefinitions = [
      GivenTheNumbers(),
      GivenThePowersOfTwo(),
      WhenTheStoredNumbersAreAdded(),
      ThenExpectNumericResult()
    ]
    // ..tagExpression = '@debug'
    ..exitAfterTestRun = true;

  return GherkinRunner().execute(config);
}
