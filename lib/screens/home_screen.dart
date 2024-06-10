import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_example/screens/second_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();

  var box1 = Hive.box('myBoxOne');
  var box2 = Hive.box('myBoxTwo');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const SecondScreen();
              }));
            },
            icon: const Icon(Icons.arrow_forward_ios),
          )
        ],
        title: const Text('Home'),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Saving key, value',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: controller1,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                box1.put('key', controller1.text);
                controller1.clear();
                setState(() {});
              },
              child: const Text('Save'),
            ),
            const SizedBox(height: 20),
            Text('${box1.get('key')}'),
            const SizedBox(height: 20),
            const Text(
              'Saving List',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: controller2,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                box2.add(controller2.text);
                controller2.clear();
                setState(() {});
              },
              child: const Text('Save'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: box2.values.length,
                itemBuilder: (context, index) {
                  return Text(box2.values.toList()[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
