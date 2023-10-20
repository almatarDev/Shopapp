import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/componants/colors.dart';
import 'package:shopapp/componants/componants.dart';
import 'package:shopapp/cubit/cubit.dart';
import 'package:shopapp/cubit/states.dart';
import 'package:shopapp/layouts/show_item/showItem.dart';
import 'package:shopapp/network/models/favorites_model.dart';

class Favorites extends StatelessWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDark = ShopCubit.get(context).isDark;
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            body: ConditionalBuilder(
          condition: state is! ShopFavoritesLoadingState,
          builder: (context) => ListView.separated(
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) => FavoritesItemUi(
                  context,
                  ShopCubit.get(context)
                      .favoritesModel
                      .data!
                      .data![index]
                      .product!),
              // FavoritesItem(
              // ShopCubit.get(context)
              // .favoritesModel
              // .data!
              // .data![index]
              // .product!,
              //context,
              //isDark
              // ),
              separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
              itemCount:
                  ShopCubit.get(context).favoritesModel.data!.data!.length),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        ));
      },
    );
  }
}

Widget FavoritesItemUi(context, Product model) => InkWell(
      onTap: () {
        NavigetTo(context: context, widget: ShowItem(model: model));
      },
      child: Container(
        height: 150,
        padding: EdgeInsets.all(12),
        margin: const EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Color.fromARGB(255, 255, 255, 254),
        ),
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            Image(
              fit: BoxFit.cover,
              height: 150,
              width: 100,
              image: NetworkImage(model.image!),
            ),

            const SizedBox(
              width: 20,
            ),

            // ignore: sized_box_for_whitespace

            Container(
              width: MediaQuery.of(context).size.width - 220,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                // ignore: prefer_const_literals_to_create_immutables

                children: [
                  // ignore: prefer_const_constructors

                  Text(
                    model.name!,

                    overflow: TextOverflow.ellipsis,

                    maxLines: 2,

                    // ignore: prefer_const_constructors

                    style: TextStyle(
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold),
                  ),

                  // ignore: prefer_const_constructors

                  Text(
                    '\$ ${model.price}',

                    overflow: TextOverflow.ellipsis,

                    maxLines: 2,

                    // ignore: prefer_const_constructors

                    style: TextStyle(
                        color: colorItem,
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            Spacer(),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              // ignore: prefer_const_literals_to_create_immutables

              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.shopping_cart,
                    size: 30,
                    color: mainColor,
                  ),
                ),
                Spacer(),
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    ShopCubit.get(context).changeFavorites(model.id!);
                  },
                  icon: Icon(
                    Icons.favorite,
                    color: ShopCubit.get(context).favorites[model.id] == true
                        ? mainColor
                        : Colors.grey,
                    size: 25,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
