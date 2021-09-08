import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:async/async.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:commons/commons.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:path/path.dart';
import 'package:prb_app/base/base-url.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'file:///C:/Users/mz002/StudioProjects/prb_NOO/lib/feature/dashboard/dashboard-employee/dashboardemployee-page.dart';
import 'package:signature/signature.dart';

class StatusEditPage extends StatefulWidget {
  //autofil edit reject customer form
  String userid;
  String username;
  int id;
  String custName;
  String brandName;
  String category;
  String distributionChannels;
  String channelSegmentation;
  String selectClass;
  String phoneNo;
  String companyStatus;
  String faxNo;
  String contactPerson;
  String emailAddress;
  String website;
  String npwp;
  String ktp;
  String currency;
  String priceGroup;
  String salesman;
  String salesOffice;
  String businessUnit;
  String siup;
  String sppkp;

  //autofil edit reject company address form
  int companyID;
  String companyName;
  String companyStreetName;
  String companyCity;
  String companyState;
  String companyCountry;
  String companyZipCode;
  int companyParentID;

  //autofil edit reject tax address form
  int taxID;
  String taxName;
  String taxStreetName;
  String taxCity;
  String taxState;
  String taxCountry;
  String taxZipCode;
  int taxParentID;

  //autofil edit reject delivery address form
  int deliveryID;
  String deliveryName;
  String deliveryStreetName;
  String deliveryCity;
  String deliveryState;
  String deliveryCountry;
  String deliveryZipCode;
  int deliveryParentID;

  String fotoktp;
  String fotonpwp;
  String fotonib;
  String fotosppkp;
  String fotofrontview;
  String fotoinsideview;
  String autoLongitudeData;
  String autoLatitudeData;
  String addressDetail;
  String streetName;
  String city;
  String countrys;
  String state;
  String zipCode;
  String so;
  String bu;
  String fotocustsignature;

  StatusEditPage({
    Key key,
    this.username,
    this.so,
    this.bu,
    this.userid,
    this.id,
    //customer form
    this.custName,
    this.brandName,
    this.category,
    this.distributionChannels,
    this.channelSegmentation,
    this.selectClass,
    this.phoneNo,
    this.companyStatus,
    this.faxNo,
    this.contactPerson,
    this.emailAddress,
    this.website,
    this.npwp,
    this.ktp,
    this.currency,
    this.priceGroup,
    this.salesman,
    this.salesOffice,
    this.businessUnit,
    this.sppkp,
    this.siup,
    this.fotocustsignature,

    //company address form
    this.companyID,
    this.companyName,
    this.companyStreetName,
    this.companyCity,
    this.companyState,
    this.companyCountry,
    this.companyZipCode,
    this.companyParentID,

    //tax address form
    this.taxID,
    this.taxName,
    this.taxStreetName,
    this.taxCity,
    this.taxState,
    this.taxCountry,
    this.taxZipCode,
    this.taxParentID,

    //delivery address form
    this.deliveryID,
    this.deliveryName,
    this.deliveryStreetName,
    this.deliveryCity,
    this.deliveryState,
    this.deliveryCountry,
    this.deliveryZipCode,
    this.autoLongitudeData,
    this.autoLatitudeData,
    this.deliveryParentID,
    //attachment
    this.fotoktp,
    this.fotonpwp,
    this.fotonib,
    this.fotosppkp,
    this.fotofrontview,
    this.fotoinsideview,

    //address and delivery form
    this.addressDetail,
    this.streetName,
    this.city,
    this.state,
    this.countrys,
    this.zipCode,
  }) : super(key: key);

  @override
  _StatusEditPageState createState() => _StatusEditPageState();
}

class _StatusEditPageState extends State<StatusEditPage> {
  final _formkey = GlobalKey<FormState>();

  //Customer Controller
  TextEditingController _customerNameControllerCustomer =
      TextEditingController();
  TextEditingController _brandNameControllerCustomer = TextEditingController();
  TextEditingController _phoneControllerCustomer = TextEditingController();
  TextEditingController _faxControllerCustomer = TextEditingController();
  TextEditingController _contactPersonControllerCustomer =
      TextEditingController();
  TextEditingController _emailAddressControllerCustomer =
      TextEditingController();
  TextEditingController _npwpControllerCustomer = TextEditingController();
  TextEditingController _siupControllerCustomer = TextEditingController();
  TextEditingController _sppkpControllerCustomer = TextEditingController();
  TextEditingController _ktpControllerCustomer = TextEditingController();
  TextEditingController _salesmanControllerCustomer = TextEditingController();
  TextEditingController _websiteControllerCustomer = TextEditingController();

  //Company Controller
  TextEditingController _nameControllerCompany = TextEditingController();
  TextEditingController _streetControllerCompany = TextEditingController();
  TextEditingController _cityControllerCompany = TextEditingController();
  TextEditingController _countryControllerCompany = TextEditingController();
  TextEditingController _stateControllerCompany = TextEditingController();
  TextEditingController _zipCodeControllerCompany = TextEditingController();

  //Tax Controller
  TextEditingController _nameControllerTax = TextEditingController();
  TextEditingController _streetControllerTax = TextEditingController();
  TextEditingController _cityControllerTax = TextEditingController();
  TextEditingController _countryControllerTax = TextEditingController();
  TextEditingController _stateControllerTax = TextEditingController();
  TextEditingController _zipCodeControllerTax = TextEditingController();

  //Delivery Controller
  TextEditingController _nameControllerDelivery = TextEditingController();
  TextEditingController _streetControllerDelivery = TextEditingController();
  TextEditingController _cityControllerDelivery = TextEditingController();
  TextEditingController _countryControllerDelivery = TextEditingController();
  TextEditingController _stateControllerDelivery = TextEditingController();
  TextEditingController _zipCodeControllerDelivery = TextEditingController();
  TextEditingController _longitudeControllerDelivery = TextEditingController();
  TextEditingController _latitudeControllerDelivery = TextEditingController();

  String longitudeData = "";
  String latitudeData = "";
  String addressDetail = "";
  String streetName = "";
  String city = "";
  String countrys = "";
  String state = "";
  String zipCode = "";
  String salesmanId = "";

  loadFromSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      streetName = (prefs.getString("getStreetName") ?? "");
      city = (prefs.getString("getCity") ?? "");
      countrys = (prefs.getString("getCountry") ?? "");
      state = (prefs.getString("getState") ?? "");
      zipCode = (prefs.getString("getZipCode") ?? "");
      longitudeData = (prefs.getString("getLongitude") ?? "");
      latitudeData = (prefs.getString("getLatitude") ?? "");
      addressDetail = (prefs.getString("getAddressDetail") ?? "");
      print("ini loadlonglat: $longitudeData");
      print("Ini addressDetail: $addressDetail");
      print("ini detail street: $streetName");
      print("ini detail city: $city");
      print("ini detail country: $countrys");
      print("ini detail state: $state");
      print("ini detail zipcode: $zipCode");
    });
  }

  var isImageCaptured = false;
  File _imageKTP;
  File _imageKTPDefault;
  File _imageNPWP;
  File _imageSIUP;
  File _imageBuilding;
  File _imageBusinessPhotoFront;
  File _imageBusinessPhotoInside;
  File _imageSPPKP;
  File _imageSignatureSales;
  Uint8List DataSignSales;
  Uint8List DataSignCustomer;
  var nows = DateTime.now();
  String ktpFromServer =
      "KTP_" + DateFormat("ddMMyyyy_hhmm").format(DateTime.now()) + "_.jpg";
  String npwpFromServer =
      "NPWP_" + DateFormat("ddMMyyyy_hhmm").format(DateTime.now()) + "_.jpg";
  String siupFromServer =
      "SIUP_" + DateFormat("ddMMyyyy_hhmm").format(DateTime.now()) + "_.jpg";
  String buildingFromServer = "BUILDING_" +
      DateFormat("ddMMyyyy_hhmm").format(DateTime.now()) +
      "_.jpg";
  String businessPhotoFrontFromServer = "BUSINESSPHOTOFRONT_" +
      DateFormat("ddMMyyyy_hhmm").format(DateTime.now()) +
      "_.jpg";
  String businessPhotoInsideFromServer = "BUSINESSPHOTOINSIDE_" +
      DateFormat("ddMMyyyy_hhmm").format(DateTime.now()) +
      "_.jpg";
  String sppkpFromServer =
      "SPPKP_" + DateFormat("ddMMyyyy_hhmm").format(DateTime.now()) + "_.jpg";
  String signatureSalesFromServer = "SIGNATURESALES_" +
      DateFormat("ddMMyyyy_hhmm").format(DateTime.now()) +
      "_.jpg";
  String signatureCustomerFromServer = "SIGNATURECUSTOMER_" +
      DateFormat("ddMMyyyy_hhmm").format(DateTime.now()) +
      "_.jpg";
  final picker = ImagePicker();
  bool locationVal = false;

  // getImageKTP From Camera
  Future getImageKTPFromCamera() async {
    final pickedFile =
        await picker.getImage(source: ImageSource.camera, imageQuality: 20);
    var nows = DateTime.now();
    String dateNow = DateFormat("ddMMyyyy_hhmm").format(nows);
    var renamedFile = await File(pickedFile.path).rename(
        '/storage/emulated/0/Android/data/id.prb.prb_app/files/Pictures/KTP_' +
            dateNow.toString() +
            "_" +
            ".jpg");
    setState(() {
      if (pickedFile != null) {
        _imageKTP = renamedFile;
      } else {
        print('No image selected.');
      }
    });
  }

  // getImageKTP From Galery
  Future getImageKTPFromGalery() async {
    final pickedFile =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 20);
    var nows = DateTime.now();
    String dateNow = DateFormat("ddMMyyyy_hhmm").format(nows);
    var renamedFile = await File(pickedFile.path).rename(
        '/storage/emulated/0/Android/data/id.prb.prb_app/files/Pictures/KTP_' +
            dateNow.toString() +
            "_" +
            ".jpg");
    setState(() {
      if (pickedFile != null) {
        _imageKTP = renamedFile;
      } else {
        print('No image selected.');
      }
    });
  }

  UploadKTP(File imageFile) async {
    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    var uri = Uri.parse(baseURL + "Upload");
    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile('file', stream, length,
        filename: basename(imageFile.path));
    //contentType: new MediaType('image', 'png'));
    request.files.add(multipartFile);
    var response = await request.send();
    print(response.statusCode);
    response.stream.transform(utf8.decoder).listen((value) {
      print("cb liat ini $value");
      ktpFromServer = value.replaceAll("\"", "");
    });
  }

  // getImageNPWP from camera
  Future getImageNPWPFromCamera() async {
    final pickedFile =
        await picker.getImage(source: ImageSource.camera, imageQuality: 20);
    var nows = DateTime.now();
    String dateNow = DateFormat("ddMMyyyy_hhmm").format(nows);
    var renamedFile = await File(pickedFile.path).rename(
        '/storage/emulated/0/Android/data/id.prb.prb_app/files/Pictures/NPWP_' +
            dateNow.toString() +
            "_" +
            ".jpg");
    setState(() {
      if (pickedFile != null) {
        _imageNPWP = renamedFile;
      } else {
        print('No image selected.');
      }
    });
  }

  // getImageNPWP from galery
  Future getImageNPWPFromGallery() async {
    final pickedFile =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 20);
    var nows = DateTime.now();
    String dateNow = DateFormat("ddMMyyyy_hhmm").format(nows);
    var renamedFile = await File(pickedFile.path).rename(
        '/storage/emulated/0/Android/data/id.prb.prb_app/files/Pictures/NPWP_' +
            dateNow.toString() +
            "_" +
            ".jpg");
    setState(() {
      if (pickedFile != null) {
        _imageNPWP = renamedFile;
      } else {
        print('No image selected.');
      }
    });
  }

  UploadNPWP(File imageFile) async {
    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    var uri = Uri.parse(baseURL + "Upload");
    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile('file', stream, length,
        filename: basename(imageFile.path));
    //contentType: new MediaType('image', 'png'));
    request.files.add(multipartFile);
    var response = await request.send();
    print(response.statusCode);
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
      npwpFromServer = value.replaceAll("\"", "");
    });
  }

  // getImageSIUP from camera
  Future getImageSIUPFromCamera() async {
    final pickedFile =
        await picker.getImage(source: ImageSource.camera, imageQuality: 20);
    var nows = DateTime.now();
    String dateNow = DateFormat("ddMMyyyy_hhmm").format(nows);
    var renamedFile = await File(pickedFile.path).rename(
        '/storage/emulated/0/Android/data/id.prb.prb_app/files/Pictures/SIUP_' +
            dateNow.toString() +
            "_" +
            ".jpg");
    setState(() {
      if (pickedFile != null) {
        _imageSIUP = renamedFile;
      } else {
        print('No image selected.');
      }
    });
  }

  // getImageSIUP from gallery
  Future getImageSIUPFromGallery() async {
    final pickedFile =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 20);
    var nows = DateTime.now();
    String dateNow = DateFormat("ddMMyyyy_hhmm").format(nows);
    var renamedFile = await File(pickedFile.path).rename(
        '/storage/emulated/0/Android/data/id.prb.prb_app/files/Pictures/SIUP_' +
            dateNow.toString() +
            "_" +
            ".jpg");
    setState(() {
      if (pickedFile != null) {
        _imageSIUP = renamedFile;
      } else {
        print('No image selected.');
      }
    });
  }

  UploadSIUP(File imageFile) async {
    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    var uri = Uri.parse(baseURL + "Upload");
    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile('file', stream, length,
        filename: basename(imageFile.path));
    //contentType: new MediaType('image', 'png'));
    request.files.add(multipartFile);
    var response = await request.send();
    print(response.statusCode);
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
      siupFromServer = value.replaceAll("\"", "");
    });
  }

  // getImageBusinessPhotoFront from camera
  Future getImageBusinessPhotoFrontFromCamera() async {
    final pickedFile =
        await picker.getImage(source: ImageSource.camera, imageQuality: 20);
    var nows = DateTime.now();
    String dateNow = DateFormat("ddMMyyyy_hhmm").format(nows);
    var renamedFile = await File(pickedFile.path).rename(
        '/storage/emulated/0/Android/data/id.prb.prb_app/files/Pictures/BUSINESSPHOTOFRONT_' +
            dateNow.toString() +
            '_' +
            '.jpg');
    setState(() {
      if (pickedFile != null) {
        _imageBusinessPhotoFront = renamedFile;
      } else {
        print('No image selected.');
      }
    });
  }

  // getImageBusinessPhotoFront from gallery
  Future getImageBusinessPhotoFrontFromGallery() async {
    final pickedFile =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 20);
    var nows = DateTime.now();
    String dateNow = DateFormat("ddMMyyyy_hhmm").format(nows);
    var renamedFile = await File(pickedFile.path).rename(
        '/storage/emulated/0/Android/data/id.prb.prb_app/files/Pictures/BUSINESSPHOTOFRONT_' +
            dateNow.toString() +
            '_' +
            '.jpg');
    setState(() {
      if (pickedFile != null) {
        _imageBusinessPhotoFront = renamedFile;
      } else {
        print('No image selected.');
      }
    });
  }

  // uploadBusinessPhotoFront
  UploadBusinessPhotoFront(File imageFile) async {
    var stream =
        // ignore: deprecated_member_use
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    var uri = Uri.parse(baseURL + "Upload");
    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile('file', stream, length,
        filename: basename(imageFile.path));
    //contentType: new MediaType('image', 'png'));
    request.files.add(multipartFile);
    var response = await request.send();
    print(response.statusCode);
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
      businessPhotoFrontFromServer = value.replaceAll("\"", "");
    });
  }

  // getImageBusinessPhotoInside from camera
  Future getImageBusinessPhotoInsideFromCamera() async {
    final pickedFile =
        await picker.getImage(source: ImageSource.camera, imageQuality: 20);
    var nows = DateTime.now();
    String dateNow = DateFormat("ddMMyyyy_hhmm").format(nows);
    var renamedFile = await File(pickedFile.path).rename(
        '/storage/emulated/0/Android/data/id.prb.prb_app/files/Pictures/BUSINESSPHOTOINSIDE_' +
            dateNow.toString() +
            '_' +
            '.jpg');
    setState(() {
      if (pickedFile != null) {
        _imageBusinessPhotoInside = renamedFile;
      } else {
        print('No image selected.');
      }
    });
  }

  // getImageBusinessPhotoInside from gallery
  Future getImageBusinessPhotoInsideFromGallery() async {
    final pickedFile =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 20);
    var nows = DateTime.now();
    String dateNow = DateFormat("ddMMyyyy_hhmm").format(nows);
    var renamedFile = await File(pickedFile.path).rename(
        '/storage/emulated/0/Android/data/id.prb.prb_app/files/Pictures/BUSINESSPHOTOINSIDE_' +
            dateNow.toString() +
            '_' +
            '.jpg');
    setState(() {
      if (pickedFile != null) {
        _imageBusinessPhotoInside = renamedFile;
      } else {
        print('No image selected.');
      }
    });
  }

  // uploadBusinessPhotoInside
  UploadBusinessPhotoInside(File imageFile) async {
    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    var uri = Uri.parse(baseURL + "Upload");
    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile('file', stream, length,
        filename: basename(imageFile.path));
    //contentType: new MediaType('image', 'png'));
    request.files.add(multipartFile);
    var response = await request.send();
    print(response.statusCode);
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
      businessPhotoInsideFromServer = value.replaceAll("\"", "");
    });
  }

  // getImageSPPKP from camera
  Future getImageSPPKP() async {
    final pickedFile =
        await picker.getImage(source: ImageSource.camera, imageQuality: 20);
    var nows = DateTime.now();
    String dateNow = DateFormat("ddMMyyyy_hhmm").format(nows);
    var renamedFile = await File(pickedFile.path).rename(
        '/storage/emulated/0/Android/data/id.prb.prb_app/files/Pictures/SPPKP_' +
            dateNow.toString() +
            '_' +
            '.jpg');
    setState(() {
      if (pickedFile != null) {
        _imageSPPKP = renamedFile;
      } else {
        print('No image selected.');
      }
    });
  }

  // getImageSPPKP from gallery
  Future getImageSPPKPFromGallery() async {
    final pickedFile =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 20);
    var nows = DateTime.now();
    String dateNow = DateFormat("ddMMyyyy_hhmm").format(nows);
    var renamedFile = await File(pickedFile.path).rename(
        '/storage/emulated/0/Android/data/id.prb.prb_app/files/Pictures/SPPKP_' +
            dateNow.toString() +
            '_' +
            '.jpg');
    setState(() {
      if (pickedFile != null) {
        _imageSPPKP = renamedFile;
      } else {
        print('No image selected.');
      }
    });
  }

  // uploadSPPKP
  UploadSPPKP(File imageFile) async {
    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    var uri = Uri.parse(baseURL + "Upload");
    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile('file', stream, length,
        filename: basename(imageFile.path));
    //contentType: new MediaType('image', 'png'));
    request.files.add(multipartFile);
    var response = await request.send();
    print(response.statusCode);
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
      sppkpFromServer = value.replaceAll("\"", "");
    });
  }

  UploadSignatureSales(imageFile, String namaFile) async {
    //var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    //var length = await imageFile.length();
    var uri = Uri.parse(baseURL + "Upload");
    var request = new http.MultipartRequest("POST", uri);
    //var multipartFile = new http.MultipartFile.fromBytes('file', imageFile,
    //filename: namaFile);
    //contentType: new MediaType('image', 'png'));
    request.files.add(
        http.MultipartFile.fromBytes('file', imageFile, filename: namaFile));
    var response = await request.send();
    print(response.statusCode);
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
      signatureSalesFromServer = value.replaceAll("\"", "");
    });
  }

  UploadSignatureCustomer(imageFile, String namaFile) async {
    var uri = Uri.parse(baseURL + "Upload");
    var request = new http.MultipartRequest("POST", uri);
    request.files.add(
        http.MultipartFile.fromBytes('file', imageFile, filename: namaFile));
    var response = await request.send();
    print(response.statusCode);
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
      signatureCustomerFromServer = value.replaceAll("\"", "");
    });
  }

  //hit api Category
  var urlGetCategory = baseURL + "CustCategory";
  String _valCategory;

  // ignore: deprecated_member_use
  List<dynamic> _dataCategory = List();

  void getCategory() async {
    String usernameAuth = 'test';
    String passwordAuth = 'test456';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$usernameAuth:$passwordAuth'));
    print(basicAuth);
    final response = await http.get(Uri.parse(urlGetCategory),
        headers: <String, String>{'authorization': basicAuth});
    var listData = jsonDecode(response.body);
    print(urlGetCategory);
    setState(() {
      _dataCategory = listData;
      if (!categoryContains(_valCategory)) {
        _valCategory = null;
      }
    });
    print("Data Category : $listData");
  }

  bool categoryContains(String category) {
    for (int i = 0; i < _dataCategory.length; i++) {
      if (category == _dataCategory[i]["MASTER_SETUP"]) return true;
    }
    return false;
  }

  //Hit API Dropdown Segmen dan SubSegment
  var urlGetSubSegment = baseURL + "CustSubSegment";
  String _valSegment, _valSubSegment;

  // ignore: deprecated_member_use
  List<dynamic> _dataSegment = List(), _dataSubSegment = List();

  void getSegment() async {
    String usernameAuth = 'test';
    String passwordAuth = 'test456';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$usernameAuth:$passwordAuth'));
    print(basicAuth);
    var urlGetSegment = baseURL + "CustSegment?bu=${widget.bu}";
    final response = await http.get(Uri.parse(urlGetSegment),
        headers: <String, String>{
          'authorization': basicAuth
        }); //untuk melakukan request ke webservice
    var listData = jsonDecode(response.body); //lalu kita decode hasil datanya
    print(urlGetSegment);
    setState(() {
      _dataSegment = listData; // dan kita set kedalam variable _dataProvince
      if (!segmenContains(_valSegment)) {
        _valSegment = null;
      }
    });
    print("Data Segment : $listData");
  }

  bool segmenContains(String segmen) {
    for (int i = 0; i < _dataSegment.length; i++) {
      if (segmen == _dataSegment[i]["SEGMENTID"]) return true;
    }
    return false;
  }

  void getSubSegment(String SelectedSegment) async {
    String usernameAuth = 'test';
    String passwordAuth = 'test456';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$usernameAuth:$passwordAuth'));
    print(basicAuth);
    final response = await http.get(Uri.parse(urlGetSubSegment),
        headers: <String, String>{'authorization': basicAuth});
    var listData = jsonDecode(response.body);
    print(SelectedSegment);
    setState(() {
      listData = listData
          .where((element) => element["SEGMENTID"] == SelectedSegment)
          .toList();
      _dataSubSegment = listData;
      print("test $_dataSubSegment");
      print("test $_dataSubSegment filter by $SelectedSegment");
      if (!subsegmenContains(_valSubSegment)) {
        _valSubSegment = null;
      }
    });
    print("Data SubSegment : $listData");
  }

  bool subsegmenContains(String subSegmen) {
    for (int i = 0; i < _dataSubSegment.length; i++) {
      if (subSegmen == _dataSubSegment[i]["SUBSEGMENTID"]) return true;
    }
    return false;
  }

  //hit api Class
  var urlGetClass = baseURL + "CustClass";
  String _valClass;
  bool _selectedClass = false;
  List<dynamic> _dataClass = List();

  void getClass() async {
    String usernameAuth = 'test';
    String passwordAuth = 'test456';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$usernameAuth:$passwordAuth'));
    print(basicAuth);
    final response = await http.get(Uri.parse(urlGetClass),
        headers: <String, String>{'authorization': basicAuth});
    var listData = jsonDecode(response.body);
    print(urlGetClass);
    setState(() {
      _dataClass = listData;
      if (!classContains(_valClass)) {
        _valClass = null;
      }
    });
    print("Data Class : $listData");
  }

  bool classContains(String classs) {
    for (int i = 0; i < _dataClass.length; i++) {
      if (classs == _dataClass[i]["CLASS"]) return true;
    }
    return false;
  }

  //hit api CompanyStatus
  var urlGetCompanyStatus = baseURL + "CustCompanyChain";
  String _valCompanyStatus;
  bool _selectedCompanyStatus = false;
  List<dynamic> _dataCompanyStatus = List();

  void getCompanyStatus() async {
    String usernameAuth = 'test';
    String passwordAuth = 'test456';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$usernameAuth:$passwordAuth'));
    print(basicAuth);
    final response = await http.get(Uri.parse(urlGetCompanyStatus),
        headers: <String, String>{'authorization': basicAuth});
    var listData = jsonDecode(response.body);
    print(urlGetCompanyStatus);
    setState(() {
      _dataCompanyStatus = listData;
      if (!companyContains(_valCompanyStatus)) {
        _valCompanyStatus = null;
      }
    });
    print("Data CompanyStatus : $listData");
  }

  bool companyContains(String company) {
    for (int i = 0; i < _dataCompanyStatus.length; i++) {
      if (company == _dataCompanyStatus[i]["CHAINID"]) return true;
    }
    return false;
  }

  //hit api PriceGroup
  String _valPriceGroup;

  // ignore: deprecated_member_use
  List<dynamic> _dataPriceGroup = List();

  void getPriceGroup() async {
    String usernameAuth = 'test';
    String passwordAuth = 'test456';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$usernameAuth:$passwordAuth'));
    print(basicAuth);
    var urlGetPriceGroup =
        baseURL + "CustPriceGroup?so=${widget.so}&bu=${widget.bu}";
    final response = await http.get(Uri.parse(urlGetPriceGroup),
        headers: <String, String>{'authorization': basicAuth});
    var listData = jsonDecode(response.body);
    print(urlGetPriceGroup);
    setState(() {
      _dataPriceGroup = listData;
      if (!pricegroupContains(_valPriceGroup)) {
        _valPriceGroup = null;
      }
    });
    print("Data CompanyStatus : $listData");
  }

  bool pricegroupContains(String pricegroup) {
    for (int i = 0; i < _dataPriceGroup.length; i++) {
      if (pricegroup == _dataPriceGroup[i]["NAME"]) return true;
    }
    return false;
  }

  //hit api Currency
  var urlGetCurrency = baseURL + "Currency";
  String _valCurrency;

  // ignore: deprecated_member_use
  List<dynamic> _dataCurrency = List();

  void getCurrency() async {
    String usernameAuth = 'test';
    String passwordAuth = 'test456';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$usernameAuth:$passwordAuth'));
    print(basicAuth);
    final response = await http.get(Uri.parse(urlGetCurrency),
        headers: <String, String>{'authorization': basicAuth});
    var listData = jsonDecode(response.body);
    print(urlGetCurrency);
    setState(() {
      _dataCurrency = listData;
      if (!currencyContains(_valCurrency)) {
        _valCurrency = null;
      }
    });
    print("Data Currency : $listData");
  }

  bool currencyContains(String currency) {
    for (int i = 0; i < _dataCurrency.length; i++) {
      if (currency == _dataCurrency[i]["CurrencyCode"]) return true;
    }
    return false;
  }

  //hit api Business Unit
  String _valBusinessUnit;

  // ignore: deprecated_member_use
  List<dynamic> _dataBusinessUnit = List();

  void getBusinessUnit() async {
    String usernameAuth = 'test';
    String passwordAuth = 'test456';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$usernameAuth:$passwordAuth'));
    print(basicAuth);
    var urlGetBusinessUnit = baseURL + "ViewBU?BU=${widget.bu}";
    final response = await http.get(Uri.parse(urlGetBusinessUnit),
        headers: <String, String>{'authorization': basicAuth});
    var listData = jsonDecode(response.body);
    print(urlGetBusinessUnit);
    setState(() {
      _dataBusinessUnit = listData;
      if (!businessUnitContains(_valBusinessUnit)) {
        _valBusinessUnit = null;
      }
    });
    print("Data BusinessUnit : $listData");
  }

  bool businessUnitContains(String businessunit) {
    for (int i = 0; i < _dataBusinessUnit.length; i++) {
      if (businessunit == _dataBusinessUnit[i]["NameBU"]) return true;
    }
    return false;
  }

  //hit api Sales Office
  String _valSalesOffice;

  // ignore: deprecated_member_use
  List<dynamic> _dataSalesOffice = List();

  void getSalesOffice() async {
    String usernameAuth = 'test';
    String passwordAuth = 'test456';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$usernameAuth:$passwordAuth'));
    print(basicAuth);
    var urlGetSalesOffice = baseURL + "ViewSO?SO=${widget.so}";
    final response = await http.get(Uri.parse(urlGetSalesOffice),
        headers: <String, String>{'authorization': basicAuth});
    var listData = jsonDecode(response.body);
    print(urlGetSalesOffice);
    setState(() {
      _dataSalesOffice = listData;
      if (!salesOfficeContains(_valSalesOffice)) {
        _valSalesOffice = null;
      }
    });
    print("Data SalesOffice : $listData");
  }

  bool salesOfficeContains(String salesoffice) {
    for (int i = 0; i < _dataSalesOffice.length; i++) {
      if (salesoffice == _dataSalesOffice[i]["NameSO"]) return true;
    }
    return false;
  }

  //SignatureController Sales
  final SignatureController _signaturecontrollersales = SignatureController(
    penStrokeWidth: 1,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  //SignatureController Customer
  final SignatureController _signaturecontrollercustomer = SignatureController(
    penStrokeWidth: 1,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
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

  String idUserFromLogin;
  int companyParentID;
  int taxParentID;
  int deliveryParentID;
  int companyID;
  int taxID;
  int deliveryID;


  //Proses di submit button
  processSubmitCustomerForm(
    //Customer
    String customerNameCustomer,
    String brandNameCustomer,
    String categoryCustomer,
    String segmenCustomer,
    String subSegmenCustomer,
    String selectClassCustomer,
    String phoneCustomer,
    String companyStatusCustomer,
    String faxCustomer,
    String contactPersonCustomer,
    String emailAddressCustomer,
    String npwpCustomer,
    String ktpCustomer,
    String siupCustomer,
    String sppkpCustomer,
    String currencyCustomer,
    String salesofficeCustomer,
    String pricegroupCustomer,
    String businessunitCustomer,
    String salesmanCustomer,
    String websiteCustomer,
    String longitudeCustomer,
    String latitudeCustomer,
    // bool buttonloc,
    // Position getLoc,

    //Company
    String nameCompany,
    String streetnameCompany,
    String cityCompany,
    String countryCompany,
    String stateCompany,
    String zipcodeCompany,

    //Tax
    String nameTax,
    String streetNameTax,
    String cityTax,
    String countryTax,
    String stateTax,
    String zipcodeTax,

    //Delivery
    String nameDelivery,
    String streetNameDelivery,
    String cityDelivery,
    String countryDelivery,
    String stateDelivery,
    String zipcodeDelivery,
  ) async {
    String usernameAuth = 'test';
    String passwordAuth = 'test456';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$usernameAuth:$passwordAuth'));
    print(basicAuth);
    var urlEditSubmitCustomerForm =
        baseURL + "NOOCustTables/" + widget.id.toString();
    print("Ini url Post Submit Customer : $urlEditSubmitCustomerForm");
    var jsonSubmitCustomerForm = await http.put(
        Uri.parse(
          urlEditSubmitCustomerForm,
        ),
        headers: <String, String>{
          'authorization': basicAuth,
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "id": widget.id,
          "CustName": "$customerNameCustomer",
          "BrandName": "$brandNameCustomer",
          "Category": "$categoryCustomer",
          "Segment": "$segmenCustomer",
          "SubSegment": "$subSegmenCustomer",
          "Class": "$selectClassCustomer",
          "PhoneNo": "$phoneCustomer",
          "CompanyStatus": "$companyStatusCustomer",
          "FaxNo": "$faxCustomer",
          "ContactPerson": "$contactPersonCustomer",
          "EmailAddress": "$emailAddressCustomer",
          "NPWP": "$npwpCustomer",
          "KTP": "$ktpCustomer",
          "SPPKP": "$sppkpCustomer",
          "SIUP": "$siupCustomer",
          "Currency": "$currencyCustomer",
          "SalesOffice": "$salesofficeCustomer",
          "PriceGroup": "$pricegroupCustomer",
          "BusinessUnit": "$businessunitCustomer",
          "Salesman": "$salesmanCustomer",
          "Notes": "Rachmat Notes",
          "Website": "$websiteCustomer",
          "FotoNPWP": "$npwpFromServer",
          "FotoKTP": "$ktpFromServer",
          "FotoSIUP": "$siupFromServer",
          // "FotoGedung": "$buildingFromServer",
          "CustSignature": "$signatureCustomerFromServer",
          "SalesSignature": "$signatureSalesFromServer",
          // "Long": " ${buttonloc == true ? longitudeData.toString() : 0}",
          "Long": " $longitudeCustomer",
          "Lat": "$latitudeCustomer",
          // "Lat": "${buttonloc == true ? latitudeData.toString() : 0}",
          "FotoGedung1": "$businessPhotoFrontFromServer",
          "FotoGedung2": "$businessPhotoInsideFromServer",
          "FotoGedung3": "$sppkpFromServer",
          "CreatedBy": "$idUserFromLogin",
          "CreatedDate": "2021-04-05T14:56:48.57",
          "TaxAddresses": [
            {
              "id": taxID,
              "Name": "$nameTax",
              "StreetName": "$streetNameTax",
              "City": "$cityTax",
              "Country": "$countryTax",
              "State": "$stateTax",
              "ZipCode": "$zipcodeTax",
              "ParentId": taxParentID,
            }
          ],
          "CompanyAddresses": [
            {
              "id": companyID,
              "Name": "$nameCompany",
              "StreetName": "$streetnameCompany",
              "City": "$cityCompany",
              "Country": "$countryCompany",
              "State": "$stateCompany",
              "ZipCode": "$zipcodeCompany",
              "ParentId": companyParentID,
            }
          ],
          "DeliveryAddresses": [
            {
              "id": deliveryID,
              "Name": "$nameDelivery",
              "StreetName": "$streetNameDelivery",
              "City": "$cityDelivery",
              "Country": "$countryDelivery",
              "State": "$stateDelivery",
              "ZipCode": "$zipcodeDelivery",
              "ParentId": deliveryParentID,
            }
          ]
        }));
    print(jsonSubmitCustomerForm.body.toString());
    if (jsonSubmitCustomerForm.statusCode == 200) {
      return jsonDecode(jsonSubmitCustomerForm.body);
    } else {
      print(jsonSubmitCustomerForm.statusCode);
      throw Exception("Failed");
    }
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    idUserFromLogin = widget.userid.toString();
    companyParentID = widget.companyParentID;
    taxParentID = widget.taxParentID;
    deliveryParentID = widget.deliveryParentID;
    print("savage1 : $companyParentID");
    print("savage2 : $taxParentID");
    print("savage3 : $deliveryParentID");
    print("UIw : $idUserFromLogin");
    print("Ahoy");
    companyID = widget.companyID;
    taxID = widget.taxID;
    deliveryID = widget.deliveryID;
    print("maniac1 : $companyID");
    print("maniac2 : $taxID");
    print("mamiac3 : $deliveryID");
    print("ini sales office dari detail: ${widget.so}");
    print("ini business unit dari detail: ${widget.bu}");
    getSegment();
    getCategory();
    getClass();
    getPriceGroup();
    getCompanyStatus();
    getCurrency();
    getBusinessUnit();
    getSalesOffice();
    _signaturecontrollersales.addListener(() => print('Value changed'));
    _signaturecontrollercustomer.addListener(() => print('Value changed'));
    loadFromSharedPrefs();
    print("uy ini foto: ${widget.fotoktp}");

    //autofill customer form
    _customerNameControllerCustomer.text = widget.custName;
    _brandNameControllerCustomer.text = widget.brandName;
    _valSalesOffice = widget.salesOffice.toString();
    _valBusinessUnit = widget.businessUnit;
    _valCategory = widget.category;
    _valSegment = widget.distributionChannels;
    _valSubSegment = widget.channelSegmentation;
    _valClass = widget.selectClass;
    _valCompanyStatus = widget.companyStatus;
    _valCurrency = widget.currency;
    _valPriceGroup = widget.priceGroup;
    _contactPersonControllerCustomer.text = widget.contactPerson;
    _ktpControllerCustomer.text = widget.ktp;
    _npwpControllerCustomer.text = widget.npwp;
    _siupControllerCustomer.text = widget.siup;
    _sppkpControllerCustomer.text = widget.sppkp;
    _salesmanControllerCustomer.text = widget.salesman;
    _phoneControllerCustomer.text = widget.phoneNo;
    _faxControllerCustomer.text = widget.faxNo;
    _emailAddressControllerCustomer.text = widget.emailAddress;
    _websiteControllerCustomer.text = widget.website;
    //autofill Company Address
    _nameControllerCompany.text = widget.companyName;
    _streetControllerCompany.text = widget.companyStreetName;
    _cityControllerCompany.text = widget.companyCity;
    _countryControllerCompany.text = widget.companyCountry;
    _stateControllerCompany.text = widget.companyState;
    _zipCodeControllerCompany.text = widget.companyZipCode;
    //autofill Tax Address
    _nameControllerTax.text = widget.taxName;
    _streetControllerTax.text = widget.taxStreetName;
    _cityControllerTax.text = widget.taxCity;
    _countryControllerTax.text = widget.taxCountry;
    _stateControllerTax.text = widget.taxState;
    _zipCodeControllerTax.text = widget.taxZipCode;
    //autofill Delivery Address
    _nameControllerDelivery.text = widget.deliveryName;
    _streetControllerDelivery.text = widget.deliveryStreetName;
    _cityControllerDelivery.text = widget.deliveryCity;
    _countryControllerDelivery.text = widget.deliveryCountry;
    _stateControllerDelivery.text = widget.deliveryState;
    _zipCodeControllerDelivery.text = widget.deliveryZipCode;
    _longitudeControllerDelivery.text = widget.autoLongitudeData;
    _latitudeControllerDelivery.text = widget.autoLatitudeData;
  }

  String text = 'Press To Load';
  bool status = false;

  @override
  Widget build(BuildContext context) {
    print("ini customer page");
    final focus = FocusNode();

    print("Inilah jalanya WB : $streetName");

    var ktpFormatter = new MaskTextInputFormatter(
        mask: '################', filter: {"#": RegExp(r'[0-9]')});
    var npwpFormatter = new MaskTextInputFormatter(
        mask: '##.###.###.#-###.###', filter: {"#": RegExp(r'[0-9]')});
    var phoneFormatter = new MaskTextInputFormatter(
        mask: '#### #### ####', filter: {"#": RegExp(r'[0-9]')});

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white60,
        title: Text(
          "Edit Form",
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
                "",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        scrollDirection: Axis.vertical,
        child: Form(
          key: _formkey,
          // autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            // shrinkWrap: true,
            // padding: EdgeInsets.all(15),
            children: <Widget>[
              Center(
                child: Text(
                  "Customer Form",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.blue,
                  ),
                ),
              ),

              SizedBox(
                height: 20,
              ),

              //Customer Name
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    child: Text(
                      "Customer Name :",
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                      child: Expanded(
                    child: TextFormField(
                      textCapitalization: TextCapitalization.words,
                      focusNode: focus,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Customer Name!!';
                        }
                        return null;
                      },
                      textAlign: TextAlign.center,
                      controller: _customerNameControllerCustomer,
                      keyboardType: TextInputType.text,
                      autofocus: false,
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: 'Customer Name',
                        filled: true,
                        contentPadding: EdgeInsets.all(5),
                      ),
                    ),
                  ))
                ],
              ),
              SizedBox(
                height: 10,
              ),

              //Brand Name
              Row(
                children: <Widget>[
                  Container(
                    child: Text(
                      "Brand Name        :",
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    child: Expanded(
                      child: TextFormField(
                        textCapitalization: TextCapitalization.words,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Brand Name';
                          }
                          return null;
                        },
                        textAlign: TextAlign.center,
                        controller: _brandNameControllerCustomer,
                        keyboardType: TextInputType.text,
                        autofocus: false,
                        decoration: InputDecoration(
                          isDense: true,
                          hintText: 'Brand Name',
                          filled: true,
                          contentPadding: EdgeInsets.all(5),
//                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),

              //Sales Office
              Row(
                children: <Widget>[
                  Container(
                    child: Text(
                      "Sales Office         :",
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  DropdownButton(
                    hint: Text("Select Sales Office"),
                    value: _valSalesOffice,
                    items: _dataSalesOffice.map((item) {
                      return DropdownMenuItem(
                        child: Text(item['NameSO'] ?? "loading.."),
                        value: item['NameSO'],
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _valSalesOffice = value;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),

              //Business Unit
              Row(
                children: <Widget>[
                  Container(
                    child: Text(
                      "Business Unit      :",
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  DropdownButton(
                    hint: Text("Select Business Unit"),
                    value: _valBusinessUnit,
                    items: _dataBusinessUnit.map((item) {
                      return DropdownMenuItem(
                        child: Text(item['NameBU'] ?? "loading.."),
                        value: item['NameBU'],
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _valBusinessUnit = value;
//                      this._salutationPriceGroup = value;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),

              //Category
              Row(
                children: <Widget>[
                  Container(
                    child: Text(
                      "Category              :",
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  DropdownButton(
                    hint: Text("Select Category"),
                    value: _valCategory,
                    items: _dataCategory.map((item) {
                      return DropdownMenuItem(
                        child: Text(item['MASTER_SETUP'] ?? "loading.."),
                        value: item['MASTER_SETUP'],
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _valCategory = value;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),

              //Segmen
              Row(
                children: <Widget>[
                  Container(
                    child: Text(
                      "Distribution\nChannels             :",
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  DropdownButton(
                    hint: Text("Select "),
                    value: _valSegment,
                    items: _dataSegment.map((item) {
                      return DropdownMenuItem(
                        child: Text(item['SEGMENTID'] ?? "loading.."),
                        value: item['SEGMENTID'],
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        print(value);
                        print("haloo cek ini $value");
                        _valSegment = value;
                        _valSubSegment = null;
                      });
                      var SelectedSegment = value;
                      getSubSegment(SelectedSegment);
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),

              //Sub Segmen
              Row(
                children: <Widget>[
                  Container(
                    child: Text(
                      "Channel\nSegmentation     :",
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  DropdownButton(
                    hint: Text("Select "),
                    value: _valSubSegment,
                    items: _dataSubSegment.map((item) {
                      return DropdownMenuItem(
                        child: Text("${item['SUBSEGMENTID'] ?? "loading.."}"),
                        value: item['SUBSEGMENTID'],
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        print(value);
                        _valSubSegment = value;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),

              //Class
              Row(
                children: <Widget>[
                  Container(
                    child: Text(
                      "Class                    :",
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  DropdownButton(
                    hint: Text("Select Class"),
                    value: _valClass,
                    items: _dataClass.map((item) {
                      return DropdownMenuItem(
                        child: Text(item['CLASS'] ?? "loading.."),
                        value: item['CLASS'],
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _valClass = value;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),

              //Company Status
              Row(
                children: <Widget>[
                  Container(
                    child: Text(
                      "Company\nStatus                   :",
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  DropdownButton(
                    hint: Text("Select Company Status"),
                    value: _valCompanyStatus,
                    items: _dataCompanyStatus.map((item) {
                      return DropdownMenuItem(
                        child: Text(item['CHAINID'] ?? "loading.."),
                        value: item['CHAINID'],
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _valCompanyStatus = value;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),

              //Currency
              Row(
                children: <Widget>[
                  Container(
                    child: Text(
                      "Currency              :",
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  DropdownButton(
                    hint: Text("Select Currency"),
                    value: _valCurrency,
                    items: _dataCurrency.map((item) {
                      return DropdownMenuItem(
                        child: Text(item['CurrencyCode'] ?? "loading.."),
                        value: item['CurrencyCode'],
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _valCurrency = value;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),

              //Price Group
              Row(
                children: <Widget>[
                  Container(
                    child: Text(
                      "Price Group         :",
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  DropdownButton(
                    hint: Text("Select PriceGroup"),
                    value: _valPriceGroup,
                    items: _dataPriceGroup.map((item) {
                      return DropdownMenuItem(
                        child: Text(item['NAME'] ?? "loading.."),
                        value: item['NAME'],
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _valPriceGroup = value;
//                      this._salutationPriceGroup = value;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),

              //Contact Person
              Row(
                children: <Widget>[
                  Container(
                    child: Text(
                      "Contact Person  :",
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    child: Expanded(
                      child: TextFormField(
                        textCapitalization: TextCapitalization.words,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Contact Person!!';
                          }
                          return null;
                        },
                        textAlign: TextAlign.center,
                        controller: _contactPersonControllerCustomer,
                        keyboardType: TextInputType.text,
                        autofocus: false,
                        decoration: InputDecoration(
                          isDense: true,
                          hintText: 'Contact Person',
                          filled: true,
                          contentPadding: EdgeInsets.all(5),
//                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),

              //KTP
              Row(
                children: <Widget>[
                  Container(
                    child: Text(
                      "KTP                      :",
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    child: Expanded(
                      child: TextFormField(
                        inputFormatters: [ktpFormatter],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter KTP!!';
                          }
                          if (!(value.length > 15) && value.isNotEmpty) {
                            return "KTP number less than 16 digits!!";
                          }
                          return null;
                        },
                        textAlign: TextAlign.center,
                        controller: _ktpControllerCustomer,
                        keyboardType: TextInputType.number,
                        autofocus: false,
                        decoration: InputDecoration(
                          isDense: true,
                          hintText: 'KTP',
                          filled: true,
                          contentPadding: EdgeInsets.all(5),
//                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),

              //NPWP
              Row(
                children: <Widget>[
                  Container(
                    child: Text(
                      "NPWP                  :",
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    child: Expanded(
                      child: TextFormField(
                        inputFormatters: [npwpFormatter],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter NPWP!!';
                          }
                          if (!(value.length > 15) && value.isNotEmpty) {
                            return "NPWP number less than 15 digits!!";
                          }
                          return null;
                        },
                        textAlign: TextAlign.center,
                        controller: _npwpControllerCustomer,
                        keyboardType: TextInputType.number,
                        autofocus: false,
                        decoration: InputDecoration(
                          isDense: true,
                          hintText: 'NPWP',
                          filled: true,
                          contentPadding: EdgeInsets.all(5),
//                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),

              //Phone
              Row(
                children: <Widget>[
                  Container(
                    child: Text(
                      "Phone                  :",
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    child: Expanded(
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Phone Number!!';
                          }
                          return null;
                        },
                        textAlign: TextAlign.center,
                        controller: _phoneControllerCustomer,
                        keyboardType: TextInputType.phone,
                        autofocus: false,
                        decoration: InputDecoration(
                          isDense: true,
                          hintText: 'Phone',
                          filled: true,
                          contentPadding: EdgeInsets.all(5),
//                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),

              //Fax
              Row(
                children: <Widget>[
                  Container(
                    child: Text(
                      "Fax                       :",
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    child: Expanded(
                      child: TextFormField(
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'Please enter FAX Number!!';
                        //   }
                        //   return null;
                        // },
                        textAlign: TextAlign.center,
                        controller: _faxControllerCustomer,
                        keyboardType: TextInputType.number,
                        autofocus: false,
                        decoration: InputDecoration(
                          isDense: true,
                          hintText: 'Fax',
                          filled: true,
                          contentPadding: EdgeInsets.all(5),
//                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),

              //Email Address
              Row(
                children: <Widget>[
                  Container(
                    child: Text(
                      "Email Address    :",
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    child: Expanded(
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Email Address!!';
                          }
                          return null;
                        },
                        textAlign: TextAlign.center,
                        controller: _emailAddressControllerCustomer,
                        keyboardType: TextInputType.emailAddress,
                        autofocus: false,
                        decoration: InputDecoration(
                          isDense: true,
                          hintText: 'Email Address',
                          filled: true,
                          contentPadding: EdgeInsets.all(5),
//                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),

              //Website
              Row(
                children: <Widget>[
                  Container(
                    child: Text(
                      "Website                :",
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    child: Expanded(
                      child: TextFormField(
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'Please enter Website!!';
                        //   }
                        //   return null;
                        // },
                        textAlign: TextAlign.center,
                        controller: _websiteControllerCustomer,
                        keyboardType: TextInputType.url,
                        autofocus: false,
                        decoration: InputDecoration(
                          isDense: true,
                          hintText: 'Website',
                          filled: true,
                          contentPadding: EdgeInsets.all(5),
//                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),

              //Salesman
              Row(
                children: <Widget>[
                  Container(
                    child: Text(
                      "Salesman             :",
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    child: Expanded(
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Salesman!!';
                          }
                          return null;
                        },
                        textCapitalization: TextCapitalization.words,
                        textAlign: TextAlign.center,
                        controller: _salesmanControllerCustomer,
                        keyboardType: TextInputType.text,
                        autofocus: false,
                        decoration: InputDecoration(
                          isDense: true,
                          hintText: 'Salesman',
                          filled: true,
                          contentPadding: EdgeInsets.all(5),
//                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Divider(
                color: Colors.black,
                height: 0,
                thickness: 1,
                indent: 10,
                endIndent: 10,
              ),

              SizedBox(
                height: 20,
              ),

              //Label Company Form
              Center(
                child: Text(
                  "Company Address",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.blue,
                  ),
                ),
              ),

              SizedBox(
                height: 20,
              ),

              //Company Widget
              Column(
                children: [
                  Row(
                    children: <Widget>[
                      Container(
                        child: Text(
                          "Name                    :",
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        child: Expanded(
                          child: TextFormField(
                            textCapitalization: TextCapitalization.words,
                            textAlign: TextAlign.center,
                            controller: _nameControllerCompany,
                            keyboardType: TextInputType.text,
                            autofocus: false,
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: 'Name',
                              filled: true,
                              contentPadding: EdgeInsets.all(5),
//                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  //Street Name
                  Row(
                    children: <Widget>[
                      Container(
                        child: Text(
                          "Street Name        :",
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        child: Expanded(
                          child: TextFormField(
                            // validator: (value) {
                            //   if (value == null || value.isEmpty) {
                            //     return 'Please enter Company Street Name!!';
                            //   }
                            //   return null;
                            // },
                            textAlign: TextAlign.center,
                            controller: _streetControllerCompany,
                            keyboardType: TextInputType.text,
                            autofocus: false,
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: 'Street Name',
                              filled: true,
                              contentPadding: EdgeInsets.all(5),
//                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  //City
                  Row(
                    children: <Widget>[
                      Container(
                        child: Text(
                          "City                       :",
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        child: Expanded(
                          child: TextFormField(
                            // validator: (value) {
                            //   if (value == null || value.isEmpty) {
                            //     return 'Please enter Company City!!';
                            //   }
                            //   return null;
                            // },
                            textCapitalization: TextCapitalization.words,
                            textAlign: TextAlign.center,
                            controller: _cityControllerCompany,
                            keyboardType: TextInputType.text,
                            autofocus: false,
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: 'City',
                              filled: true,
                              contentPadding: EdgeInsets.all(5),
//                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  //State
                  Row(
                    children: <Widget>[
                      Container(
                        child: Text(
                          "State                    :",
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        child: Expanded(
                          child: TextFormField(
                            // validator: (value) {
                            //   if (value == null || value.isEmpty) {
                            //     return 'Please enter Company State!!';
                            //   }
                            //   return null;
                            // },
                            textCapitalization: TextCapitalization.words,
                            textAlign: TextAlign.center,
                            controller: _stateControllerCompany,
                            keyboardType: TextInputType.text,
                            autofocus: false,
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: 'State',
                              filled: true,
                              contentPadding: EdgeInsets.all(5),
//                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  //Country
                  Row(
                    children: <Widget>[
                      Container(
                        child: Text(
                          "Country                :",
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        child: Expanded(
                          child: TextFormField(
                            // validator: (value) {
                            //   if (value == null || value.isEmpty) {
                            //     return 'Please enter Company Country!!';
                            //   }
                            //   return null;
                            // },
                            textCapitalization: TextCapitalization.words,
                            textAlign: TextAlign.center,
                            controller: _countryControllerCompany,
                            keyboardType: TextInputType.text,
                            autofocus: false,
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: 'Country',
                              filled: true,
                              contentPadding: EdgeInsets.all(5),
//                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  //ZIP Code
                  Row(
                    children: <Widget>[
                      Container(
                        child: Text(
                          "ZIP Code              :",
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        child: Expanded(
                          child: TextFormField(
                            // validator: (value) {
                            //   if (value == null || value.isEmpty) {
                            //     return 'Please enter Company ZIP Code!!';
                            //   }
                            //   return null;
                            // },
                            textAlign: TextAlign.center,
                            controller: _zipCodeControllerCompany,
                            keyboardType: TextInputType.number,
                            autofocus: false,
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: 'ZIP Code',
                              filled: true,
                              contentPadding: EdgeInsets.all(5),
//                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),

              SizedBox(
                height: 20,
              ),

              Divider(
                color: Colors.black,
                height: 0,
                thickness: 1,
                indent: 10,
                endIndent: 10,
              ),

              SizedBox(
                height: 20,
              ),

              //Label Tax Form
              Center(
                child: Text(
                  "TAX Address",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.blue,
                  ),
                ),
              ),

              SizedBox(
                height: 20,
              ),

              //Tax Widget
              Column(
                children: [
                  //Name
                  Row(
                    children: <Widget>[
                      Container(
                        child: Text(
                          "Name                    :",
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        child: Expanded(
                          child: TextFormField(
                            // validator: (value) {
                            //   if (value == null || value.isEmpty) {
                            //     return 'Please enter TAX Name!!';
                            //   }
                            //   return null;
                            // },
                            textCapitalization: TextCapitalization.words,
                            textAlign: TextAlign.center,
                            controller: _nameControllerTax,
                            keyboardType: TextInputType.text,
                            autofocus: false,
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: 'Name',
                              filled: true,
                              contentPadding: EdgeInsets.all(5),
//                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  //Street Name
                  Row(
                    children: <Widget>[
                      Container(
                        child: Text(
                          "Street Name        :",
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        child: Expanded(
                          child: TextFormField(
                            textCapitalization: TextCapitalization.words,
                            textAlign: TextAlign.center,
                            controller: _streetControllerTax,
                            keyboardType: TextInputType.text,
                            autofocus: false,
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: 'Street Name',
                              filled: true,
                              contentPadding: EdgeInsets.all(5),
//                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  //City
                  Row(
                    children: <Widget>[
                      Container(
                        child: Text(
                          "City                       :",
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        child: Expanded(
                          child: TextFormField(
                            // validator: (value) {
                            //   if (value == null || value.isEmpty) {
                            //     return 'Please enter TAX City!!';
                            //   }
                            //   return null;
                            // },
                            textCapitalization: TextCapitalization.words,
                            textAlign: TextAlign.center,
                            controller: _cityControllerTax,
                            keyboardType: TextInputType.text,
                            autofocus: false,
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: 'City',
                              filled: true,
                              contentPadding: EdgeInsets.all(5),
//                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  //State
                  Row(
                    children: <Widget>[
                      Container(
                        child: Text(
                          "State                     :",
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        child: Expanded(
                          child: TextFormField(
                            // validator: (value) {
                            //   if (value == null || value.isEmpty) {
                            //     return 'Please enter State!!';
                            //   }
                            //   return null;
                            // },
                            textCapitalization: TextCapitalization.words,
                            textAlign: TextAlign.center,
                            controller: _stateControllerTax,
                            keyboardType: TextInputType.text,
                            autofocus: false,
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: 'State',
                              filled: true,
                              contentPadding: EdgeInsets.all(5),
//                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  //Country
                  Row(
                    children: <Widget>[
                      Container(
                        child: Text(
                          "Country                :",
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        child: Expanded(
                          child: TextFormField(
                            // validator: (value) {
                            //   if (value == null || value.isEmpty) {
                            //     return 'Please enter TAX Country!!';
                            //   }
                            //   return null;
                            // },
                            textCapitalization: TextCapitalization.words,
                            textAlign: TextAlign.center,
                            controller: _countryControllerTax,
                            keyboardType: TextInputType.text,
                            autofocus: false,
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: 'Country',
                              filled: true,
                              contentPadding: EdgeInsets.all(5),
//                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  //ZIP Code
                  Row(
                    children: <Widget>[
                      Container(
                        child: Text(
                          "ZIP Code              :",
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        child: Expanded(
                          child: TextFormField(
                            // validator: (value) {
                            //   if (value == null || value.isEmpty) {
                            //     return 'Please enter TAX ZIP Code!!';
                            //   }
                            //   return null;
                            // },
                            textAlign: TextAlign.center,
                            controller: _zipCodeControllerTax,
                            keyboardType: TextInputType.number,
                            autofocus: false,
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: 'ZIP Code',
                              filled: true,
                              contentPadding: EdgeInsets.all(5),
//                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),

              SizedBox(
                height: 20,
              ),

              Divider(
                color: Colors.black,
                height: 0,
                thickness: 1,
                indent: 10,
                endIndent: 10,
              ),

              SizedBox(
                height: 20,
              ),

              //Label Delivery Form
              Center(
                child: Text(
                  "Delivery Address",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.blue,
                  ),
                ),
              ),

              SizedBox(
                height: 20,
              ),

              //Delivery Widget
              Column(
                children: [
                  //Name
                  Row(
                    children: <Widget>[
                      Container(
                        child: Text(
                          "Name                    :",
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        child: Expanded(
                          child: TextFormField(
                            // validator: (value) {
                            //   if (value == null || value.isEmpty) {
                            //     return 'Please enter Delivery Name!!';
                            //   }
                            //   return null;
                            // },
                            textCapitalization: TextCapitalization.words,
                            textAlign: TextAlign.center,
                            controller: _nameControllerDelivery,
                            keyboardType: TextInputType.text,
                            autofocus: false,
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: 'Name',
                              filled: true,
                              contentPadding: EdgeInsets.all(5),
//                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  //Street Name
                  Row(
                    children: <Widget>[
                      Container(
                        child: Text(
                          "Street Name        :",
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        child: Expanded(
                          child: TextFormField(
                            textCapitalization: TextCapitalization.words,
                            textAlign: TextAlign.center,
                            controller: _streetControllerDelivery,
                            keyboardType: TextInputType.text,
                            autofocus: false,
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: 'Street Name',
                              filled: true,
                              contentPadding: EdgeInsets.all(5),
//                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  //City
                  Row(
                    children: <Widget>[
                      Container(
                        child: Text(
                          "City                       :",
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        child: Expanded(
                          child: TextFormField(
                            // validator: (value) {
                            //   if (value == null || value.isEmpty) {
                            //     return 'Please enter Delivery City!!';
                            //   }
                            //   return null;
                            // },
                            textAlign: TextAlign.center,
                            controller: _cityControllerDelivery,
                            keyboardType: TextInputType.text,
                            autofocus: false,
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: 'City',
                              filled: true,
                              contentPadding: EdgeInsets.all(5),
//                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  //State
                  Row(
                    children: <Widget>[
                      Container(
                        child: Text(
                          "State                     :",
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        child: Expanded(
                          child: TextFormField(
                            // validator: (value) {
                            //   if (value == null || value.isEmpty) {
                            //     return 'Please enter Delivery State!!';
                            //   }
                            //   return null;
                            // },
                            textCapitalization: TextCapitalization.words,
                            textAlign: TextAlign.center,
                            controller: _stateControllerDelivery,
                            keyboardType: TextInputType.text,
                            autofocus: false,
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: 'State',
                              filled: true,
                              contentPadding: EdgeInsets.all(5),
//                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  //Country
                  Row(
                    children: <Widget>[
                      Container(
                        child: Text(
                          "Country                :",
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        child: Expanded(
                          child: TextFormField(
                            // validator: (value) {
                            //   if (value == null || value.isEmpty) {
                            //     return 'Please enter Delivery Country!!';
                            //   }
                            //   return null;
                            // },
                            textCapitalization: TextCapitalization.words,
                            textAlign: TextAlign.center,
                            controller: _countryControllerDelivery,
                            keyboardType: TextInputType.text,
                            autofocus: false,
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: 'Country',
                              filled: true,
                              contentPadding: EdgeInsets.all(5),
//                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  //ZIP Code
                  Row(
                    children: <Widget>[
                      Container(
                        child: Text(
                          "ZIP Code              :",
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        child: Expanded(
                          child: TextFormField(
                            // validator: (value) {
                            //   if (value == null || value.isEmpty) {
                            //     return 'Please enter Delivery ZIP Code!!';
                            //   }
                            //   return null;
                            // },
                            textAlign: TextAlign.center,
                            controller: _zipCodeControllerDelivery,
                            keyboardType: TextInputType.number,
                            autofocus: false,
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: 'ZIP Code',
                              filled: true,
                              contentPadding: EdgeInsets.all(5),
//                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),

              SizedBox(
                height: 20,
              ),

              //Longlat label
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text("Longitude"),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: 150,
                        child: TextFormField(
                          controller: _longitudeControllerDelivery,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    children: [
                      Text("Latitude"),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: 150,
                        child: TextFormField(
                          controller: _latitudeControllerDelivery,
                        ),
                      )
                    ],
                  ),
                ],
              ),

              SizedBox(
                height: 20,
              ),

              //Location label
              Row(
                children: <Widget>[
                  Container(
                    child: Text(
                      "Your Current\nLocation               :   ",
                    ),
                  ),
                  FlipCard(
                    front: Card(
                      child: Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Text(
                                  "Longitude : $longitudeData",
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Text(
                                  "Latitude : $latitudeData",
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    back: Card(
                      child: Container(
                        width: 199,
                        height: 100,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AutoSizeText(
                            addressDetail,
                            maxLines: 10,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Container(
                  //   height: 25,
                  //   width: 65,
                  //   child: CustomSwitch(
                  //     activeColor: Colors.green,
                  //     value: locationVal,
                  //     onChanged: (value){
                  //       print("VALUE : $value");
                  //       setState(() {
                  //         locationVal = true;
                  //         _determinePosition();
                  //         print(locationVal);
                  //         print(value);
                  //
                  //       });
                  //     },
                  //   ),
                  // ),
                  Text("")
                ],
              ),
              SizedBox(
                height: 10,
              ),

              SizedBox(
                height: 10,
              ),

              SizedBox(
                height: 20,
              ),

              //Attachment label
              Row(
                children: <Widget>[
                  Container(
                    child: Text(
                      "Attachment          :",
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),

              //ScrollHorizontal ListView Upload KTP Alt dan Attachment Lainya
              Container(
                height: 120, //Mengubah ukuran tinggi upload ktp
//              width: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    //Upload KTP
                    FlipCard(
                      front: Card(
                        child: Container(
                          height: 200,
                          width: 150,
                          child: ListView(
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Center(
                                      child: _imageKTP == null
                                          ? Column(
                                              children: [
                                                Text("KTP"),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Image.network(
                                                  baseURL +
                                                      "Files/GetFiles?fileName=${widget.fotoktp}",
                                                  filterQuality:
                                                      FilterQuality.low,
                                                  cacheHeight: 200,
                                                  cacheWidth: 150,
                                                ),
                                              ],
                                            )
                                          : Column(
                                              children: [
                                                Text("KTP"),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Image.file(
                                                  _imageKTP,
                                                  filterQuality:
                                                      FilterQuality.medium,
                                                  cacheHeight: 200,
                                                  cacheWidth: 150,
                                                  fit: BoxFit.cover,
                                                )
                                              ],
                                            )),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                              FloatingActionButton(
                                onPressed: getImageKTPFromCamera,
                                // isImageCaptured = true;
                                tooltip: 'Pick Image',
                                child: Icon(Icons.add_a_photo),
                              ),
                            ],
                          ),
                        ),
                      ),
                      back: Card(
                        child: Container(
                          height: 200,
                          width: 150,
                          child: ListView(
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Center(
                                    child: _imageKTP == null
                                        ? Column(
                                            children: [
                                              Text("KTP"),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Image.network(
                                                baseURL +
                                                    "Files/GetFiles?fileName=${widget.fotoktp}",
                                                filterQuality:
                                                    FilterQuality.medium,
                                                cacheHeight: 200,
                                                cacheWidth: 150,
                                              ),
                                            ],
                                          )
                                        : Column(
                                            children: [
                                              Text("KTP"),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Image.file(
                                                _imageKTP,
                                                filterQuality:
                                                    FilterQuality.medium,
                                                cacheHeight: 200,
                                                cacheWidth: 150,
                                                fit: BoxFit.cover,
                                              )
                                            ],
                                          ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                              FloatingActionButton(
                                onPressed: getImageKTPFromGalery,
                                tooltip: 'Pick Image',
                                child: Icon(Icons.photo_album),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),

                    //Upload NPWP
                    FlipCard(
                      front: Card(
                        child: Container(
                          height: 200,
                          width: 150,
                          child: ListView(
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Center(
                                    child: _imageNPWP == null
                                        ? Column(
                                            children: [
                                              Text("NPWP"),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Image.network(
                                                baseURL +
                                                    "Files/GetFiles?fileName=${widget.fotonpwp}",
                                                filterQuality:
                                                    FilterQuality.medium,
                                                cacheHeight: 200,
                                                cacheWidth: 150,
                                              ),
                                            ],
                                          )
                                        : Column(children: [
                                            Text("NPWP"),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Image.file(
                                              _imageNPWP,
                                              filterQuality:
                                                  FilterQuality.medium,
                                              cacheHeight: 200,
                                              cacheWidth: 150,
                                              fit: BoxFit.cover,
                                            )
                                          ]),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                              FloatingActionButton(
                                onPressed: getImageNPWPFromCamera,
                                tooltip: 'Pick Image',
                                child: Icon(Icons.add_a_photo),
                              ),
                            ],
                          ),
                        ),
                      ),
                      back: Card(
                        child: Container(
                          height: 200,
                          width: 150,
                          child: ListView(
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Center(
                                    child: _imageNPWP == null
                                        ? Column(
                                            children: [
                                              Text("NPWP"),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Image.network(
                                                baseURL +
                                                    "Files/GetFiles?fileName=${widget.fotonpwp}",
                                                filterQuality:
                                                    FilterQuality.medium,
                                                cacheHeight: 200,
                                                cacheWidth: 150,
                                              ),
                                            ],
                                          )
                                        : Column(
                                            children: [
                                              Text("NPWP"),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Image.file(
                                                _imageNPWP,
                                                filterQuality:
                                                    FilterQuality.medium,
                                                cacheHeight: 200,
                                                cacheWidth: 150,
                                                fit: BoxFit.cover,
                                              )
                                            ],
                                          ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                              FloatingActionButton(
                                onPressed: getImageNPWPFromGallery,
                                tooltip: 'Pick Image',
                                child: Icon(Icons.photo_album),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),

                    //Upload SIUP
                    FlipCard(
                      front: Card(
                        child: Container(
                          height: 200,
                          width: 150,
                          child: ListView(
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Center(
                                    child: _imageSIUP == null
                                        ? Column(
                                            children: [
                                              Text("NIB"),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Image.network(
                                                baseURL +
                                                    "Files/GetFiles?fileName=${widget.fotonib}",
                                                filterQuality:
                                                    FilterQuality.medium,
                                                cacheHeight: 200,
                                                cacheWidth: 150,
                                              ),
                                            ],
                                          )
                                        : Column(
                                            children: [
                                              Text("NIB"),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Image.file(
                                                _imageSIUP,
                                                filterQuality:
                                                    FilterQuality.medium,
                                                cacheHeight: 200,
                                                cacheWidth: 150,
                                                fit: BoxFit.cover,
                                              )
                                            ],
                                          ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                              FloatingActionButton(
                                onPressed: getImageSIUPFromCamera,
                                tooltip: 'Pick Image',
                                child: Icon(Icons.add_a_photo),
                              ),
                            ],
                          ),
                        ),
                      ),
                      back: Card(
                        child: Container(
                          height: 200,
                          width: 150,
                          child: ListView(
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Center(
                                    child: _imageSIUP == null
                                        ? Column(
                                            children: [
                                              Text("NIB"),
                                              SizedBox(height: 10),
                                              Image.network(
                                                baseURL +
                                                    "Files/GetFiles?fileName=${widget.fotonib}",
                                                filterQuality:
                                                    FilterQuality.medium,
                                                cacheHeight: 200,
                                                cacheWidth: 150,
                                              ),
                                            ],
                                          )
                                        : Column(
                                            children: [
                                              Text("NIB"),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Image.file(
                                                _imageSIUP,
                                                filterQuality:
                                                    FilterQuality.medium,
                                                cacheHeight: 200,
                                                cacheWidth: 150,
                                                fit: BoxFit.cover,
                                              )
                                            ],
                                          ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                              FloatingActionButton(
                                onPressed: getImageSIUPFromGallery,
                                tooltip: 'Pick Image',
                                child: Icon(Icons.photo_album),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      width: 5,
                    ),

                    //Upload SPPKP
                    FlipCard(
                      front: Card(
                        child: Container(
                          height: 200,
                          width: 150,
                          child: ListView(
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Center(
                                    child: _imageSPPKP == null
                                        ? Column(
                                            children: [
                                              Text(" SPPKP"),
                                              SizedBox(height: 10),
                                              Image.network(
                                                baseURL +
                                                    "Files/GetFiles?fileName=${widget.fotosppkp}",
                                                filterQuality:
                                                    FilterQuality.medium,
                                                cacheHeight: 200,
                                                cacheWidth: 150,
                                              ),
                                            ],
                                          )
                                        : Column(
                                            children: [
                                              Text("SPPKP"),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Image.file(
                                                _imageSPPKP,
                                                filterQuality:
                                                    FilterQuality.medium,
                                                cacheHeight: 200,
                                                cacheWidth: 150,
                                                fit: BoxFit.cover,
                                              )
                                            ],
                                          ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                              FloatingActionButton(
                                onPressed: getImageSPPKP,
                                tooltip: 'Pick Image',
                                child: Icon(Icons.add_a_photo),
                              ),
                            ],
                          ),
                        ),
                      ),
                      back: Card(
                        child: Container(
                          height: 200,
                          width: 150,
                          child: ListView(
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Center(
                                    child: _imageSPPKP == null
                                        ? Column(
                                            children: [
                                              Text("SPPKP"),
                                              SizedBox(height: 10),
                                              Image.network(
                                                baseURL +
                                                    "Files/GetFiles?fileName=${widget.fotosppkp}",
                                                filterQuality:
                                                    FilterQuality.medium,
                                                cacheHeight: 200,
                                                cacheWidth: 150,
                                              ),
                                            ],
                                          )
                                        : Column(
                                            children: [
                                              Text("SPPKP"),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Image.file(
                                                _imageSPPKP,
                                                filterQuality:
                                                    FilterQuality.medium,
                                                cacheHeight: 200,
                                                cacheWidth: 150,
                                                fit: BoxFit.cover,
                                              )
                                            ],
                                          ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                              FloatingActionButton(
                                onPressed: getImageSPPKPFromGallery,
                                tooltip: 'Pick Image',
                                child: Icon(Icons.photo_album),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      width: 5,
                    ),

                    //Upload Business photo front
                    FlipCard(
                      front: Card(
                        child: Container(
                          height: 200,
                          width: 150,
                          child: ListView(
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Center(
                                    child: _imageBusinessPhotoFront == null
                                        ? Column(
                                            children: [
                                              Text("Front View"),
                                              SizedBox(height: 10),
                                              Image.network(
                                                baseURL +
                                                    "Files/GetFiles?fileName=${widget.fotofrontview}",
                                                filterQuality:
                                                    FilterQuality.medium,
                                                cacheHeight: 200,
                                                cacheWidth: 150,
                                              ),
                                            ],
                                          )
                                        : Column(
                                            children: [
                                              Text("Front View"),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Image.file(
                                                _imageBusinessPhotoFront,
                                                filterQuality:
                                                    FilterQuality.medium,
                                                cacheHeight: 200,
                                                cacheWidth: 150,
                                                fit: BoxFit.cover,
                                              )
                                            ],
                                          ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                              FloatingActionButton(
                                onPressed: getImageBusinessPhotoFrontFromCamera,
                                tooltip: 'Pick Image',
                                child: Icon(Icons.add_a_photo),
                              ),
                            ],
                          ),
                        ),
                      ),
                      back: Card(
                        child: Container(
                          height: 200,
                          width: 150,
                          child: ListView(
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Center(
                                    child: _imageBusinessPhotoFront == null
                                        ? Column(
                                            children: [
                                              Text("Front View"),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Image.network(
                                                baseURL +
                                                    "Files/GetFiles?fileName=${widget.fotofrontview}",
                                                filterQuality:
                                                    FilterQuality.medium,
                                                cacheHeight: 200,
                                                cacheWidth: 150,
                                              ),
                                            ],
                                          )
                                        : Column(
                                            children: [
                                              Text("Front View"),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Image.file(
                                                _imageBusinessPhotoFront,
                                                filterQuality:
                                                    FilterQuality.medium,
                                                cacheHeight: 200,
                                                cacheWidth: 150,
                                                fit: BoxFit.cover,
                                              )
                                            ],
                                          ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                              FloatingActionButton(
                                onPressed:
                                    getImageBusinessPhotoFrontFromGallery,
                                tooltip: 'Pick Image',
                                child: Icon(Icons.photo_album),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      width: 5,
                    ),

                    //Upload Business photo inside
                    FlipCard(
                      front: Card(
                        child: Container(
                          height: 200,
                          width: 150,
                          child: ListView(
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Center(
                                    child: _imageBusinessPhotoInside == null
                                        ? Column(
                                            children: [
                                              Text("Inside View"),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Image.network(
                                                baseURL +
                                                    "Files/GetFiles?fileName=${widget.fotoinsideview}",
                                                filterQuality:
                                                    FilterQuality.medium,
                                                cacheHeight: 200,
                                                cacheWidth: 150,
                                              ),
                                            ],
                                          )
                                        : Column(
                                            children: [
                                              Text("Inside View"),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Image.file(
                                                _imageBusinessPhotoInside,
                                                filterQuality:
                                                    FilterQuality.medium,
                                                cacheHeight: 200,
                                                cacheWidth: 150,
                                                fit: BoxFit.cover,
                                              )
                                            ],
                                          ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                              FloatingActionButton(
                                onPressed:
                                    getImageBusinessPhotoInsideFromCamera,
                                tooltip: 'Pick Image',
                                child: Icon(Icons.add_a_photo),
                              ),
                            ],
                          ),
                        ),
                      ),
                      back: Card(
                        child: Container(
                          height: 200,
                          width: 150,
                          child: ListView(
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Center(
                                    child: _imageBusinessPhotoInside == null
                                        ? Column(
                                            children: [
                                              Text("Inside View"),
                                              SizedBox(height: 10),
                                              Image.network(
                                                baseURL +
                                                    "Files/GetFiles?fileName=${widget.fotoinsideview}",
                                                filterQuality:
                                                    FilterQuality.medium,
                                                cacheHeight: 200,
                                                cacheWidth: 150,
                                              ),
                                            ],
                                          )
                                        : Column(
                                            children: [
                                              Text("Inside View"),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Image.file(
                                                _imageBusinessPhotoInside,
                                                filterQuality:
                                                    FilterQuality.medium,
                                                cacheHeight: 200,
                                                cacheWidth: 150,
                                                fit: BoxFit.cover,
                                              )
                                            ],
                                          ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                              FloatingActionButton(
                                onPressed:
                                    getImageBusinessPhotoInsideFromGallery,
                                tooltip: 'Pick Image',
                                child: Icon(Icons.photo_album),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 20,
              ),

              //Label Signature Form
              Center(
                child: Text(
                  "Signature Form",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.blue,
                  ),
                ),
              ),

              SizedBox(
                height: 20,
              ),

              //FlipCard
              Card(
                color: Colors.grey,
                child: Container(
                  width: 350,
                  child: FlipCard(
                    direction: FlipDirection.HORIZONTAL,
                    speed: 1000,
                    onFlipDone: (status) {
                      print(status);
                    },
                    front: Container(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Sales",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Card(
                            child: Signature(
                              controller: _signaturecontrollersales,
                              height: 300,
                              backgroundColor: Colors.white,
                            ),
                          ),
                          //Oke dan button clear
                          Container(
                            decoration: const BoxDecoration(
                              color: Colors.black,
                            ),
                            child: Container(
                              width: 355,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  //Clear Canvass
                                  // ignore: deprecated_member_use
                                  RaisedButton(
                                    color: Colors.blue,
                                    child: Text(
                                      "Clear",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    onPressed: () {
                                      setState(() =>
                                          _signaturecontrollersales.clear());
                                    },
                                    // child: IconButton(
                                    //     icon: const Icon(
                                    //       Icons.clear,
                                    //       color: Colors.blue,
                                    //     ),
                                    //     onPressed: () {
                                    //       setState(() =>
                                    //           _signaturecontrollersales.clear());
                                    //     }),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    back: Container(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Customer",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Card(
                            child: Container(
                              height: 300,
                              child: Image.network(
                                baseURL +
                                    "Files/GetFiles?fileName=${widget.fotocustsignature}",
                                filterQuality: FilterQuality.medium,
                              ),
                            ),
                          ),
                          //Oke dan button clear
                          Container(
                            decoration: const BoxDecoration(
                              color: Colors.black,
                            ),
                            child: Container(
                              width: 355,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  //Clear Canvass
                                  // ignore: deprecated_member_use
                                  RaisedButton(
                                      color: Colors.blue,
                                      child: Text(
                                        "Clear",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      onPressed: () {
                                        setState(() =>
                                            _signaturecontrollercustomer
                                                .clear());
                                      }),
                                  // IconButton(
                                  //     icon: const Icon(
                                  //       Icons.clear,
                                  //       color: Colors.blue,
                                  //     ),
                                  //     onPressed: () {
                                  //       setState(() =>
                                  //           _signaturecontrollercustomer.clear());
                                  //     }),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              // ignore: deprecated_member_use
              RaisedButton(
                color: Colors.blue,
                onPressed: () async {
                  print(_formkey.currentState.validate());
                  if (_formkey.currentState.validate()) {
                    print("Ini proses submit");
                    if (_imageKTP !=null) await UploadKTP(_imageKTP);
                    if (_imageNPWP !=null) await UploadNPWP(_imageNPWP);
                    if (_imageSIUP != null) await UploadSIUP(_imageSIUP);
                    if (_imageSPPKP != null) await UploadSPPKP(_imageSPPKP);
                    if (_imageBusinessPhotoFront != null) await UploadBusinessPhotoFront(_imageBusinessPhotoFront);
                    if (_imageBusinessPhotoInside != null) await UploadBusinessPhotoInside(_imageBusinessPhotoInside);
                    DataSignSales = await _signaturecontrollersales.toPngBytes();
                    await UploadSignatureSales(DataSignSales, signatureSalesFromServer);
                    // DataSignCustomer = await _signaturecontrollercustomer.toPngBytes();
                    // await UploadSignatureCustomer(DataSignCustomer, signatureCustomerFromServer);
                    processSubmitCustomerForm(
                      //Customer
                      _customerNameControllerCustomer.text,
                      _brandNameControllerCustomer.text,
                      _valCategory,
                      _valSegment,
                      _valSubSegment,
                      _valClass,
                      _phoneControllerCustomer.text,
                      _valCompanyStatus,
                      _faxControllerCustomer.text,
                      _contactPersonControllerCustomer.text,
                      _emailAddressControllerCustomer.text,
                      _npwpControllerCustomer.text,
                      _ktpControllerCustomer.text,
                      _siupControllerCustomer.text,
                      _sppkpControllerCustomer.text,
                      _valCurrency,
                      _valSalesOffice,
                      _valPriceGroup,
                      _valBusinessUnit,
                      _salesmanControllerCustomer.text,
                      _websiteControllerCustomer.text,
                      _longitudeControllerDelivery.text,
                      _latitudeControllerDelivery.text,
                      // locationVal,
                      // _currentPosition,

                      //Company
                      _nameControllerCompany.text,
                      _streetControllerCompany.text,
                      _cityControllerCompany.text,
                      _countryControllerCompany.text,
                      _stateControllerCompany.text,
                      _zipCodeControllerCompany.text,

                      //Tax
                      _nameControllerTax.text,
                      _streetControllerTax.text,
                      _cityControllerTax.text,
                      _countryControllerTax.text,
                      _stateControllerTax.text,
                      _zipCodeControllerTax.text,

                      //Delivery
                      _nameControllerDelivery.text,
                      _streetControllerDelivery.text,
                      _cityControllerDelivery.text,
                      _countryControllerDelivery.text,
                      _stateControllerDelivery.text,
                      _zipCodeControllerDelivery.text,
                    );
                    successDialog(context, "Success");
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new DashboardEmployeePage(
                            iduser: widget.id,
                            username: widget.username,
                            bu: widget.bu,
                            so: widget.so,
                          )),
                    );
                  }
                },
                child: Text(
                  "Submit",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
