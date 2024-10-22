class ComplaintModel {
  int? id;
  int? idCustomer;
  String? complaintDate;
  String? image;
  String? productionCode;
  String? description;
  String? createdAt;
  String? updatedAt;
  Customer? customer;

  ComplaintModel(
      {this.id,
      this.idCustomer,
      this.complaintDate,
      this.image,
      this.productionCode,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.customer});

  ComplaintModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idCustomer = json['id_customer'];
    complaintDate = json['complaint_date'];
    image = json['image'];
    productionCode = json['production_code'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_customer'] = this.idCustomer;
    data['complaint_date'] = this.complaintDate;
    data['image'] = this.image;
    data['production_code'] = this.productionCode;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    return data;
  }
}

class Customer {
  int? id;
  int? idGroup;
  String? email;
  String? password;
  String? customerName;
  String? picName;
  String? picPhone;
  String? address;
  String? createdAt;
  String? updatedAt;
  Company? company;

  Customer(
      {this.id,
      this.idGroup,
      this.email,
      this.password,
      this.customerName,
      this.picName,
      this.picPhone,
      this.address,
      this.createdAt,
      this.updatedAt,
      this.company});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idGroup = json['id_group'];
    email = json['email'];
    password = json['password'];
    customerName = json['customer_name'];
    picName = json['pic_name'];
    picPhone = json['pic_phone'];
    address = json['address'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    company =
        json['company'] != null ? new Company.fromJson(json['company']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_group'] = this.idGroup;
    data['email'] = this.email;
    data['password'] = this.password;
    data['customer_name'] = this.customerName;
    data['pic_name'] = this.picName;
    data['pic_phone'] = this.picPhone;
    data['address'] = this.address;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.company != null) {
      data['company'] = this.company!.toJson();
    }
    return data;
  }
}

class Company {
  int? id;
  String? companyName;
  String? createdAt;
  String? updatedAt;

  Company({this.id, this.companyName, this.createdAt, this.updatedAt});

  Company.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyName = json['company_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['company_name'] = this.companyName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
