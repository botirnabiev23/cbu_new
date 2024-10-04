import 'package:cbu/models/models.dart';
import 'package:cbu/request/request.dart';
import 'package:flutter/material.dart';

class CurrencyPage extends StatefulWidget {
  const CurrencyPage({super.key});

  @override
  State<CurrencyPage> createState() => _CurrencyPageState();
}

class _CurrencyPageState extends State<CurrencyPage> {
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    late Future<List<dynamic>> futureRequest;

    @override
    // ignore: unused_element
    void initState() {
      super.initState();
      futureRequest = CBRequest().getRequest();
    }

    Future<void> refreshItems() async {
      final newData = await CBRequest().getRequest();

      setState(() {
        futureRequest = Future.value(newData);
      });
    }

    return FutureBuilder(
      future: CBRequest().getRequest(),
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
          return RefreshIndicator(
            onRefresh: refreshItems,
            child: ListView.builder(
              itemCount: request.length,
              itemBuilder: (context, index) {
                return CurrencyPageCBWidget(model: request[index]);
              },
            ),
          );
        }
        return const Center(child: Text('No data available'));
      },
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
        // shape: const RoundedRectangleBorder(
        //   side: BorderSide(
        //     strokeAlign: 1,
        //     color: Colors.grey,
        //     width: 0.5,
        //   ),
        // ),
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
