import 'package:flutter/material.dart';

class HomeResults extends StatelessWidget {
  final String displayText;
  final List<String> historico;

  const HomeResults(
      {super.key, required this.displayText, this.historico = const []});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ResultOperetion(displayText: displayText),
        const SizedBox(height: 16),
        Expanded(
          child: GridHistory(historico: historico),
        ),
      ],
    );
  }
}

class ResultOperetion extends StatelessWidget {
  final String displayText;

  const ResultOperetion({super.key, required this.displayText});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      alignment: Alignment.centerRight,
      child: Text(
        displayText,
        style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class GridHistory extends StatelessWidget {
  final List<String> historico;

  const GridHistory({super.key, required this.historico});

  @override
  Widget build(BuildContext context) {
    return historico.isNotEmpty
        ? GridView.builder(
            padding: const EdgeInsets.all(50.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 35.0,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
            ),
            itemCount: historico.length,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  historico[index],
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              );
            },
          )
        : const Center(
            child: Text(
              'Sem histórico',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          );
  }
}
