// import 'package:flutter/material.dart';

// class Applications extends StatefulWidget {
//   const Applications({super.key});

//   @override
//   State<Applications> createState() => _ApplicationsState();
// }

// class _ApplicationsState extends State<Applications> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey.shade900,
//       body: const Center(
//         child: Text(
//           'Add Applications',
//           style: TextStyle(
//             fontSize: 30, // Adjust font size
//             fontWeight: FontWeight.w500,
//             color: Colors.white,
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:urja_app/feature_appliances/models/appliance.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';


class ApplianceListScreen extends StatefulWidget {
  @override
  _ApplianceListScreenState createState() => _ApplianceListScreenState();
}

class _ApplianceListScreenState extends State<ApplianceListScreen> {
  List<Appliance> appliances = [
    Appliance(
        name: "Master AC", consumption: "25", runtime: "5 Hr", room: 'Bedroom'),
    Appliance(
        name: "Night Lamp",
        consumption: "5",
        runtime: "10 Hr",
        room: 'Living Room'),
    Appliance(
        name: "Main Light", consumption: "10", runtime: "17 Hr", room: 'Hall'),
  ];

  final TextEditingController nameController = TextEditingController();
  final consumptionController = TextEditingController();
  final TextEditingController roomController = TextEditingController();

  void _addAppliance() {
    String name = nameController.text;
    String consumption = consumptionController.text;
    String room = roomController.text;

    if (name.isNotEmpty && consumption.isNotEmpty) {
      setState(() {
        appliances.add(Appliance(
            name: name, consumption: consumption, runtime: "0 Hr", room: room));
      });
      nameController.clear();
      consumptionController.clear();
      roomController.clear();
      Navigator.pop(context);
    }
  }

  void _showAddApplianceDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Appliance'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Appliance Name'),
              ),
              TextField(
                controller: consumptionController,
                decoration: InputDecoration(
                    labelText: 'Rating of Appliance (in Watts)'),
              ),
              TextField(
                controller: roomController,
                decoration: InputDecoration(labelText: 'Room'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: _addAppliance,
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Home Appliances',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 13, 13, 13),
      ),
      body: Scaffold(
        backgroundColor: const Color.fromARGB(255, 13, 13, 13),
        body: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: appliances.length,
                itemBuilder: (context, index) {
                  Appliance appliance = appliances[index];
                  return Padding(
                    padding: const EdgeInsets.only(
                        top: 20, left: 15, right: 15, bottom: 10),
                    child: Material(
                      elevation: 3,
                      borderRadius: BorderRadius.circular(15.0),
                      child: ListTile(
                        minTileHeight: 100,
                        tileColor: const Color.fromARGB(255, 31, 29, 29),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: const BorderSide(
                            color: Colors.grey,
                          ), //
                        ),
                        leading: const SizedBox(
                          width: 45,
                          height: 45,
                          child: Icon(
                            Icons.electric_bolt_rounded,
                            color: Color.fromARGB(255, 8, 185, 14),
                          ),
                        ),
                        title: Text(
                          appliance.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Total Consumption:  ${(appliance.consumption)}kWh',
                              style: const TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Run Time:  ${appliance.runtime}',
                              style: const TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                              ),
                            ),
                            Text('Room:  ${appliance.room}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                )),
                          ],
                        ),
                        trailing: LiteRollingSwitch(
    //initial value
    value: true,
    width: 90,
    textOn: 'ON',
    textOff: 'OFF',
    colorOn: Colors.green,
    colorOff: Colors.grey,
    iconOn: Icons.done,
    iconOff: Icons.power_settings_new,
    textSize: 13.0,
    onChanged: (bool state) {
      //Use it to manage the different states
      print('Current State of SWITCH IS: $state');
    }, onTap: (){}, onDoubleTap: (){}, onSwipe: (){},
),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: _showAddApplianceDialog,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Color.fromARGB(255, 8, 185, 14), // background
                  foregroundColor: Colors.white, // foreground
                ),
                child: Text('Add Appliance'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
