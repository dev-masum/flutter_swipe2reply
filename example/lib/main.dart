import 'package:flutter/material.dart';
import 'package:flutter_swipe2reply/flutter_swipe2reply.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Swipe2Reply Example',
      theme: Theme.of(context).copyWith(useMaterial3: true),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final leftMessage = 'Hey buddy! Swipe left to reply.';
  final rightMessage = 'Hey buddy! Swipe right to reply.';

  void showSnackbar(String text) => ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(text)));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Swipe2Reply Example')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Swipe2reply(
                onSlided: () => showSnackbar(rightMessage),
                isRight: true,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: MessageWidget(text: rightMessage),
                ),
              ),
              const SizedBox(height: 40),
              Swipe2reply(
                onSlided: () => showSnackbar(leftMessage),
                isRight: false,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: MessageWidget(text: leftMessage),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MessageWidget extends StatelessWidget {
  final String text;

  const MessageWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        borderRadius: const BorderRadius.all(
          Radius.circular(
            10.0,
          ),
        ),
      ),
      child: Text(text),
    );
  }
}
