import 'package:cbu/models/models.dart';
import 'package:cbu/request/request.dart';
import 'package:flutter/material.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: OnlineService().getQuotes(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }
        if (snapshot.hasData) {
          final request = snapshot.data!;
          return ListView.builder(
            itemCount: request.length,
            itemBuilder: (context, index) {
              return NewsPageWidget(quote: request[index]);
            },
          );
        }
        return const Center(child: Text('No data available'));
      },
    );
  }
}

class NewsPageWidget extends StatelessWidget {
  final Quote quote;
  const NewsPageWidget({super.key, required this.quote});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              quote.text,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              '- ${quote.from}',
              style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              textAlign: TextAlign.right,
            ),
          ],
        ),
      ),
    );
  }
}
