import 'package:cbu/models/models.dart';
import 'package:cbu/request/request.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController controller = TextEditingController();
  String searchQuery = '';

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: TextField(
          controller: controller,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Введите текст',
          ),
          onChanged: (query) {
            setState(() {
              searchQuery = query.toLowerCase();
            });
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Отмена'),
          ),
        ],
      ),
      body: FutureBuilder(
        future: CBRequest().getRequest(),
        builder: (context, snapshot) {
          // final filteredNotes = snapshot.data!.where((model) =>
          // model..toLowerCase().contains(searchQuery) ||
          //     note.subtitle.toLowerCase().contains(searchQuery))
          //     .toList();

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          if (snapshot.hasData) {
            final request = snapshot.data!
                .where((element) =>
                    element.ccy!.toLowerCase().contains(searchQuery))
                .toList();
            return ListView.builder(
              itemCount: request.length,
              itemBuilder: (context, index) {
                return CurrencyPageCBWidget(model: request[index]);
              },
            );
          }
          return const Center(child: Text('No data available'));
        },
      ),
    );
  }
}

class CurrencyPageCBWidget extends StatelessWidget {
  final CBModel model;

  const CurrencyPageCBWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    Color getColor() {
      double different = double.parse(model.diff!);
      if (different > 0) {
        return Colors.green;
      } else if (different < 0) {
        return Colors.red;
      } else {
        return Colors.grey;
      }
    }

    String getPlus() {
      double different = double.parse(model.diff!);
      if (different > 0) {
        return '+${model.diff.toString()}';
      } else if (different < 0) {
        return model.diff.toString();
      } else {
        return model.diff.toString();
      }
    }

    Icon getArrow() {
      double different = double.parse(model.diff!);
      if (different > 0) {
        return const Icon(Icons.arrow_upward);
      } else if (different < 0) {
        return const Icon(Icons.arrow_downward);
      }
      return const Icon(Icons.remove);
    }

    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
      ),
      child: ListTile(
        title: Text(
          '${model.nominal.toString()} ${model.ccy} = ${model.rate}',
          style: const TextStyle(fontSize: 18),
        ),
        subtitle: Text(
          getPlus(),
          style: TextStyle(
            color: getColor(),
            fontSize: 16,
          ),
        ),
        trailing: Icon(
          getArrow().icon,
          color: getColor(),
        ),
      ),
    );
  }
}
