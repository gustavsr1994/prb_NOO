import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:signature/signature.dart';
import 'dart:typed_data';
import 'dart:ui';

class SignaturePage extends StatefulWidget {
  @override
  _SignaturePageState createState() => _SignaturePageState();
}

class _SignaturePageState extends State<SignaturePage> {

  //SignatureController Sales
  final SignatureController _signaturecontrollersales = SignatureController(
    penStrokeWidth: 1,
    penColor: Colors.red,
    exportBackgroundColor: Colors.blue,
  );

  //SignatureController Customer
  final SignatureController _signaturecontrollercustomer = SignatureController(
    penStrokeWidth: 1,
    penColor: Colors.red,
    exportBackgroundColor: Colors.blue,
  );

  //SignatureController ASM
  final SignatureController _signaturecontrollerasm = SignatureController(
    penStrokeWidth: 1,
    penColor: Colors.red,
    exportBackgroundColor: Colors.blue,
  );

  //SignatureController BMACA
  final SignatureController _signaturecontrollerbmaca = SignatureController(
    penStrokeWidth: 1,
    penColor: Colors.red,
    exportBackgroundColor: Colors.blue,
  );



  @override
  void initState() {
    super.initState();
    _signaturecontrollersales.addListener(() => print('Value changed'));
    _signaturecontrollercustomer.addListener(() => print('Value changed'));
    _signaturecontrollerasm.addListener(() => print('Value changed'));
    _signaturecontrollerbmaca.addListener(() => print('Value changed'));
  }

  @override
  Widget build(BuildContext context) {

    print("Ini signature page");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white60,
        title: Text(
          "Signature Form",
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: <Widget>[
          const Center(
            child: Text(
              "Approved by :",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 20,),

          //Signature Canvas Sales
          Container(
            child: Column(
              children: [
                Text("Sales"),
                SizedBox(height: 10,),
                Signature(
                  controller: _signaturecontrollersales,
                  height: 300,
                  backgroundColor: Colors.lightBlueAccent,
                ),
                //Oke dan button clear
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      IconButton(
                          icon: const Icon(Icons.check),
                          color: Colors.blue,
                          onPressed: () async {
                            if (_signaturecontrollersales.isNotEmpty){
                              final Uint8List data = await _signaturecontrollersales.toPngBytes();
                              if (data != null) {
                                await Navigator.of(context).push(
                                    MaterialPageRoute<void>(
                                        builder: (BuildContext context){
                                          return Center(
                                            child: Container(
                                              color: Colors.grey[300],
                                              child: Image.memory(data),
                                            ),
                                          );
                                        }
                                    )
                                );
                              }
                            }
                          }
                      ),
                    ],
                  ),
                ),
                //Clear Canvass
                IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: (){
                      setState(() => _signaturecontrollersales.clear());
                    }
                ),
              ],
            ),
          ),
          SizedBox(height: 10,),

          //Signature Canvas Customer
          Container(
            child: Column(
              children: [
                Text("Customer"),
                SizedBox(height: 10,),
                Signature(
                  controller: _signaturecontrollercustomer,
                  height: 300,
                  backgroundColor: Colors.lightBlueAccent,
                ),
                //Oke dan button clear
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      IconButton(
                          icon: const Icon(Icons.check),
                          color: Colors.blue,
                          onPressed: () async {
                            if (_signaturecontrollercustomer.isNotEmpty){
                              final Uint8List data = await _signaturecontrollercustomer.toPngBytes();
                              if (data != null) {
                                await Navigator.of(context).push(
                                    MaterialPageRoute<void>(
                                        builder: (BuildContext context){
                                          return Center(
                                            child: Container(
                                              color: Colors.grey[300],
                                              child: Image.memory(data),
                                            ),
                                          );
                                        }
                                    )
                                );
                              }
                            }
                          }
                      ),
                    ],
                  ),
                ),
                //Clear Canvass
                IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: (){
                      setState(() => _signaturecontrollercustomer.clear());
                    }
                ),
              ],
            ),
          ),
          SizedBox(height: 10,),
        ],
      ),
    );
  }
}


