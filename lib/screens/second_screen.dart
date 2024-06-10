import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_example/data/models/car_model.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController brand = TextEditingController();
  TextEditingController price = TextEditingController();

  var car = Hive.box('cars');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Save Model'),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: name,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: brand,
              decoration: InputDecoration(
                labelText: 'Brand',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              controller: price,
              decoration: InputDecoration(
                labelText: 'Price',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (name.text.isNotEmpty &&
                    brand.text.isNotEmpty &&
                    price.text.isNotEmpty) {
                  car.add(CarModel(
                    name: name.text,
                    brand: brand.text,
                    price: int.parse(price.text),
                  ));
                  name.clear();
                  brand.clear();
                  price.clear();
                  setState(() {});
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Fill in all fields')),
                  );
                }
              },
              child: const Text('Save'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: car.values.length,
                itemBuilder: (context, index) {
                  List<CarModel> cars = car.values.toList().cast();
                  return ListTile(
                    title: Text(cars[index].name),
                    subtitle: Text(cars[index].brand),
                    trailing: Text(cars[index].price.toString()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
