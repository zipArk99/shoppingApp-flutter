import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/products_model.dart';
import 'package:shop/models/products_provider.dart';

class EditProductScreen extends StatefulWidget {
  static const String EditProductScreenRoute = "/EditProductScreenRoute";
  @override
  State<StatefulWidget> createState() {
    return EditProductScreenState();
  }
}

class EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionNode = FocusNode();
  final _imageUrlNode = FocusNode();
  var _imageUrlControlled = TextEditingController();
  final _form = GlobalKey<FormState>();

  var _init = true;

  var _editedProduct = Product(
      id: "", title: "", price: 0, imageUrl: "", productDescription: "");

  var _initValue = {
    'id': null,
    'title': "",
    'price': "",
    'imageUrl': "",
    'productDescription': "",
  };

  @override
  void initState() {
    _imageUrlNode.addListener(focusListener);
    super.initState();
  }

  void focusListener() {
    if (!_imageUrlNode.hasFocus) {
      setState(() {});
    }
  }

  void saveForm(BuildContext contx) {
    var product = Provider.of<ProductsProvider>(contx, listen: false);
    var validateForm = _form.currentState!.validate();

    if (!validateForm) {
      return;
    }

    print("saveForm called");
    _form.currentState!.save();

    if (_initValue['id'] != null) {
      print("product id:::::" + _initValue['id'].toString());
      product.editProduct(_editedProduct, _initValue['id'].toString());
    } else {
      product.addProduct(_editedProduct);
    }

    Navigator.of(contx).pop();
  }

  @override
  void didChangeDependencies() {
    if (_init) {
      var navigationArgument = ModalRoute.of(context)!.settings.arguments;

      if (navigationArgument != null) {
        _editedProduct = Provider.of<ProductsProvider>(context, listen: false)
            .getSingleProduct(navigationArgument as String);

        _initValue = {
          'id': _editedProduct.id,
          'title': _editedProduct.title,
          'price': _editedProduct.price.toString(),
          'imageUrl': "",
          'productDescription': _editedProduct.productDescription,
        };
        _imageUrlControlled.text = _editedProduct.imageUrl;
      }
    }
    _init = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext contx) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit product"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          key: _form,
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 20),
            children: [
              TextFormField(
                initialValue: _initValue['title'],
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Title",
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                onFieldSubmitted: (_) {
                  FocusScope.of(contx).requestFocus(_priceFocusNode);
                },
                onSaved: (value) {
                  _editedProduct = Product(
                    id: _editedProduct.id,
                    title: value as String,
                    price: _editedProduct.price,
                    imageUrl: _editedProduct.imageUrl,
                    productDescription: _editedProduct.imageUrl,
                    isFavorite: _editedProduct.isFavorite,
                  );
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "null value founded";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                initialValue: _initValue['price'],
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Price",
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(contx).requestFocus(_descriptionNode);
                },
                onSaved: (value) {
                  _editedProduct = Product(
                    id: "",
                    title: _editedProduct.title,
                    price: double.parse(value as String),
                    imageUrl: _editedProduct.imageUrl,
                    productDescription: _editedProduct.productDescription,
                    isFavorite: _editedProduct.isFavorite,
                  );
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "null value founded";
                  }
                  if (double.tryParse(value) == null) {
                    return "please enter number only";
                  }
                  if (double.parse(value) <= 0) {
                    return "please enter valid price";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                initialValue: _initValue['productDescription'],
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Description",
                ),
                keyboardType: TextInputType.multiline,
                focusNode: _descriptionNode,
                textInputAction: TextInputAction.next,
                maxLines: 3,
                onFieldSubmitted: (_) {
                  FocusScope.of(contx).requestFocus(_imageUrlNode);
                },
                onSaved: (value) {
                  _editedProduct = Product(
                    id: _editedProduct.id,
                    title: _editedProduct.title,
                    price: _editedProduct.price,
                    imageUrl: _editedProduct.imageUrl,
                    productDescription: value as String,
                    isFavorite: _editedProduct.isFavorite,
                  );
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "null value founded";
                  }
                  if (value.length < 10) {
                    return "atleast 10 letter";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.black45)),
                      child: _imageUrlControlled.text.isEmpty
                          ? Text("Image")
                          : Image.network(
                              _imageUrlControlled.text,
                              fit: BoxFit.cover,
                            )),
                  Expanded(
                    child: TextFormField(
                      focusNode: _imageUrlNode,
                      decoration: InputDecoration(
                        labelText: "ImageUrl",
                      ),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlControlled,
                      onFieldSubmitted: (_) {
                        saveForm(contx);
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                          id: _editedProduct.id,
                          title: _editedProduct.title,
                          price: _editedProduct.price,
                          imageUrl: value as String,
                          productDescription: _editedProduct.productDescription,
                          isFavorite: _editedProduct.isFavorite,
                        );
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Empty Url Founded";
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          saveForm(contx);
        },
        child: Icon(Icons.save),
      ),
    );
  }

  @override
  void dispose() {
    print("edit dispose called");
    _imageUrlNode.removeListener(focusListener);
    _priceFocusNode.dispose();
    _descriptionNode.dispose();
    super.dispose();
  }
}
