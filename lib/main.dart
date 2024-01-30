import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasks/taskApi/taskDataModel.dart';
import 'package:tasks/taskApi/taskProvider.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DataProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Your App Title',
        home: apiFetchTask(),
      ),
    );
  }
}

class apiFetchTask extends StatefulWidget {
  @override
  _apiFetchTaskState createState() => _apiFetchTaskState();
}

class _apiFetchTaskState extends State<apiFetchTask> {
  late TextEditingController _searchController;
  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    Provider.of<DataProvider>(context, listen: false).fetchData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10,40,10,0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                prefixIcon: const Icon(Icons.search),
              ),
              onChanged: (query) {
                // Perform live search as the user types
                // You can use _searchController.text for the search query
              },
            ),
          ),

          Expanded(
            child: Consumer<DataProvider>(
              builder: (context, dataProvider, child) {
                if (dataProvider.data.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                    itemCount: dataProvider.data.length,
                    itemBuilder: (context, index) {
                      Datum data = dataProvider.data[index];
                      return ListTile(
                        title: Text(data.userDetails.name ?? 'N/A'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(data.userDetails.designation ?? 'No email'),
                            Text(data.userDetails.company ?? 'No email'),
                          ],
                        ),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(data.userDetails.photo),
                        ),
                        trailing: const Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.chat),
                            SizedBox(width: 8),
                            Text('Chat'),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      )
    );
  }
}



