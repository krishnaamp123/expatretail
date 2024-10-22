class CartModel {
  int? id;
  int? idCustomer;
  int? idCustomerProduct;
  int? qty;
  String? createdAt;
  String? updatedAt;
  Customer? customer;
  CustomerProduct? customerProduct;

  CartModel(
      {this.id,
      this.idCustomer,
      this.idCustomerProduct,
      this.qty,
      this.createdAt,
      this.updatedAt,
      this.customer,
      this.customerProduct});

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idCustomer = json['id_customer'];
    idCustomerProduct = json['id_customer_product'];
    qty = json['qty'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    customerProduct = json['customer_product'] != null
        ? new CustomerProduct.fromJson(json['customer_product'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_customer'] = this.idCustomer;
    data['id_customer_product'] = this.idCustomerProduct;
    data['qty'] = this.qty;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    if (this.customerProduct != null) {
      data['customer_product'] = this.customerProduct!.toJson();
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

class CustomerProduct {
  int? id;
  int? idCustomer;
  int? idProduct;
  int? price;
  String? createdAt;
  String? updatedAt;
  Customer? customer;
  Product? product;

  CustomerProduct(
      {this.id,
      this.idCustomer,
      this.idProduct,
      this.price,
      this.createdAt,
      this.updatedAt,
      this.customer,
      this.product});

  CustomerProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idCustomer = json['id_customer'];
    idProduct = json['id_product'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_customer'] = this.idCustomer;
    data['id_product'] = this.idProduct;
    data['price'] = this.price;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }
}

class Product {
  int? id;
  int? idPackaging;
  String? productName;
  String? image;
  String? descriprtion;
  String? createdAt;
  String? updatedAt;
  Packaging? packaging;

  Product(
      {this.id,
      this.idPackaging,
      this.productName,
      this.image,
      this.descriprtion,
      this.createdAt,
      this.updatedAt,
      this.packaging});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idPackaging = json['id_packaging'];
    productName = json['product_name'];
    image = json['image'];
    descriprtion = json['descriprtion'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    packaging = json['packaging'] != null
        ? new Packaging.fromJson(json['packaging'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_packaging'] = this.idPackaging;
    data['product_name'] = this.productName;
    data['image'] = this.image;
    data['descriprtion'] = this.descriprtion;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.packaging != null) {
      data['packaging'] = this.packaging!.toJson();
    }
    return data;
  }
}

class Packaging {
  int? id;
  String? packagingName;
  int? weight;
  String? createdAt;
  String? updatedAt;

  Packaging(
      {this.id,
      this.packagingName,
      this.weight,
      this.createdAt,
      this.updatedAt});

  Packaging.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    packagingName = json['packaging_name'];
    weight = json['weight'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['packaging_name'] = this.packagingName;
    data['weight'] = this.weight;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
