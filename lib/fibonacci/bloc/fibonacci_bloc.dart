import 'dart:isolate';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'fibonacci_event.dart';
import 'fibonacci_state.dart';

class FibonacciBloc extends Bloc<FibonacciEvent, FibonacciState> {
  FibonacciBloc() : super(FibonacciInitial()) {
    on<GenerateFibonacciEvent>(_onGenerateFibonacci);
  }

  Future<void> _onGenerateFibonacci(
      GenerateFibonacciEvent event, Emitter<FibonacciState> emit) async {
    emit(FibonacciLoading());
    try {
      List<int> result;
      if (event.useIsolate) {
        result = await _generateFibonacciWithIsolate(event.n);
      } else {
        result = await _generateFibonacciSeries(event.n);
      }
      emit(FibonacciLoaded(result));
    } catch (e) {
      emit(FibonacciError("Failed to compute series"));
    }
  }

  Future<List<int>> _generateFibonacciSeries(int n) async {
    return Future.delayed(const Duration(seconds: 2), () {
      List<int> fibSeries = [];
      int a = 0, b = 1;
      for (int i = 0; i < n; i++) {
        fibSeries.add(a);
        int temp = a;
        a = b;
        b = temp + b;
      }
      return fibSeries;
    });
  }

  Future<List<int>> _generateFibonacciWithIsolate(int n) async {
    final receivePort = ReceivePort();
    await Isolate.spawn(_fibonacciIsolateTask, [n, receivePort.sendPort]);
    return await receivePort.first as List<int>;
  }

  static void _fibonacciIsolateTask(List<dynamic> args) {
    int n = args[0] as int;
    SendPort sendPort = args[1] as SendPort;
    List<int> fibSeries = [];
    int a = 0, b = 1;
    for (int i = 0; i < n; i++) {
      fibSeries.add(a);
      int temp = a;
      a = b;
      b = temp + b;
    }
    sendPort.send(fibSeries);
  }
}
