import 'package:firebase_app/models/kandidates_model.dart';
import 'package:firebase_app/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class ResultsScreen extends StatefulWidget {
  ResultsScreen({super.key, required this.model});

  List<Candidates> model;

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  int summ = 0;

  func() {
    for (int i = 0; i < widget.model.length; i++) {
      summ += widget.model[i].voice;
    }
  }

  @override
  void initState() {
    func();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Results'),
      ),
      body: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: widget.model.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  children: [
                    Text(widget.model[index].name),
                    LinearProgressIndicator(
                      value: widget.model[index].voice / summ,
                      minHeight: 10,
                    ),
                    Text('${widget.model[index].voice / summ * 100}%'),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 25),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()));
            },
            child: const Text('Назад'),
          )
        ],
      ),
    );
  }
}
