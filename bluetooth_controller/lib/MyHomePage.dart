import 'package:flutter/material.dart';
import 'package:bluetooth_classic/models/device.dart';
import 'package:bluetooth_classic/bluetooth_classic.dart';

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Device> devices = [];
  final connection = BluetoothClassic();
  bool isConnected = false;

  Future<void> _getDevices() async {
    //gets permission to use bluetooth and discover nearby devices from user
    await connection.initPermissions();
    //gets list of paired devices
    var res = await connection.getPairedDevices();
    setState(() {
      devices = res;
    });
  }

  @override
  void initState() {
    super.initState();
    _getDevices();
  }

  void incrementSpeed() {
    if (isConnected == true) {
      connection.write('+');
    }
  }

  void decrementSpeed() {
    if (isConnected == true) {
      connection.write('-');
    }
  }

  void forward() {
    if (isConnected == true) {
      connection.write('f');
    }
  }

  void back() {
    if (isConnected == true) {
      connection.write('b');
    }
  }

  void left() {
    if (isConnected == true) {
      connection.write('l');
    }
  }

  void right() {
    if (isConnected == true) {
      connection.write('r');
    }
  }

  void stop() {
    if (isConnected == true) {
      connection.write('s');
    }
  }

  void connect() async {
    for (var device in devices) {
      if (device.name == "HC-05") {
        bool res = await connection.connect(
            device.address, "00001101-0000-1000-8000-00805F9B34FB");
        if (res) {
          setState(() {
            isConnected = true;
          });
        }
      }
    }
  }

  void disconnect() {
    connection.disconnect();
    setState(() {
      isConnected = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Skateboard Controller'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              FloatingActionButton(
                onPressed: forward,
                tooltip: 'Go forward',
                child: const Icon(Icons.north),
              )
            ],
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                FloatingActionButton(
                  onPressed: left,
                  tooltip: 'Go Left',
                  child: const Icon(Icons.west),
                ),
                FloatingActionButton(
                  onPressed: stop,
                  tooltip: 'Stop',
                  child: const Icon(Icons.stop),
                ),
                FloatingActionButton(
                  onPressed: right,
                  tooltip: 'Go Right',
                  child: const Icon(Icons.east),
                )
              ]),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                FloatingActionButton(
                  onPressed: back,
                  tooltip: 'Go Back',
                  child: const Icon(Icons.south),
                )
              ]),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                FloatingActionButton(
                  onPressed: incrementSpeed,
                  tooltip: 'Increment Speed',
                  child: const Icon(Icons.add),
                ),
                FloatingActionButton(
                    onPressed: decrementSpeed,
                    tooltip: 'Decrement speed',
                    child: const Icon(Icons.remove))
              ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              FloatingActionButton(
                onPressed: isConnected? disconnect : connect,
                tooltip: isConnected? 'Connect to arduino' : 'Disconnect from arduino',
                child: isConnected? const Icon(Icons.bluetooth_connected) : const Icon(Icons.bluetooth),
              ),
            ],
          )
        ],
      ),
    );
  }
}
