import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wom_app/pages/exercise/exercise_list.dart';
import 'package:wom_app/pages/providers/steps_provider.dart';
import '../providers/flex_angle_provider.dart';

const String serviceUuid = "4fafc201-1fb5-459e-8fcc-c5c9c331914b";
const String flexCharacteristicUuid = "beb5483e-36e1-4688-b7f5-ea07361b26a8";
const String stepCharacteristicUuid = "12345678-1234-5678-1234-56789abcdef0";

class BlueScan extends ConsumerStatefulWidget {
  const BlueScan({super.key, required this.exercises, required this.response, this.sessionData,});

  final dynamic response;
  final dynamic sessionData;

  final List<dynamic> exercises;

  @override
  ConsumerState<BlueScan> createState() => _BlueScanState();
}

class _BlueScanState extends ConsumerState<BlueScan> {


  bool isConnected = false;
  FlutterBluePlus flutterBluePlus = FlutterBluePlus();
  BluetoothDevice? selectedDevice;

  double flexAngle = 0;
  double steps = 0;
  double distance = 0;

  BluetoothCharacteristic? flexCharacteristic;
  BluetoothCharacteristic? stepCharacteristic;
  BluetoothCharacteristic? distanceCharacteristic;

  bool connected = false;
  final List<BluetoothDevice> devices = [];

  Future<void> connectToDevice(BluetoothDevice bluetoothDevice, BuildContext context) async {
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
              if(characteristic.uuid.toString() == flexCharacteristicUuid){
                flexCharacteristic = characteristic;
                subscribeToFlexCharacteristic(characteristic);
                continue;
              } else if (characteristic.uuid.toString() == stepCharacteristicUuid){
                stepCharacteristic = characteristic;
                subscribeToStepCharacteristic(characteristic);
              }
            }
          }
        }
      }
    } catch (e) {
      print("Failed to discover services : $e ");
    }
  }

  void subscribeToFlexCharacteristic(
      BluetoothCharacteristic bluetoothCharacteristic) {
    bluetoothCharacteristic.setNotifyValue(true);
    bluetoothCharacteristic.lastValueStream.listen((value) {
      flexAngle = double.parse(String.fromCharCodes(value));
      ref.read(flexAngleProvider.notifier).setStringValue(flexAngle);
      if (kDebugMode) {
        print("The value flex Angle is : $flexAngle");
      }
    });
  }

  void subscribeToStepCharacteristic(
      BluetoothCharacteristic bluetoothCharacteristic) {
    bluetoothCharacteristic.setNotifyValue(true);
    bluetoothCharacteristic.lastValueStream.listen((value) {
      steps = double.parse(String.fromCharCodes(value));
      ref.read(stepsProvider.notifier).setStringValue(steps);
      if (kDebugMode) {
        print("The value Steps is : $steps");
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
        fit: BoxFit.cover, // Use BoxFit.cover to ensure the image covers the entire screen
      ),
    );

    return  Scaffold(
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
                      const SizedBox(height: 15),
                      const Text(
                          "Please click the connect button to connect to the Wearable Device",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400

                          ),
                      ),
                      const SizedBox(height: 15),
                      StreamBuilder<List<ScanResult>>(
                          stream: FlutterBluePlus.scanResults,
                          initialData: const [],
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Column(
                                  children: snapshot.data!.map((scanDevice) =>
                                      Container(
                                            color: Colors.white24,
                                            margin: const EdgeInsets.all(8.0),
                                                child:   ListTile(
                                                    shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(8),
                                                  ),
                                                  leading: Text(
                                                  scanDevice.rssi.toString()),
                                                  title:  scanDevice
                                                      .device.platformName.isEmpty
                                                      ? const Text("Unknown Device")
                                                      : Text(scanDevice.device.platformName),
                                                  subtitle: Text(scanDevice
                                                      .device.remoteId
                                                      .toString()),
                                                    trailing: ElevatedButton(
                                                      onPressed: () async {

                                                        await connectToDevice(scanDevice.device, context);
                                                        selectedDevice = scanDevice.device;
                                                        discoverServices();
                                                        if(!context.mounted) return;
                                                        Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => ExerciseView(exercises: widget.exercises, response: widget.response, sessionData: widget.sessionData)
                                                          )
                                                        );

                                                      },
                                                      style: ElevatedButton.styleFrom(
                                                          backgroundColor: Colors.deepOrange[400],
                                                          shape: RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.circular(5.0))
                                                      ),
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
