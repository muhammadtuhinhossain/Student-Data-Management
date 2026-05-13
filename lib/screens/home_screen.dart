import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_data_management/model/student_data_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String _studentDataName='student';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text('Student Data Management'),
        centerTitle: true,
        backgroundColor: Colors.grey.shade800,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('student').orderBy('Roll').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>asyncSnapshot) {

            if(asyncSnapshot.connectionState == .waiting){
              return Center(child: CircularProgressIndicator());
            }

            if(asyncSnapshot.hasError){
              return Center(child: Text(asyncSnapshot.error.toString()));
            }
            if(asyncSnapshot == false){
              return Center(child: Text('No data available'));
            }

            List<StudentDataModel> studentDataList=[];
            for(QueryDocumentSnapshot doc in asyncSnapshot.data!.docs){
              studentDataList.add(
                StudentDataModel.fromJson(
                  doc.id, doc.data() as Map<String, dynamic>,
                ),
              );
            }


            return ListView.builder(
                itemCount: studentDataList.length,
                itemBuilder: (context, index){
                  final StudentDataModel dataModel=studentDataList[index];
                  return Card(
                    elevation: 10,
                    color: Colors.grey.shade800,
                    child: ListTile(
                      title: Text("Name: ${dataModel.name}",style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Roll: ${dataModel.rollNumber.toString()}",style: TextStyle(fontSize: 12)),
                          Text("Course: ${dataModel.course}",style: TextStyle(fontSize: 12)),
                          //Divider(),
                        ],
                      ),
                    ),
                  );
                });
          }
        ),
      ),
    );
  }
}
