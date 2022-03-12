import 'dart:developer';
import 'dart:io';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mylife/blocs/product/product_bloc.dart';
import 'package:mylife/components/custom_app_bar.dart';
import 'package:mylife/models/product.dart';
import 'package:mylife/routes/app_routes.dart';

enum FieldError { Empty, Invalid }

class ProductRegisterScreen extends StatefulWidget {
  @override
  State<ProductRegisterScreen> createState() => _ProductRegisterScreenState();
  const ProductRegisterScreen({Key? key}) : super(key: key);
}

class _ProductRegisterScreenState extends State<ProductRegisterScreen> {
  var _image;
  final picker = ImagePicker();
  final _titleController = TextEditingController();
  final _quantityController = TextEditingController();
  final CurrencyTextInputFormatter formatter =
      CurrencyTextInputFormatter(locale: 'pt-br', symbol: 'R\$');

  FocusNode focusPrice = FocusNode();
  FocusNode focusQuantity = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    focusPrice.dispose();
    focusQuantity.dispose();
  }

  addImageGallery() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = File(pickedFile!.path);
    });
  }

  saveProduct(context) {
    BlocProvider.of<ProductBloc>(context).add(RegisterProductEvent(
        ProductModel(
            title: _titleController.text,
            price: double.parse(formatter.getUnformattedValue().toString()),
            quantity: int.parse(_quantityController.text)),
        _image));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
          title: 'Cadastro de Produtos', save: () => saveProduct(context)),
      body: BlocProvider(
        create: (BuildContext context) => ProductBloc(),
        child: BlocListener<ProductBloc, ProductState>(
          listener: (context, state) {
            if (state is ProductError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
            if (state is ProductLoaded) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRoutes.PRODUCTS, ModalRoute.withName(AppRoutes.HOME));
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Center(
              child: BlocBuilder<ProductBloc, ProductState>(
                  builder: (context, state) {
                return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: () => addImageGallery(),
                        child: _image != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.file(
                                  _image,
                                  height: 250,
                                  width: 300,
                                  fit: BoxFit.fitWidth,
                                ),
                              )
                            : Container(
                                height: 250,
                                width: 300,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1.0,
                                        color: Colors.grey,
                                        style: BorderStyle.solid),
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _titleController,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: 'Título',
                          labelStyle: const TextStyle(
                            color: Colors.black,
                          ),
                          hintStyle: const TextStyle(
                            color: Colors.black,
                          ),
                          enabledBorder: _renderBorder(state),
                          focusedBorder: _renderBorder(state),
                        ),
                        onSubmitted: (_) => focusPrice.requestFocus(),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: TextField(
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                              inputFormatters: <TextInputFormatter>[formatter],
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                hintText: 'Preço',
                                labelStyle: const TextStyle(
                                  color: Colors.black,
                                ),
                                hintStyle: const TextStyle(
                                  color: Colors.black,
                                ),
                                enabledBorder: _renderBorder(state),
                                focusedBorder: _renderBorder(state),
                              ),
                              keyboardType: TextInputType.number,
                              focusNode: focusPrice,
                              onSubmitted: (_) => focusQuantity.requestFocus(),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Flexible(
                            child: TextField(
                              controller: _quantityController,
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Quantidade',
                                labelStyle: const TextStyle(
                                  color: Colors.black,
                                ),
                                hintStyle: const TextStyle(
                                  color: Colors.black,
                                ),
                                enabledBorder: _renderBorder(state),
                                focusedBorder: _renderBorder(state),
                              ),
                              focusNode: focusQuantity,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.all(15)),
                        ),
                        child: state is ProductLoading
                            ? Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text('Cadastrando'),
                                  SizedBox(width: 15),
                                  SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                        color: Colors.white),
                                  ),
                                ],
                              )
                            : const Text('Cadastrar',
                                style: TextStyle(fontSize: 26)),
                        onPressed: () => saveProduct(context),
                      ),
                    ]);
              }),
            ),
          ),
        ),
      ),
    );
  }

  OutlineInputBorder _renderBorder(ProductState state) =>
      const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(color: Colors.grey, width: 1),
      );

  String _titleErrorText(FieldError? error) {
    switch (error) {
      case FieldError.Empty:
        return 'You need to enter an title address';
      case FieldError.Invalid:
        return 'Title address invalid';
      default:
        return '';
    }
  }
}
