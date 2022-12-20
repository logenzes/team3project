import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'package:project_flutter/pages/mysql.dart';
import 'package:project_flutter/pages/data_table.dart';

class HistoryData extends StatefulWidget {
  const HistoryData({
    Key? key,
  }) : super(key: key);

  @override
  State<HistoryData> createState() => _HistoryDataState();
}

class _HistoryDataState extends State<HistoryData> {
  Future<List<History>> getSQLData() async {
    final List<History> historyList = [];
    final Mysql db = Mysql();
    await db.getConnection().then((conn) async {
      String sqlQuery =
          'select topic, status, Datetime from History';
      await conn.query(sqlQuery).then((result) {
        for (var res in result) {
          final historyModel = History(
            
            topic: res["topic"],
            status: res["status"],
            Datetime: res["Datetime"],
          );
          historyList.add(historyModel);
        }
      }).onError((error, stackTrace) {
        print(error);
        return null;
      });
      conn.close();
    });
    return historyList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("History")),
      body: Center(
        child: getDBData(),
      ),
    );
  }

  FutureBuilder<List> getDBData() {
    return FutureBuilder<List>(
        future: getSQLData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final data = snapshot.data as List;
              return ListTile(
                leading: Text(
                  data[index].topic.toString(),
                  style: const TextStyle(fontSize: 20),
                ),
                title: Text(
                  data[index].status.toString(),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  data[index].Datetime.toString(),
                  style: const TextStyle(fontSize: 20),
                ),
                
              );
            },
          );
        });
  }
}
