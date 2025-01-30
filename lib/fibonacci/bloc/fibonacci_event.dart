abstract class FibonacciEvent {}
class GenerateFibonacciEvent extends FibonacciEvent {
  final int n;
  final bool useIsolate;
  GenerateFibonacciEvent(this.n, {required this.useIsolate});
}