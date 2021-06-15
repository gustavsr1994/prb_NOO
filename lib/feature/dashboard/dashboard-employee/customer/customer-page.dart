import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:async/async.dart';
import 'package:commons/commons.dart';
import 'package:custom_switch/custom_switch.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:path/path.dart';
import 'file:///C:/Users/mz002/StudioProjects/prb_NOO/lib/feature/dashboard/dashboard-employee/dashboardemployee-page.dart';
import 'package:signature/signature.dart';


class CustomerPage extends StatefulWidget {

  String name;
  CustomerPage({Key key, this.name}) : super(key: key);
  @override
  _CustomerPageState createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  //Customer Controller
  TextEditingController _customerNameControllerCustomer = TextEditingController();
  TextEditingController _brandNameControllerCustomer = TextEditingController();
  TextEditingController _categoryControllerCustomer = TextEditingController();
  TextEditingController _segmenControllerCustomer = TextEditingController();
  TextEditingController _subSegmenControllerCustomer = TextEditingController();
  TextEditingController _classControllerCustomer = TextEditingController();
  TextEditingController _phoneControllerCustomer = TextEditingController();
  TextEditingController _companyStausControllerCustomer = TextEditingController();
  TextEditingController _faxControllerCustomer = TextEditingController();
  TextEditingController _contactPersonControllerCustomer = TextEditingController();
  TextEditingController _emailAddressControllerCustomer = TextEditingController();
  TextEditingController _npwpControllerCustomer = TextEditingController();
  TextEditingController _ktpControllerCustomer = TextEditingController();
  TextEditingController _currencyControllerCustomer = TextEditingController();
  TextEditingController _salesOfficeControllerCustomer = TextEditingController();
  TextEditingController _priceGroupControllerCustomer = TextEditingController();
  TextEditingController _businessUnitControllerCustomer = TextEditingController();
  TextEditingController _salesmanControllerCustomer = TextEditingController();
  TextEditingController _websiteControllerCustomer = TextEditingController();
  TextEditingController _fotoktpControllerCustomer = TextEditingController();
  TextEditingController _fotonpwpControllerCustomer = TextEditingController();
  TextEditingController _fotosiupControllerCustomer = TextEditingController();
  TextEditingController _fotobuildingControllerCustomer = TextEditingController();

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

  final _formkey = GlobalKey<FormState>();

  File _imageKTP;
  File _imageNPWP;
  File _imageSIUP;
  File _imageBuilding;
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
  String buildingFromServer = "BUILDING_" + DateFormat("ddMMyyyy_hhmm").format(DateTime.now()) + "_.jpg";
  String signatureSalesFromServer = "SIGNATURESALES_" + DateFormat("ddMMyyyy_hhmm").format(DateTime.now()) + "_.jpg";
  String signatureCustomerFromServer = "SIGNATURECUSTOMER_" + DateFormat("ddMMyyyy_hhmm").format(DateTime.now()) + "_.jpg";
  final picker = ImagePicker();
  bool locationVal = false;

  // getImageKTP From Camera
  Future getImageKTPFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera, imageQuality:20);
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
    final pickedFile = await picker.getImage(source: ImageSource.gallery, imageQuality:20);
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
    var uri = Uri.parse("http://119.18.157.236:8893/api/Upload");
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
    final pickedFile = await picker.getImage(source: ImageSource.camera, imageQuality: 20);
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
    final pickedFile = await picker.getImage(source: ImageSource.gallery, imageQuality: 20);
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
    var uri = Uri.parse("http://119.18.157.236:8893/api/Upload");
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
    final pickedFile = await picker.getImage(source: ImageSource.camera, imageQuality: 20);
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
    final pickedFile = await picker.getImage(source: ImageSource.gallery, imageQuality: 20);
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
    var uri = Uri.parse("http://119.18.157.236:8893/api/Upload");
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

  // getImageBuilding from camera
  Future getImageBuildingFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera, imageQuality: 20);
    var nows = DateTime.now();
    String dateNow = DateFormat("ddMMyyyy_hhmm").format(nows);
    var renamedFile = await File(pickedFile.path).rename(
        '/storage/emulated/0/Android/data/id.prb.prb_app/files/Pictures/BUILDING_' +
            dateNow.toString() +
            '_' +
            '.jpg');
    setState(() {
      if (pickedFile != null) {
        _imageBuilding = renamedFile;
      } else {
        print('No image selected.');
      }
    });
  }

  // getImageBuilding from gallery
  Future getImageBuildingFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery, imageQuality: 20);
    var nows = DateTime.now();
    String dateNow = DateFormat("ddMMyyyy_hhmm").format(nows);
    var renamedFile = await File(pickedFile.path).rename(
        '/storage/emulated/0/Android/data/id.prb.prb_app/files/Pictures/BUILDING_' +
            dateNow.toString() +
            '_' +
            '.jpg');
    setState(() {
      if (pickedFile != null) {
        _imageBuilding = renamedFile;
      } else {
        print('No image selected.');
      }
    });
  }

  UploadBuilding(File imageFile) async {
    var stream =
    new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    var uri = Uri.parse("http://119.18.157.236:8893/api/Upload");
    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile('file', stream, length,
        filename: basename(imageFile.path));
    //contentType: new MediaType('image', 'png'));
    request.files.add(multipartFile);
    var response = await request.send();
    print(response.statusCode);
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
      buildingFromServer = value.replaceAll("\"", "");
    });
  }

  UploadSignatureSales(imageFile, String namaFile) async {
    //var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    //var length = await imageFile.length();
    var uri = Uri.parse("http://119.18.157.236:8893/api/Upload");
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
    var uri = Uri.parse("http://119.18.157.236:8893/api/Upload");
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
  var urlGetCategory = "http://119.18.157.236:8893/Api/CustCategory";
  String _valCategory;


  // ignore: deprecated_member_use
  List<dynamic> _dataCategory = List();

  void getCategory() async {
    String usernameAuth = 'test';
    String passwordAuth = 'test456';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$usernameAuth:$passwordAuth'));
    print(basicAuth);
    final response = await http.get(Uri.parse(urlGetCategory), headers: <String, String>{'authorization': basicAuth});
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
  var urlGetSegment = "http://119.18.157.236:8893/Api/CustSegment";
  var urlGetSubSegment = "http://119.18.157.236:8893/Api/CustSubSegment";
  String _valSegment, _valSubSegment;

  // ignore: deprecated_member_use
  List<dynamic> _dataSegment = List(), _dataSubSegment = List();

  void getSegment() async {
    String usernameAuth = 'test';
    String passwordAuth = 'test456';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$usernameAuth:$passwordAuth'));
    print(basicAuth);
    final response = await http.get(Uri.parse(urlGetSegment),headers: <String,String>{'authorization': basicAuth}); //untuk melakukan request ke webservice
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
    final response = await http.get(Uri.parse(urlGetSubSegment),headers: <String,String>{'authorization': basicAuth});
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
  var urlGetClass = "http://119.18.157.236:8893/Api/CustClass";
  String _valClass;
  bool _selectedClass = false;
  List<dynamic> _dataClass = List();

  void getClass() async {
    String usernameAuth = 'test';
    String passwordAuth = 'test456';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$usernameAuth:$passwordAuth'));
    print(basicAuth);
    final response = await http.get(Uri.parse(urlGetClass),headers: <String,String>{'authorization': basicAuth});
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
  var urlGetCompanyStatus = "http://119.18.157.236:8893/Api/CustCompanyChain";
  String _valCompanyStatus;
  bool _selectedCompanyStatus = false;
  List<dynamic> _dataCompanyStatus = List();

  void getCompanyStatus() async {
    String usernameAuth = 'test';
    String passwordAuth = 'test456';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$usernameAuth:$passwordAuth'));
    print(basicAuth);
    final response = await http.get(Uri.parse(urlGetCompanyStatus),headers: <String,String>{'authorization': basicAuth});
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
  var urlGetPriceGroup = "http://119.18.157.236:8893/Api/CustPriceGroup";
  String _valPriceGroup;

  // ignore: deprecated_member_use
  List<dynamic> _dataPriceGroup = List();

  void getPriceGroup() async {
    String usernameAuth = 'test';
    String passwordAuth = 'test456';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$usernameAuth:$passwordAuth'));
    print(basicAuth);
    final response = await http.get(Uri.parse(urlGetPriceGroup),headers: <String,String>{'authorization': basicAuth});
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
  var urlGetCurrency = "http://119.18.157.236:8893/Api/Currency";
  String _valCurrency;

  // ignore: deprecated_member_use
  List<dynamic> _dataCurrency = List();

  void getCurrency() async {
    String usernameAuth = 'test';
    String passwordAuth = 'test456';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$usernameAuth:$passwordAuth'));
    print(basicAuth);
    final response = await http.get(Uri.parse(urlGetCurrency),headers: <String,String>{'authorization': basicAuth});
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
  var urlGetBusinessUnit = "http://119.18.157.236:8893/Api/ViewBU";
  String _valBusinessUnit;

  // ignore: deprecated_member_use
  List<dynamic> _dataBusinessUnit = List();

  void getBusinessUnit() async {
    String usernameAuth = 'test';
    String passwordAuth = 'test456';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$usernameAuth:$passwordAuth'));
    print(basicAuth);
    final response = await http.get(Uri.parse(urlGetBusinessUnit),headers: <String,String>{'authorization': basicAuth});
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
  var urlGetSalesOffice = "http://119.18.157.236:8893/Api/ViewSO";
  String _valSalesOffice;

  // ignore: deprecated_member_use
  List<dynamic> _dataSalesOffice = List();

  void getSalesOffice() async {
    String usernameAuth = 'test';
    String passwordAuth = 'test456';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$usernameAuth:$passwordAuth'));
    print(basicAuth);
    final response = await http.get(Uri.parse(urlGetSalesOffice),headers: <String,String>{'authorization': basicAuth});
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
      String currencyCustomer,
      String salesofficeCustomer,
      String pricegroupCustomer,
      String businessunitCustomer,
      String salesmanCustomer,
      String websiteCustomer,
      bool buttonloc,
      Position getLoc,

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
    var urlPostSubmitCustomerForm =
        "http://119.18.157.236:8893/Api/NOOCustTables";
    print("Ini url Post Submit Customer : $urlPostSubmitCustomerForm");
    var jsonSubmitCustomerForm = await http.post(
        Uri.parse(
          urlPostSubmitCustomerForm,
        ),
        headers: <String, String>{
          'authorization': basicAuth,
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
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
          "FotoGedung": "$buildingFromServer",
          "CustSignature": "$signatureCustomerFromServer",
          "SalesSignature": "$signatureSalesFromServer",
          "Long": " ${buttonloc == true ? _currentPosition.longitude.toString() : 0}",
          "Lat": "${buttonloc == true ? _currentPosition.latitude.toString() : 0}",
          "CreatedBy": 1,
          "CreatedDate": "2021-04-05T14:56:48.57",
          "TaxAddresses": [
            {
              "Name": "$nameTax",
              "StreetName": "$streetNameTax",
              "City": "$cityTax",
              "Country": "$countryTax",
              "State": "$stateTax",
              "ZipCode": "$zipcodeTax"
            }
          ],
          "CompanyAddresses": [
            {
              "Name": "$nameCompany",
              "StreetName": "$streetnameCompany",
              "City": "$cityCompany",
              "Country": "$countryCompany",
              "State": "$stateCompany",
              "ZipCode": "$zipcodeCompany"
            }
          ],
          "DeliveryAddresses": [
            {
              "Name": "$nameDelivery",
              "StreetName": "$streetNameDelivery",
              "City": "$cityDelivery",
              "Country": "$countryDelivery",
              "State": "$stateDelivery",
              "ZipCode": "$zipcodeDelivery"
            }
          ]
        }));
    print(jsonSubmitCustomerForm.body.toString());
    if (jsonSubmitCustomerForm.statusCode == 200) {
      return jsonDecode(jsonSubmitCustomerForm.body);
    } else {
      throw Exception("Failed");
    }
  }

  Position  _currentPosition;
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high, forceAndroidLocationManager: true,).then((Position position) {
      setState(() {
        _currentPosition = position;
      });
    }).catchError((e){
      print(e);
    });
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.name);
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

  }

  String text = 'Press To Load';
  bool status = false;

  @override
  Widget build(BuildContext context) {

    print("ini customer page");

    final focus = FocusNode();

    var npwpFormatter = new MaskTextInputFormatter(mask: '##.###.###.#-###.###', filter: { "#": RegExp(r'[0-9]') });
    var phoneFormatter = new MaskTextInputFormatter(mask: '#### #### ####', filter: { "#": RegExp(r'[0-9]') });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white60,
        title: Text(
          "NOO Form",
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
                widget.name??"",
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
                      )
                  )
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
                      "Segmen               :",
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  DropdownButton(
                    hint: Text("Select Segment"),
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
                      "Sub Segmen       :",
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  DropdownButton(
                    hint: Text("Select SubSegment"),
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
                      "Company \n Status                 :",
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter KTP!!';
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
                        inputFormatters: [
                          npwpFormatter
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter NPWP!!';
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
                        inputFormatters: [
                          phoneFormatter
                        ],
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter FAX Number!!';
                          }
                          return null;
                        },
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Website!!';
                          }
                          return null;
                        },
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
                          "City                        :",
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
                            textAlign: TextAlign.center,
                            controller: _cityControllerCompany,
                            keyboardType: TextInputType.text,
                            autofocus: false,
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: 'city',
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
                            //     return 'Please enter Company State!!';
                            //   }
                            //   return null;
                            // },
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
                          "City                        :",
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
                            textAlign: TextAlign.center,
                            controller: _cityControllerTax,
                            keyboardType: TextInputType.text,
                            autofocus: false,
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: 'city',
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
                            // validator: (value) {
                            //   if (value == null || value.isEmpty) {
                            //     return 'Please enter Delivery Street!!';
                            //   }
                            //   return null;
                            // },
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
                          "City                        :",
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
                              hintText: 'city',
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
                                        ? Text("KTP")
                                        : Image.file(
                                      _imageKTP,
                                      fit: BoxFit.cover,
//                                  width: 150,
//                                  height: 80,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                              FloatingActionButton(
                                onPressed: getImageKTPFromCamera,
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
                                        ? Text("KTP")
                                        : Image.file(
                                      _imageKTP,
                                      fit: BoxFit.cover,
//                                  width: 150,
//                                  height: 80,
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
                                        ? Text("NPWP")
                                        : Image.file(
                                      _imageNPWP,
                                      fit: BoxFit.cover,
//                                  width: 150,
//                                  height: 80,
                                    ),
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
                                        ? Text("NPWP")
                                        : Image.file(
                                      _imageNPWP,
                                      fit: BoxFit.cover,
//                                  width: 150,
//                                  height: 80,
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
                                        ? Text("NIB")
                                        : Image.file(
                                      _imageSIUP,
                                      fit: BoxFit.cover,
//                                  width: 150,
//                                  height: 80,
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
                                        ? Text("NIB")
                                        : Image.file(
                                      _imageSIUP,
                                      fit: BoxFit.cover,
//                                  width: 150,
//                                  height: 80,
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

                    //Upload BUILDING
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
                                    child: _imageBuilding == null
                                        ? Text("Building")
                                        : Image.file(
                                      _imageBuilding,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                              FloatingActionButton(
                                onPressed: getImageBuildingFromCamera,
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
                                    child: _imageBuilding == null
                                        ? Text("Building")
                                        : Image.file(
                                      _imageBuilding,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                              FloatingActionButton(
                                onPressed: getImageBuildingFromGallery,
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
                          SizedBox(height: 10,),
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
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  //Clear Canvass
                                  IconButton(
                                      icon: const Icon(
                                        Icons.clear,
                                        color: Colors.blue,
                                      ),
                                      onPressed: () {
                                        setState(() =>
                                            _signaturecontrollersales.clear());
                                      }),
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
                          SizedBox(height: 10,),
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
                            child: Signature(
                              controller: _signaturecontrollercustomer,
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
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  //Clear Canvass
                                  IconButton(
                                      icon: const Icon(
                                        Icons.clear,
                                        color: Colors.blue,
                                      ),
                                      onPressed: () {
                                        setState(() =>
                                            _signaturecontrollercustomer.clear());
                                      }),
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

              SizedBox(height: 20,),
              //Location label
              Row(
                children: <Widget>[
                  Container(
                    child: Text(
                      "Location          :    ",
                    ),
                  ),
                  Container(
                    height: 25,
                    width: 65,
                    child: CustomSwitch(
                      activeColor: Colors.green,
                      value: locationVal,
                      onChanged: (value){
                        print("VALUE : $value");
                        setState(() {
                          locationVal = true;
                          _determinePosition();
                        });
                      },
                    ),
                  )
                ],
              ),
              SizedBox(height: 20,),
              // ignore: deprecated_member_use
              RaisedButton(
                color: Colors.blue,
                onPressed: () async {
                  print(_formkey.currentState.validate());
                  if (_formkey.currentState.validate()) {
                    print("Ini proses submit");
                    await UploadKTP(_imageKTP);
                    await UploadNPWP(_imageNPWP);
                    await UploadSIUP(_imageSIUP);
                    await UploadBuilding(_imageBuilding);
                    DataSignSales = await _signaturecontrollersales.toPngBytes();
                    await UploadSignatureSales(
                        DataSignSales, signatureSalesFromServer);
                    DataSignCustomer = await _signaturecontrollercustomer.toPngBytes();
                    await UploadSignatureCustomer(
                        DataSignCustomer, signatureCustomerFromServer);
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
                      _valCurrency,
                      _valSalesOffice,
                      _valPriceGroup,
                      _valBusinessUnit,
                      _salesmanControllerCustomer.text,
                      _websiteControllerCustomer.text,
                      locationVal,
                      _currentPosition,

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
                    successDialog(
                        context,
                        "Success"
                    );
                    Navigator.push(
                      context,
                      new MaterialPageRoute(builder: (context) => new DashboardEmployeePage()),
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
