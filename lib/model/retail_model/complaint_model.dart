class ComplaintModel {
  int? id;
  int? idCustomer;
  String? complaintDate;
  List<Files>? files;
  String? productionCode;
  String? description;
  String? status;
  String? solution;
  String? createdAt;
  String? updatedAt;
  Customer? customer;

  ComplaintModel(
      {this.id,
      this.idCustomer,
      this.complaintDate,
      this.files,
      this.productionCode,
      this.description,
      this.status,
      this.solution,
      this.createdAt,
      this.updatedAt,
      this.customer});

  ComplaintModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idCustomer = json['id_customer'];
    complaintDate = json['complaint_date'];
    if (json['files'] != null) {
      files = <Files>[];
      json['files'].forEach((v) {
        files!.add(new Files.fromJson(v));
      });
    }
    productionCode = json['production_code'];
    description = json['description'];
    status = json['status'];
    solution = json['solution'];
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
    if (this.files != null) {
      data['files'] = this.files!.map((v) => v.toJson()).toList();
    }
    data['production_code'] = this.productionCode;
    data['description'] = this.description;
    data['status'] = this.status;
    data['solution'] = this.solution;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    return data;
  }
}

class Files {
  int? id;
  String? imagePath;
  String? createdAt;
  String? updatedAt;

  Files({this.id, this.imagePath, this.createdAt, this.updatedAt});

  Files.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imagePath = json['image_path'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image_path'] = this.imagePath;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Customer {
  int? id;
  int? idGroup;
  String? username;
  String? password;
  String? customerName;
  String? picName;
  String? picPhone;
  String? address;
  String? role;
  String? createdAt;
  String? updatedAt;
  Company? company;

  Customer(
      {this.id,
      this.idGroup,
      this.username,
      this.password,
      this.customerName,
      this.picName,
      this.picPhone,
      this.address,
      this.role,
      this.createdAt,
      this.updatedAt,
      this.company});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idGroup = json['id_group'];
    username = json['username'];
    password = json['password'];
    customerName = json['customer_name'];
    picName = json['pic_name'];
    picPhone = json['pic_phone'];
    address = json['address'];
    role = json['role'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    company =
        json['company'] != null ? new Company.fromJson(json['company']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_group'] = this.idGroup;
    data['username'] = this.username;
    data['password'] = this.password;
    data['customer_name'] = this.customerName;
    data['pic_name'] = this.picName;
    data['pic_phone'] = this.picPhone;
    data['address'] = this.address;
    data['role'] = this.role;
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
