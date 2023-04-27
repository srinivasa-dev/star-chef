import 'package:flutter/material.dart';
import 'package:star_chef/blocs/all_details_bloc/all_details_bloc.dart';
import 'package:star_chef/models/all_details_model.dart';
import 'package:star_chef/res/app_colors.dart';
import 'package:star_chef/view/ingredients_page.dart';
import 'package:star_chef/view/widgets/date_time.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:star_chef/view/widgets/popular_list_shimmer.dart';
import 'package:star_chef/view/widgets/ratings.dart';
import 'package:star_chef/view/widgets/recommended_list_shimmer.dart';


class DishesPage extends StatefulWidget {
  const DishesPage({Key? key}) : super(key: key);

  @override
  State<DishesPage> createState() => _DishesPageState();
}

class _DishesPageState extends State<DishesPage> {

  late AllDetailsModel _allDetailsModel = AllDetailsModel(popularDishes: [], dishes: []);
  int _selectedRegion = 0;
  bool _loading = false;
  final AllDetailsBloc _allDetailsBloc = AllDetailsBloc();
  DateTime _selectedDate = DateTime.now();
  String _date = DateFormat('dd MMM yyyy').format(DateTime.now());
  String _startTime = DateFormat('hh:mm a').format(DateTime.now());
  String _endTime = DateFormat('hh:mm a').format(DateTime.now().add(const Duration(hours: 1)));

  @override
  void initState() {
    _allDetailsBloc.add(LoadAllDetailsBloc(context: context));
    super.initState();
  }

  @override
  void dispose() {
    _allDetailsBloc.close();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(1998, 1),
        lastDate: DateTime(DateTime.now().year + 5));
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _date = DateFormat('dd MMM yyyy').format(picked);
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_selectedDate),);
    if (picked != null) {
      setState(() {
        _selectedDate = DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day, picked.hour, picked.minute);
        _startTime = DateFormat('hh:mm a').format(_selectedDate);
        _endTime = DateFormat('hh:mm a').format(_selectedDate.add(const Duration(hours: 1)));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Image.asset(
            'assets/images/2x/Group 1541@2x.png',
            height: 16.0,
          ),
          splashRadius: 20.0,
        ),
        title: Text(
          'Select Dishes',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 61),
        child: TextButton(
          onPressed: () {},
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(const EdgeInsets.symmetric(vertical: 11.5, horizontal: 16.0)),
            shape: MaterialStateProperty.all<OutlinedBorder?>(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7.0),
            )),
            backgroundColor: MaterialStateProperty.all<Color?>(AppColors.textBody1),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/2x/Group 377@2x.png',
                height: 18.0,
              ),
              const SizedBox(width: 9.0),
              Text(
                '3 food items selected',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: AppColors.white,
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.arrow_forward,
                color: AppColors.white,
              ),
            ],
          ),
        ),
      ),
      body: BlocConsumer<AllDetailsBloc, AllDetailsState>(
        bloc: _allDetailsBloc,
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildDateTime(context),
                buildRegionList(),
                const SizedBox(
                  height: 21.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 23.0),
                  child: Text(
                    'Popular Dishes',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 17.0,
                      letterSpacing: 0.14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                buildPopularDishesList(),
                const Divider(
                  color: AppColors.dividerLarge,
                  thickness: 3.0,
                  height: 55.0,
                ),
                buildRecommended(context),
                const SizedBox(height: 80.0,),
              ],
            ),
          );
        },
        listener: (context, state) {
          if(state is AllDetailsLoadingState) {
            setState(() {
              _loading = true;
            });
          } else if (state is AllDetailsLoadedState) {
            setState(() {
              _allDetailsModel = state.allDetailsModel;
              _loading = false;
            });
          } else if (state is AllDetailsErrorState) {
            setState(() {
              _loading = false;
            });
          } else {
            setState(() {
              _loading = false;
            });
          }
        },
      ),
    );
  }

  Widget buildRecommended(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 23.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              initiallyExpanded: true,
              childrenPadding: EdgeInsets.zero,
              tilePadding: EdgeInsets.zero,
              trailing: SizedBox(
                height: 28.0,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color?>(AppColors.textBody1),
                    shadowColor: MaterialStateProperty.all<Color?>(AppColors.buttonShadow),
                    shape: MaterialStateProperty.all<OutlinedBorder?>(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ),),
                    elevation: MaterialStateProperty.all<double?>(5.0),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(const EdgeInsets.symmetric(horizontal: 16.0)),
                  ),
                  child: Text(
                    'Menu',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
              title: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Recommended',
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontSize: 20.0,
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
              children: [
                _loading ? const RecommendedListShimmer() : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(_allDetailsModel.dishes!.length, (index) {
                    return Container(
                      padding: const EdgeInsets.only(top: 22.0, bottom: 20.0),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: AppColors.dividerSmall,
                            width: 0.7,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    _allDetailsModel.dishes![index].name!,
                                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(width: 6.0,),
                                  Image.asset(
                                    'assets/images/2x/Group 359@2x.png',
                                    height: 10.0,
                                  ),
                                  const SizedBox(width: 10.0,),
                                  Ratings(starCount: _allDetailsModel.dishes![index].rating!.toString()),
                                ],
                              ),
                              const SizedBox(height: 8.0,),
                              Row(
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        right: BorderSide(
                                          width: 0.5,
                                          color: AppColors.dividerSmall,
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      children: List.generate(_allDetailsModel.dishes![index].equipments!.length, (ind) {
                                        return Container(
                                          margin: const EdgeInsets.only(right: 8.5),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Image.asset(
                                                _allDetailsModel.dishes![index].equipments![ind] == 'Microwave'
                                                    ? 'assets/images/1x/microwave.png' : 'assets/images/2x/Group 508@2x.png',
                                                height: 15.0,
                                              ),
                                              const SizedBox(height: 2.0,),
                                              Text(
                                                _allDetailsModel.dishes![index].equipments![ind],
                                                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                                  fontSize: 6.0,
                                                  height: 0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
                                    ),
                                  ),
                                  const SizedBox(width: 15.5,),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => const IngredientsPage()));
                                    },
                                    child: Container(
                                      color: Colors.transparent,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Ingredients',
                                            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                'View list ',
                                                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                                  color: AppColors.textOrange,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              const Icon(
                                                Icons.arrow_forward_ios,
                                                color: AppColors.textOrange,
                                                size: 7.0,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8.0,),
                              SizedBox(
                                width: 230.0,
                                child: Text(
                                  _allDetailsModel.dishes![index].description!,
                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: AppColors.textBody2,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 10.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Container(
                                    height: 68.0,
                                    width: 94.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: Image.network(
                                      _allDetailsModel.dishes![index].image!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                child: SizedBox(
                                  height: 25.0,
                                  child: Stack(
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {},
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all<Color?>(AppColors.background),
                                          shadowColor: MaterialStateProperty.all<Color?>(AppColors.buttonShadow),
                                          shape: MaterialStateProperty.all<OutlinedBorder?>(RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(3.0),
                                            side: const BorderSide(
                                              color: AppColors.btnBorderOrange,
                                              width: 0.5,
                                            ),
                                          ),),
                                          elevation: MaterialStateProperty.all<double?>(5),
                                          padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(const EdgeInsets.symmetric(horizontal: 19.0, vertical: 0)),
                                        ),
                                        child: Text(
                                          'Add',
                                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                            color: AppColors.textOrange,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15.0,
                                          ),
                                        ),
                                      ),
                                      const Positioned(
                                        top: 2,
                                        right: 4,
                                        child: Icon(
                                          Icons.add,
                                          color: AppColors.textOrange,
                                          size: 10.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRegionList() {
    return SizedBox(
      height: 28.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        padding: const EdgeInsets.only(left: 23.0),
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(right: 18.0),
            child: TextButton(
              onPressed: () {
                setState(() {
                  _selectedRegion = index;
                });
              },
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(const EdgeInsets.symmetric(vertical: 0, horizontal: 23.0)),
                shape: MaterialStateProperty.all<OutlinedBorder?>(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(17.0),
                  side: BorderSide(
                    color: _selectedRegion == index ? AppColors.primary : AppColors.border,
                    width: 0.5,
                  ),
                )),
                backgroundColor: MaterialStateProperty.all<Color?>(_selectedRegion == index ? AppColors.lightOrange : Colors.transparent),
              ),
              child: Text(
                'Indian',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 14.0,
                  color: _selectedRegion == index ? AppColors.textOrange : AppColors.textDisabled,
                  letterSpacing: 0.1,
                  fontWeight: _selectedRegion == index ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Stack buildDateTime(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 42.0,
          margin: const EdgeInsets.only(bottom: 70.0),
          width: MediaQuery.of(context).size.width,
          color: AppColors.textBody1,
        ),
        Positioned(
          top: 20.0,
          left: 23.0,
          right: 23.0,
          child: Card(
            color: AppColors.background,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9.0),
            ),
            shadowColor: AppColors.shadow,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 22.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomDateTime(
                    onTap: () {
                      _selectDate(context);
                    },
                    title: _date,
                    icon: 'assets/images/2x/Select_date-01@2x.png',
                  ),
                  Container(
                    height: 26.0,
                    width: 1.0,
                    color: AppColors.dividerSmall,
                  ),
                  CustomDateTime(
                    onTap: () {
                      _selectTime(context);
                    },
                    title: '$_startTime-$_endTime',
                    icon: 'assets/images/2x/Set_time-01@2x.png',
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildPopularDishesList() {
    return _loading ? const PopularListShimmer() : SizedBox(
      height: 68.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: _allDetailsModel.popularDishes!.length,
        padding: const EdgeInsets.only(left: 23.0),
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(right: 8.0),
            child: Container(
              width: 68.0,
              padding: const EdgeInsets.all(2.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.primary,
                ),
                borderRadius: BorderRadius.circular(100.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100.0),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.network(
                        _allDetailsModel.popularDishes![index].image!,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned.fill(
                      child: Container(
                        color: AppColors.textBody1.withOpacity(0.4),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Text(
                          _allDetailsModel.popularDishes![index].name!,
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                            color: AppColors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
