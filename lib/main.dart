import 'dart:async';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'fibonacci/bloc/fibonacci_bloc.dart';
import 'fibonacci/bloc/fibonacci_event.dart';
import 'fibonacci/bloc/fibonacci_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => FibonacciBloc(),
        child: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});
@override
Widget build(BuildContext context) {
  TextEditingController valueController = TextEditingController();

  return Scaffold(
    appBar: AppBar(title: const Text("Isolate Demo")),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: valueController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Enter a number",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  final int? n = int.tryParse(valueController.text);
                  if (n != null && n > 0) {
                    context.read<FibonacciBloc>().add(GenerateFibonacciEvent(n, useIsolate: false));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please enter a valid positive number")),
                    );
                  }
                },
                child: const Text("Async"),
              ),
              ElevatedButton(
                onPressed: () {
                  final int? n = int.tryParse(valueController.text);
                  if (n != null && n > 0) {
                    context.read<FibonacciBloc>().add(GenerateFibonacciEvent(n, useIsolate: true));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please enter a valid positive number")),
                    );
                  }
                },
                child: const Text("Isolate"),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: BlocBuilder<FibonacciBloc, FibonacciState>(
              builder: (context, state) {
                if (state is FibonacciLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is FibonacciLoaded) {
                  return ListView(
                    children: state.series.map((num) => ListTile(title: Text(num.toString()))).toList(),
                  );
                } else if (state is FibonacciError) {
                  return Center(child: Text("Error: ${state.message}"));
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    ),
  );
}
}

