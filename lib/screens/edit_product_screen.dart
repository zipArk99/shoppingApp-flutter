import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  @override
  Widget build(BuildContext contx) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Edit product"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 20),
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Title",
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  onFieldSubmitted: (_) {
                    FocusScope.of(contx).requestFocus(_priceFocusNode);
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
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
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
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
                            border:
                                Border.all(width: 1, color: Colors.black45)),
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
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
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
