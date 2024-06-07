import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

const String serviceUuid = "4fafc201-1fb5-459e-8fcc-c5c9c331914b";
const String characteristicUuidFlex = "beb5483e-36e1-4688-b7f5-ea07361b26a8";

class BlueScan extends StatefulWidget {
  const BlueScan({
    super.key,
  });

  @override
  State<BlueScan> createState() => _BlueScanState();
}

class _BlueScanState extends State<BlueScan> {
  bool isConnected = false;
  FlutterBluePlus flutterBluePlus = FlutterBluePlus();
  BluetoothDevice? selectedDevice;

  BluetoothCharacteristic? flexCharacteristic;
  bool connected = false;
  final List<BluetoothDevice> devices = [];

  Future<void> connectToDevice(BluetoothDevice bluetoothDevice) async {
    try {
      await bluetoothDevice.connect();
      setState(() {
        connected = true;
      });
      print("The device is connected : $bluetoothDevice");
    } catch (e) {
      print("The device did not connect : $e ");
    }
  }

  void discoverServices() async {
    try {
      if (selectedDevice != null && selectedDevice!.isConnected) {
        var services = await selectedDevice!.discoverServices();
        for (var service in services) {
          if (service.uuid.toString() == serviceUuid) {
            for (var characteristic in service.characteristics) {
              flexCharacteristic = characteristic;
              subscribeToCharacteristic(characteristic);
            }
          }
        }
      }
    } catch (e) {
      print("Failed to discover services : $e ");
    }
  }

  void subscribeToCharacteristic(
      BluetoothCharacteristic bluetoothCharacteristic) {
    bluetoothCharacteristic.setNotifyValue(true);
    bluetoothCharacteristic.lastValueStream.listen((value) {
      String stringValue = String.fromCharCodes(value);
      if (kDebugMode) {
        print("The value is : $stringValue");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen dimensions
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Create a background image that covers the entire screen
    Widget background = SizedBox(
      width: screenWidth,
      height: screenHeight,
      child: Image.asset(
        'assets/images/backgroundShape.png',
        fit: BoxFit
            .cover, // Use BoxFit.cover to ensure the image covers the entire screen
      ),
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Bluetooth Connection"),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        titleTextStyle: TextStyle(
          color: Colors.cyan[900],
          fontSize: 24,
        ),
      ),
      floatingActionButton: StreamBuilder<bool>(
        stream: FlutterBluePlus.isScanning,
        initialData: false,
        builder: (c, snapshot) {
          if (snapshot.data!) {
            return FloatingActionButton(
              onPressed: () => FlutterBluePlus.stopScan(),
              backgroundColor: Colors.red,
              child: const Icon(Icons.stop),
            );
          } else {
            return FloatingActionButton(
              child: const Icon(Icons.search),
              onPressed: () => FlutterBluePlus.startScan(
                timeout: const Duration(seconds: 4),
              ),
            );
          }
        },
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            background,
            SafeArea(
              child: Column(
                children: <Widget>[
                  StreamBuilder<List<ScanResult>>(
                      stream: FlutterBluePlus.scanResults,
                      initialData: const [],
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Column(
                              children: snapshot.data!
                                  .map((scanDevice) => Container(
                                        color: Colors.white24,
                                        margin: const EdgeInsets.all(8.0),
                                        child: scanDevice
                                                .device.platformName.isEmpty
                                            ? const Center(
                                                child: Text(
                                                    'No devices Found.. Try Again'),
                                              )
                                            : ListTile(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                leading: Text(
                                                    scanDevice.rssi.toString()),
                                                title: Text(scanDevice
                                                    .device.platformName),
                                                subtitle: Text(scanDevice
                                                    .device.remoteId
                                                    .toString()),
                                                trailing: ElevatedButton(
                                                  onPressed: () async {
                                                    await connectToDevice(
                                                        scanDevice.device);
                                                    selectedDevice =
                                                        scanDevice.device;
                                                    discoverServices();
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                      backgroundColor: Colors
                                                          .deepOrange[400],
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5.0))),
                                                  child: const Text(
                                                    "Connect",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                      ))
                                  .toList());
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
