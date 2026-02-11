import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'models/product.dart';

Future<Product> fetchData() async {
  final response = await http.get(
    Uri.parse('https://www.itpart.net/mobile/api/product.php'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {
    // 200 OK response, then parse the JSON.
    debugPrint('my_app response.body : ${response.body}');
    return Product.fromJson(jsonDecode(response.body));
  } else {
    //  not return a 200 OK response,then throw an exception.
    throw Exception('Failed to load data.');
  }
}

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  String baseImgUrl = 'https://www.itpart.net/mobile/images/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        title: const Text('Detail Page'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              FutureBuilder(
                future: fetchData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // until data is fetched, show loader
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasData) {
                    return Column(
                      children: [
                        // Text('${snapshot.data!.id}'),
                        Text(snapshot.data!.title,
                            style: Theme.of(context).textTheme.titleLarge),
                        const SizedBox(height: 10),
                        Image.network('$baseImgUrl${snapshot.data!.imageURL}'),
                        const SizedBox(height: 20),
                        Text(snapshot.data!.desc,
                            style: TextStyle(fontSize: 18)),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}',
                        style: TextStyle(fontSize: 18));
                  }
                  return const Text('No data available!');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
