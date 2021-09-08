import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:prb_app/base/base-url.dart';
import 'package:prb_app/feature/dashboard/dashboard-employee/status/status-detail.dart';
import 'package:prb_app/model/approvalstatus.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class StatusPage extends StatefulWidget {
  String name;
  String so;
  String bu;

  StatusPage({Key key, this.name, this.so, this.bu}) : super(key: key);

  @override
  _StatusPageState createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  List data = [];
  String userId = "";
  int page = 1;
  String idNOO;
  Future<String> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt("iduser").toString();
    String usernameAuth = 'test';
    String passwordAuth = 'test456';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$usernameAuth:$passwordAuth'));
    print(basicAuth);
    var urlGetApproval = baseURL+"FindNOObyUserId/$userId?page=$page";
    print(urlGetApproval);
    Response r = await get(Uri.parse(urlGetApproval), headers: <String, String>{'authorization': basicAuth});
    // var dataApproval = json.decode(r.body.toString());
    // idNOO = dataApproval["id"].toString();
    print(r.statusCode);
    print(r.body);
    this.setState(() {
      print("XYZ");
      print("Dibawah xyx: $idNOO");
      data = jsonDecode(r.body);
      // data.addAll(jsonDecode(r.body));
    });
  }

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    getData();
    page = page - 1;
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    // data.add({});
    // data.add((data.length).toString());
    if (mounted)
      setState(() {
        getData();
        page = page + 1;
      });
    _refreshController.loadComplete();
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    // _onLoading();
    print("dibawah ini adalah list data card");
    _onLoading();
    _onRefresh();
    print("initState getData: ${getData()}");
    userId;
  }

  @override
  Widget build(BuildContext context) {
    print("Ini Status Page");
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white60,
          title: Text(
            "Status",
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Text(
                  widget.name ?? "",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: new Container(
          child: SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            header: WaterDropHeader(),
            footer: CustomFooter(
              builder: (BuildContext context, LoadStatus mode) {
                Widget body;
                if (mode == LoadStatus.idle) {
                  body = Text("pull up load");
                } else if (mode == LoadStatus.loading) {
                  body = CupertinoActivityIndicator();
                } else if (mode == LoadStatus.failed) {
                  body = Text("Load Failed!Click retry!");
                } else if (mode == LoadStatus.canLoading) {
                  body = Text("release to load more");
                } else {
                  body = Text("No more Data");
                }
                return Container(
                  height: 55.0,
                  child: Center(child: body),
                );
              },
            ),
            controller: _refreshController,
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            child: new ListView.builder(
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                print("xxData: $data");
                return new Container(
                  padding: EdgeInsets.all(7),
                  child: Card(
                    elevation: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          padding: EdgeInsets.all(6),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Name : ${data[index]['CustName']}",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(6),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Date : ${data[index]["CreatedDate"]}",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.blue,
                            ),
                          ),
                        ),

                        Container(
                          padding: EdgeInsets.all(6),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            data[index] == null
                                ? "halo jul"
                                : data[index]["Status"] ?? "okeh",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            height: 5,
                            child: Divider(
                              thickness: 1,
                              color: Colors.orange,
                              indent: 5,
                              endIndent: 5,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        //Ini row button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Center(
                              child: Container(
                                height: 60,
                                child: VerticalDivider(
                                  thickness: 2,
                                  color: Colors.orange,
                                  endIndent: 20,
                                  indent: 5,
                                ),
                              ),
                            ),
                            Center(
                              child: Container(
                                height: 30,
                                child: InkWell(
                                    child: Text(
                                      "DETAILS",
                                      style: TextStyle(
                                        color: Colors.blue,
                                      ),
                                    ),
                                    onTap: () async {
                                      await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  StatusDetailPage(
                                                    name: widget.name,
                                                    id: data[index]["id"],
                                                    userid: userId,
                                                    bu: widget.bu,
                                                    so: widget.so,
                                                  ))).then((value) {
                                        setState(() {
                                          _onRefresh();
                                          _onLoading();
                                        });
                                      });
                                    }),
                              ),
                            ),
                            Center(
                              child: Container(
                                height: 60,
                                child: VerticalDivider(
                                  thickness: 2,
                                  color: Colors.orange,
                                  endIndent: 20,
                                  indent: 5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ));
  }
}
