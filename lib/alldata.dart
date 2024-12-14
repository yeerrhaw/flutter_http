import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http_flutter1/users.dart';

Future<List<Users>> fetchUserList() async {
  final response = await http.get(
    Uri.parse('https://reqres.in/api/users'),
  );

  if (response.statusCode == 200) {
    Map<String, dynamic> map = json.decode(response.body);
    List<dynamic> data = map['data'];
    return data.map<Users>((data) => Users.fromJson(data)).toList();
  } else {
    throw Exception('Failed to load user data');
  }
}

class AllData extends StatefulWidget {
  const AllData({super.key});

  @override
  State<AllData> createState() => _AllDataState();
}

class _AllDataState extends State<AllData> {
  late Future<List<Users>> fetchUserListAcc;

  @override
  void initState() {
    fetchUserListAcc = fetchUserList();
    super.initState();
  }

  buildList(BuildContext context, List<Users> fetchList) {
    return ListView.builder(
      itemCount: fetchList.length,
      itemBuilder: (context, int currentIndex) {
        return buildColumn(fetchList[currentIndex], context);
      },
    );
  }

  buildColumn(Users fetchList, BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(fetchList.avatar),
        ),
        title: Text('${fetchList.first_name} ${fetchList.last_name}'),
        subtitle: Text(fetchList.email),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fetching Data from Internet'),
      ),
      body: Center(
        child: FutureBuilder<List<Users>>(
          future: fetchUserList(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Users> fetchData = snapshot.data!;
              return buildList(context, fetchData);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
