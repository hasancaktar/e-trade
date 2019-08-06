class Product {
  int _id;
  String _name;
  String _discription;
  double _price;

  Product(this._name, this._discription, this._price);
  Product.withId(this._id, this._name, this._discription, this._price);

  int get id => _id;
  String get name => _name;
  String get discription => _discription;
  double get price => _price;

  set name(String value) {
    if (value.length >= 2) {
      _name = value;
    }
  }

  set discription(String value) {
    if (value.length >= 10) {
      _discription = value;
    }
  }

  set price(double value) {
    if (value > 0) {
      _price = value;
    }
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["Name"] = _name;
    map["Discription"] = _discription;
    map["Price"] = _price;
    if (_id != null) {
      map["Id"] = _id;
    }
    else(){
return map;
    };
    
  }

Product.fromObject(dynamic o) {
    this._id = o["Id"];
    this._name = o["Name"];
    this._discription = o["Discription"];
    this._price = double.tryParse(o["Price"].toString());}
 
  
}
