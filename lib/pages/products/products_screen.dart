import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mylife/blocs/product/product_bloc.dart';
import 'package:mylife/components/custom_app_bar.dart';
import 'package:mylife/models/product.dart';
import 'package:mylife/routes/app_routes.dart';

class ProductScreen extends StatefulWidget {
  final Widget loading;
  const ProductScreen({Key? key, required this.loading}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late ProductBloc _productsBloc;

  @override
  void initState() {
    _productsBloc = ProductBloc();
    _productsBloc.add(GetProductListEvent());
    super.initState();
  }

  @override
  void dispose() {
    _productsBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: 'Produtos'),
        body: Center(
          child: BlocProvider(
            create: (_) => _productsBloc,
            child: BlocListener<ProductBloc, ProductState>(
              listener: (context, state) {
                if (state is ProductError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
              child: BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductInitial) {
                    return widget.loading;
                  } else if (state is ProductLoading) {
                    return widget.loading;
                  } else if (state is ProductLoaded) {
                    return _buildListProducts(context, state.productModel);
                  } else if (state is ProductError) {
                    return Container();
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ),
        ));
  }
}

Widget _buildListProducts(BuildContext context, List<ProductModel> model) {
  return Column(children: [
    model.isNotEmpty
        ? Expanded(
            child: SizedBox(
              height: 150.0,
              child: ListView.builder(
                  itemCount: model.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 100,
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 2,
                              offset: const Offset(
                                  0, 1), // changes position of shadow
                            ),
                          ]),
                      child: ClipRRect(
                        child: Dismissible(
                          key: UniqueKey(),
                          background: Container(
                            padding: const EdgeInsets.only(right: 20),
                            child: const Icon(Icons.delete,
                                color: Colors.white, size: 40),
                            alignment: Alignment.centerRight,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          direction: DismissDirection.endToStart,
                          confirmDismiss: (_) {
                            return showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                        title: const Text('Tem certeza?'),
                                        content: const Text(
                                            'Quer deletar o produto?'),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text('Sim'),
                                            onPressed: () {
                                              Navigator.of(ctx).pop(true);
                                            },
                                          ),
                                          TextButton(
                                            child: const Text('Não'),
                                            onPressed: () {
                                              Navigator.of(ctx).pop(false);
                                            },
                                          ),
                                        ]));
                          },
                          onDismissed: (_) {
                            BlocProvider.of<ProductBloc>(context)
                                .add(DeleteProductEvent((model[index])));
                          },
                          child: Row(
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    topLeft: Radius.circular(10)),
                                child: FadeInImage(
                                  placeholder: const AssetImage(
                                      'assets/gif/snap-load2.gif'),
                                  image: model[index]
                                              .urlImage
                                              .toString()
                                              .isEmpty ||
                                          model[index].urlImage == null
                                      ? const NetworkImage(
                                          'https://iseb3.com.br/assets/camaleon_cms/image-not-found-4a963b95bf081c3ea02923dceaeb3f8085e1a654fc54840aac61a57a60903fef.png',
                                        )
                                      : NetworkImage(
                                          'https://drive.google.com/uc?export=view&id=${model[index].urlImage}',
                                        ),
                                  width: 110,
                                  height: 180,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: [
                                        const FaIcon(
                                          FontAwesomeIcons.productHunt,
                                          color: Colors.grey,
                                          size: 20,
                                        ),
                                        Flexible(
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                                right: 13.0),
                                            child: Text(
                                              ' ${model[index].title}',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w500),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const FaIcon(
                                          FontAwesomeIcons.tag,
                                          color: Colors.purple,
                                          size: 20,
                                        ),
                                        Text(
                                            ' R\$ ${model[index].price?.toStringAsFixed(2).replaceAll('.', ',')}',
                                            style: const TextStyle(
                                                color: Colors.purple)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Tooltip(
                                message: 'Quantidade\nem estoque',
                                showDuration: const Duration(seconds: 10),
                                decoration: const BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                ),
                                textStyle: const TextStyle(
                                    color: Colors.white, fontSize: 14),
                                preferBelow: true,
                                verticalOffset: 20,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 25),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                          Icons.production_quantity_limits),
                                      Text('${model[index].quantity}'),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          )
        : const Center(child: Text('Nenhum produto foi cadastrado :(')),
    ElevatedButton(
      onPressed: () =>
          Navigator.pushNamed(context, AppRoutes.REGISTER_PRODUCTS),
      child: const Icon(Icons.add),
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
        ),
      ),
    ),
  ]);
}
