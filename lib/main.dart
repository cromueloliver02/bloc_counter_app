import 'package:bloc_counter_app/other_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/counter/counter_bloc.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterBloc>(
      create: (context) => CounterBloc(),
      child: MaterialApp(
        title: 'Bloc Counter App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (ctx) => const HomePage(),
          '/other': (ctx) => const OtherPage(),
        },
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CounterBloc>();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Count',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            BlocConsumer<CounterBloc, CounterState>(
              listener: (ctx, state) {
                if (state.counter == 3) {
                  showDialog(
                    context: context,
                    builder: (ctx) =>
                        AlertDialog(title: Text('Counter is ${state.counter}')),
                  );
                }

                if (state.counter == -1) Navigator.pushNamed(context, '/other');
              },
              builder: (ctx, state) => Text(
                '${state.counter}',
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: UniqueKey(),
            onPressed: () => bloc.add(DecrementCounterEvent()),
            child: const Icon(Icons.remove),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            heroTag: UniqueKey(),
            onPressed: () => bloc.add(IncrementCounterEvent()),
            child: const Icon(Icons.add),
          )
        ],
      ),
    );
  }
}
