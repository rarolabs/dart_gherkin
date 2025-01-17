import 'package:gherkin/src/gherkin/attachments/attachment.dart';

import '../gherkin/models/table.dart';
import '../gherkin/runnables/debug_information.dart';
import '../gherkin/steps/step_run_result.dart';

enum Target { run, feature, scenario, step }

class StartedMessage {
  final Target target;
  final String name;
  final RunnableDebugInformation context;

  StartedMessage(this.target, this.name, this.context);
}

class FinishedMessage {
  final Target target;
  final String name;
  final RunnableDebugInformation context;

  FinishedMessage(this.target, this.name, this.context);
}

class StepStartedMessage extends StartedMessage {
  final Table table;

  StepStartedMessage(
      Target target, String name, RunnableDebugInformation context, this.table)
      : super(target, name, context);
}

class StepFinishedMessage extends FinishedMessage {
  final StepResult result;
  final Iterable<Attachment> attachments;

  StepFinishedMessage(
      String name, RunnableDebugInformation context, this.result,
      [this.attachments = const Iterable<Attachment>.empty()])
      : super(Target.step, name, context);
}

class ScenarioFinishedMessage extends FinishedMessage {
  final bool passed;

  ScenarioFinishedMessage(
      String name, RunnableDebugInformation context, this.passed)
      : super(Target.scenario, name, context);
}
