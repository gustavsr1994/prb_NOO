import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:signature/signature.dart';
import 'dart:typed_data';
import 'dart:ui';

class SignaturePageAlt extends StatefulWidget {
  @override
  _SignaturePageAltState createState() => _SignaturePageAltState();
}

class _SignaturePageAltState extends State<SignaturePageAlt> {

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
                Text("ASM"),
                SizedBox(height: 10,),
                Signature(
                  controller: _signaturecontrollerasm,
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
                            if (_signaturecontrollerasm.isNotEmpty){
                              final Uint8List data = await _signaturecontrollerasm.toPngBytes();
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
                      setState(() => _signaturecontrollerasm.clear());
                    }
                ),
              ],
            ),
          ),
          SizedBox(height: 10,),

          //Signature Canvas BMACA
          Container(
            child: Column(
              children: [
                Text("BMACA"),
                SizedBox(height: 10,),
                Signature(
                  controller: _signaturecontrollerbmaca,
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
                            if (_signaturecontrollerbmaca.isNotEmpty){
                              final Uint8List data = await _signaturecontrollerbmaca.toPngBytes();
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
                      setState(() => _signaturecontrollerbmaca.clear());
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


