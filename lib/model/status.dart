class Status {
  int id;
  String custName;
  String brandName;
  String category;
  String segment;
  String subSegment;
  String selectclass;
  String phoneNo;
  String companyStatus;
  String faxNo;
  String contactPerson;
  String emailAddress;
  String website;
  String nPWP;
  String kTP;
  String currency;
  String priceGroup;
  String salesman;
  String salesOffice;
  String businessUnit;
  String notes;
  String fotoNPWP;
  String fotoKTP;
  String fotoSIUP;
  String fotoGedung;
  String fotoGedung1;
  String fotoGedung2;
  String fotoGedung3;
  String custSignature;
  String salesSignature;
  String approval1Signature;
  String approval2Signature;
  String approval3Signature;
  int imported;
  String long;
  String lat;
  String approval1;
  String approval2;
  String approval3;
  String status;
  String createdBy;
  String remark;
  String createdDate;
  String approved1;
  String approved2;
  String approved3;
  String siup;
  String sppkp;

  Status({
    this.id, this.custName, this.brandName, this.category, this.segment,
    this.subSegment, this.selectclass, this.phoneNo, this.companyStatus,
    this.faxNo, this.contactPerson, this.emailAddress, this.website, this.nPWP,
    this.kTP, this.currency, this.priceGroup, this.salesman, this.salesOffice,
    this.businessUnit, this.notes, this.fotoNPWP, this.fotoKTP, this.fotoSIUP,
    this.fotoGedung, this.fotoGedung1, this.fotoGedung2, this.fotoGedung3,
    this.custSignature, this.salesSignature, this.approval1Signature,
    this.approval2Signature, this.approval3Signature, this.imported, this.long,
    this.lat, this.approval1, this.approval2, this.approval3, this.status,
    this.createdBy, this.remark, this.createdDate, this.approved1,
    this.approved2, this.approved3, this.siup, this.sppkp});

  Status.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    custName = json['CustName'];
    brandName = json['BrandName'];
    category = json['Category'];
    segment = json['Segment'];
    subSegment = json['SubSegment'];
    selectclass = json['Class'];
    phoneNo = json['PhoneNo'];
    companyStatus = json['CompanyStatus'];
    faxNo = json['FaxNo'];
    contactPerson = json['ContactPerson'];
    emailAddress = json['EmailAddress'];
    website = json['Website'];
    nPWP = json['NPWP'];
    kTP = json['KTP'];
    currency = json['Currency'];
    priceGroup = json['PriceGroup'];
    salesman = json['Salesman'];
    salesOffice = json['SalesOffice'];
    businessUnit = json['BusinessUnit'];
    notes = json['Notes'];
    fotoNPWP = json['FotoNPWP'];
    fotoKTP = json['FotoKTP'];
    fotoSIUP = json['FotoSIUP'];
    fotoGedung = json['FotoGedung'];
    fotoGedung1 = json['FotoGedung1'];
    fotoGedung2 = json['FotoGedung2'];
    fotoGedung3 = json['FotoGedung3'];
    custSignature = json['CustSignature'];
    salesSignature = json['SalesSignature'];
    approval1Signature = json['Approval1Signature'];
    approval2Signature = json['Approval2Signature'];
    approval3Signature = json['Approval3Signature'];
    imported = json['Imported'];
    long = json['Long'];
    lat = json['Lat'];
    approval1 = json['Approval1'];
    approval2 = json['Approval2'];
    approval3 = json['Approval3'];
    status = json['Status'];
    createdBy = json['CreatedBy'];
    remark = json['Remark'];
    createdDate = json['CreatedDate'];
    approved1 = json['Approved1'];
    approved2 = json['Approved2'];
    approved3 = json['Approved3'];
    siup = json['SIUP'];
    sppkp = json['SPPKP'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['CustName'] = this.custName;
    data['BrandName'] = this.brandName;
    data['Category'] = this.category;
    data['Segment'] = this.segment;
    data['SubSegment'] = this.subSegment;
    data['Class'] = this.selectclass;
    data['PhoneNo'] = this.phoneNo;
    data['CompanyStatus'] = this.companyStatus;
    data['FaxNo'] = this.faxNo;
    data['ContactPerson'] = this.contactPerson;
    data['EmailAddress'] = this.emailAddress;
    data['Website'] = this.website;
    data['NPWP'] = this.nPWP;
    data['KTP'] = this.kTP;
    data['Currency'] = this.currency;
    data['PriceGroup'] = this.priceGroup;
    data['Salesman'] = this.salesman;
    data['SalesOffice'] = this.salesOffice;
    data['BusinessUnit'] = this.businessUnit;
    data['Notes'] = this.notes;
    data['FotoNPWP'] = this.fotoNPWP;
    data['FotoKTP'] = this.fotoKTP;
    data['FotoSIUP'] = this.fotoSIUP;
    data['FotoGedung'] = this.fotoGedung;
    data['FotoGedung1'] = this.fotoGedung1;
    data['FotoGedung2'] = this.fotoGedung2;
    data['FotoGedung3'] = this.fotoGedung3;
    data['CustSignature'] = this.custSignature;
    data['SalesSignature'] = this.salesSignature;
    data['Approval1Signature'] = this.approval1Signature;
    data['Approval2Signature'] = this.approval2Signature;
    data['Approval3Signature'] = this.approval3Signature;
    data['Imported'] = this.imported;
    data['Long'] = this.long;
    data['Lat'] = this.lat;
    data['Approval1'] = this.approval1;
    data['Approval2'] = this.approval2;
    data['Approval3'] = this.approval3;
    data['Status'] = this.status;
    data['CreatedBy'] = this.createdBy;
    data['Remark'] = this.remark;
    data['CreatedDate'] = this.createdDate;
    data['Approved1'] = this.approved1;
    data['Approved2'] = this.approved2;
    data['Approved3'] = this.approved3;
    data['SIUP'] = this.siup;
    data['SPPKP'] = this.sppkp;
    return data;
  }
}
