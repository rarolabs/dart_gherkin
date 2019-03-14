import '../gherkin/steps/world.dart';
import '../configuration.dart';
import './hook.dart';

class AggregatedHook extends Hook {
  Iterable<Hook> _orderedHooks;

  void addHooks(Iterable<Hook> hooks) {
    _orderedHooks = hooks.toList()..sort((a, b) => b.priority - a.priority);
  }

  @override
  Future<void> onBeforeRun(TestConfiguration config) async =>
      await _invokeHooks((h) => h.onBeforeRun(config));

  /// Run after all scenerios in a test run have completed
  @override
  Future<void> onAfterRun(TestConfiguration config) async =>
      await _invokeHooks((h) => h.onAfterRun(config));

  @override
  Future<void> onAfterScenarioWorldCreated(
          World world, String scenario) async =>
      await _invokeHooks((h) => h.onAfterScenarioWorldCreated(world, scenario));

  /// Run before a scenario and it steps are executed
  @override
  Future<void> onBeforeScenario(
          TestConfiguration config, String scenario) async =>
      await _invokeHooks((h) => h.onBeforeScenario(config, scenario));

  /// Run after a scenario has executed
  @override
  Future<void> onAfterScenario(
          TestConfiguration config, String scenario) async =>
      await _invokeHooks((h) => h.onAfterScenario(config, scenario));

  Future<void> _invokeHooks(Future<void> invoke(Hook h)) async {
    if (_orderedHooks != null && _orderedHooks.isNotEmpty) {
      for (var hook in _orderedHooks) {
        await invoke(hook);
      }
    }
  }
}