import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_chef/blocs/ingredients_bloc/ingredients_bloc.dart';
import 'package:star_chef/models/ingredients_model.dart';
import 'package:star_chef/res/app_colors.dart';
import 'package:star_chef/view/widgets/ratings.dart';

class IngredientsPage extends StatefulWidget {
  const IngredientsPage({Key? key}) : super(key: key);

  @override
  State<IngredientsPage> createState() => _IngredientsPageState();
}

class _IngredientsPageState extends State<IngredientsPage> {

  final IngredientsBloc _ingredientsBloc = IngredientsBloc();
  late IngredientsModel _ingredientsModel;

  @override
  void initState() {
    _ingredientsBloc.add(LoadIngredientsBloc(context: context));
    super.initState();
  }

  @override
  void dispose() {
    _ingredientsBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset(
            'assets/images/2x/Group 1541@2x.png',
            height: 16.0,
          ),
          splashRadius: 20.0,
        ),
      ),
      body: BlocProvider(
        create: (context) => _ingredientsBloc,
        child: BlocConsumer<IngredientsBloc, IngredientsState>(
          builder: (context, state) {
            if(state is IngredientsLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is IngredientsLoadedState) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                        children: [
                          Positioned(
                            right: -30,
                            bottom: 0,
                            child: Container(
                              width: 171,
                              height: 171,
                              decoration: BoxDecoration(
                                color: AppColors.lightOrange,
                                borderRadius: BorderRadius.circular(100.0),
                              ),
                            ),
                          ),
                          const Positioned(
                            bottom: 21,
                            right: 0,
                            left: 0,
                            child: Divider(
                              color: AppColors.dividerLarge,
                              thickness: 3.0,
                              height: 0,
                            ),
                          ),
                          Positioned(
                            right: -80,
                            bottom: 0,
                            child: Stack(
                              children: [
                                Image.asset(
                                  'assets/images/2x/Mask Group 17@2x.png',
                                  height: 130,
                                ),
                                Positioned(
                                  right: 0,
                                  child: Image.asset(
                                    'assets/images/2x/pngtree-herbal-ingredients-transparent-image-png-image_3206949-removebg-preview@2x.png',
                                    height: 130,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 300.0,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            _ingredientsModel.name!,
                                            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                                              fontSize: 25.0,
                                            ),
                                          ),
                                          const SizedBox(width: 8.0,),
                                          const Ratings(starCount: '4.2',),
                                        ],
                                      ),
                                      const SizedBox(height: 4,),
                                      Text(
                                        'Mughlai Masala is a style of cookery developed in the Indian Subcontinent by the imperial kitchens of the Mughal Empire.',
                                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                          fontSize: 10.0,
                                          color: AppColors.textBody3,
                                        ),
                                      ),
                                      const SizedBox(height: 25.0,),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Image.asset(
                                            'assets/images/2x/Group 393@2x.png',
                                            height: 13,
                                          ),
                                          const SizedBox(width: 8.0,),
                                          Text(
                                            _ingredientsModel.timeToPrepare!,
                                            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 31.0,),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 21.0,),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: 'Ingredients\n',
                              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w700,
                                height: 2.0,
                              ),
                              children: [
                                TextSpan(
                                    text: 'For 2 people',
                                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: AppColors.textDisabled,
                                      fontSize: 10.0,
                                    )
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16.0,),
                          const Divider(
                            color: AppColors.dividerSmall,
                            thickness: 0.7,
                            height: 0,
                          ),
                          buildExpandableList(context, _ingredientsModel.ingredients!.vegetables!, 'Vegetables'),
                          buildExpandableList(context, _ingredientsModel.ingredients!.spices!, 'Spices'),
                          Text(
                            'Appliances',
                            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w700,
                              height: 2.0,
                            ),
                          ),
                          const SizedBox(height: 16.0,),
                          SizedBox(
                            height: 95.0,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: _ingredientsModel.ingredients!.appliances!.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  width: 72.0,
                                  margin: const EdgeInsets.only(right: 21.0),
                                  decoration: BoxDecoration(
                                    color: AppColors.greyBackground,
                                    borderRadius: BorderRadius.circular(7.0),
                                  ),
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        _ingredientsModel.ingredients!.appliances![index].name! == 'Stove'
                                            ? 'assets/images/1x/stove.png' :  _ingredientsModel.ingredients!.appliances![index].name! == 'Microwave'
                                            ? 'assets/images/1x/microwave-alt.png' : 'assets/images/2x/Mask Group 20@2x.png',
                                        height: 50.0,
                                      ),
                                      const SizedBox(height: 2.0,),
                                      Text(
                                        _ingredientsModel.ingredients!.appliances![index].name!,
                                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                          fontSize: 10.0,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Placeholder(
                child: Text(
                  'Oops Something went wrong!',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              );
            }
          },
          listener: (context, state) {
            if (state is IngredientsLoadedState) {
              setState(() {
                _ingredientsModel = state.ingredientsModel;
              });
            }
          },
      ),
      ),
    );
  }

  Theme buildExpandableList(BuildContext context, List<dynamic> list, String title) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        initiallyExpanded: true,
        childrenPadding: EdgeInsets.zero,
        tilePadding: EdgeInsets.zero,
        trailing: const SizedBox(),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$title (0${list.length})',
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                fontSize: 17.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(width: 10.0,),
            Image.asset(
              'assets/images/2x/Path 786@2x.png',
              height: 7.0,
            ),
          ],
        ),
        children: List.generate(list.length, (index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              children: [
                Text(
                  list[index].name!,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 14.0,
                  ),
                ),
                const Spacer(),
                Text(
                  list[index].quantity!,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
