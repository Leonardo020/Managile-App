// ignore_for_file: constant_identifier_names

import 'dart:io';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mylife/blocs/product/product_bloc.dart';
import 'package:mylife/models/product.dart';
import 'package:mylife/pages/components/custom_app_bar.dart';
import 'package:mylife/service/utils/img_url_to_file.dart';
import 'package:mylife/routes/app_routes.dart';

enum FieldError { Empty, Invalid }

class ProductRegisterScreen extends StatefulWidget {
  final int? id;
  @override
  State<ProductRegisterScreen> createState() => _ProductRegisterScreenState();
  const ProductRegisterScreen({Key? key, this.id}) : super(key: key);
}

class _ProductRegisterScreenState extends State<ProductRegisterScreen> {
  late ProductBloc _product;
  File? newImage;
  File? oldImage;
  final picker = ImagePicker();
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _quantityController = TextEditingController();
  final CurrencyTextInputFormatter formatter =
      CurrencyTextInputFormatter(locale: 'pt-br', symbol: 'R\$');
  bool imageLoading = false;

  FocusNode focusPrice = FocusNode();
  FocusNode focusQuantity = FocusNode();

  @override
  void initState() {
    _product = ProductBloc();
    _product.add(GetProductDetailEvent(widget.id));
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    focusPrice.dispose();
    focusQuantity.dispose();
    _product.close();
    super.dispose();
  }

  populateForm(ProductState state) async {
    setState(() {
      imageLoading = true;
    });

    final product = (state as ProductSingleLoaded).productModel;
    _titleController.text = product.title ?? '';
    _quantityController.text =
        product.quantity != null ? product.quantity.toString() : '';
    _priceController.text = state.productModel.price != null
        ? formatter.format(state.productModel.price!.toStringAsFixed(2))
        : '';
    oldImage = product.urlImage == '' || product.urlImage == null
        ? null
        : await fileFromImageUrl(product.urlImage!);

    setState(() {
      newImage = oldImage;
      imageLoading = false;
    });
  }

  addImageGallery() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      newImage = File(pickedFile!.path);
    });
  }

  saveProduct() {
    _product.add(RegisterProductEvent(
        ProductModel(
            title: _titleController.text,
            price: double.parse(formatter.getUnformattedValue().toString()),
            quantity: int.parse(_quantityController.text)),
        newImage));
  }

  updateProduct() {
    if (oldImage != null) {
      if (oldImage!.path == newImage!.path) {
        newImage = null;
      }
    }

    _product.add(UpdateProductEvent(
      ProductModel(
          title: _titleController.text,
          price: double.parse(formatter.getUnformattedValue().toString()),
          quantity: int.parse(_quantityController.text)),
      newImage,
      widget.id!,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
          title: widget.id != null
              ? 'Detalhes do Produto'
              : 'Cadastro de Produtos'),
      body: BlocProvider(
        create: (BuildContext context) => _product,
        child: BlocListener<ProductBloc, ProductState>(
          listener: (context, state) async {
            if (state is ProductError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
            if (state is ProductLoaded) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRoutes.PRODUCTS, ModalRoute.withName(AppRoutes.HOME));
            }

            if (state is ProductSingleLoaded) {
              await populateForm(state);
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Center(
              child: BlocBuilder<ProductBloc, ProductState>(
                  builder: (context, state) {
                if (state is ProductLoading && widget.id != null) {
                  return const CircularProgressIndicator();
                } else if (state is ProductSingleLoaded) {
                  return _buildForm(state);
                } else {
                  return _buildForm(state);
                }
              }),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForm(ProductState state) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const SizedBox(height: 20),
          InkWell(
              onTap: () => addImageGallery(),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: imageLoading
                    ? Image.asset('assets/gif/snap-load2.gif',
                        fit: BoxFit.fitHeight, height: 300)
                    : !imageLoading && newImage != null
                        ? Image.file(
                            newImage!,
                            height: 300,
                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            'https://iseb3.com.br/assets/camaleon_cms/image-not-found-4a963b95bf081c3ea02923dceaeb3f8085e1a654fc54840aac61a57a60903fef.png',
                            height: 300,
                            fit: BoxFit.cover),
              )),
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
              enabledBorder: _renderBorder(),
              focusedBorder: _renderBorder(),
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
                  controller: _priceController,
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
                    enabledBorder: _renderBorder(),
                    focusedBorder: _renderBorder(),
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
                    enabledBorder: _renderBorder(),
                    focusedBorder: _renderBorder(),
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
            child: state is ProductProcessLoading
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(widget.id == null ? 'Cadastrando' : 'Atualizando'),
                      const SizedBox(width: 15),
                      const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(color: Colors.white),
                      ),
                    ],
                  )
                : widget.id == null
                    ? const Text('Cadastrar', style: TextStyle(fontSize: 26))
                    : const Text('Atualizar', style: TextStyle(fontSize: 26)),
            onPressed: () =>
                widget.id == null ? saveProduct() : updateProduct(),
          ),
        ]);
  }

  OutlineInputBorder _renderBorder() => const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(color: Colors.grey, width: 1),
      );

  // String _titleErrorText(FieldError? error) {
  //   switch (error) {
  //     case FieldError.Empty:
  //       return 'You need to enter an title address';
  //     case FieldError.Invalid:
  //       return 'Title address invalid';
  //     default:
  //       return '';
  //   }
  // }
}
