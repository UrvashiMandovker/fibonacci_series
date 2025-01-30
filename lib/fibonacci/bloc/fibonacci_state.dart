abstract class FibonacciState {}
class FibonacciInitial extends FibonacciState {}
class FibonacciLoading extends FibonacciState {}
class FibonacciLoaded extends FibonacciState {
  final List<int> series;
  FibonacciLoaded(this.series);
}
class FibonacciError extends FibonacciState {
  final String message;
  FibonacciError(this.message);
}
