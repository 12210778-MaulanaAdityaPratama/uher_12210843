import 'package:flutter/material.dart';
import 'api_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ApiService apiService =
      ApiService('https://64e488dbc555638029136234.mockapi.io/');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API Fetch Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FetchDataPage(apiService: apiService),
    );
  }
}

class FetchDataPage extends StatefulWidget {
  final ApiService apiService;

  FetchDataPage({required this.apiService});

  @override
  _FetchDataPageState createState() => _FetchDataPageState();
}

class _FetchDataPageState extends State<FetchDataPage> {
  late Future<List<dynamic>> _data;

  @override
  void initState() {
    super.initState();
    _data = widget.apiService.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Mahasiswa'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _data,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final data = snapshot.data;
            return ListView.builder(
              itemCount: data!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(
                      8.0), // Menambahkan padding keseluruhan
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${data[index]['nim']}'),
                      SizedBox(height: 4), // Memberikan jarak vertical
                      Text('${data[index]['nama']}')
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
