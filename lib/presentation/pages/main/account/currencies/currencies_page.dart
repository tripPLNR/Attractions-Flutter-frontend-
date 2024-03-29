import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:triplaner/presentation/pages/main/account/currencies/widgets/currency_tile.dart';
import 'package:triplaner/util/app_constant.dart';
import 'currencies_cubit.dart';
import 'currencies_initial_params.dart';
import 'currencies_state.dart';

class CurrenciesPage extends StatefulWidget {
  final CurrenciesCubit cubit;

  const CurrenciesPage({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<CurrenciesPage> createState() => _CurrenciesState();
}

class _CurrenciesState extends State<CurrenciesPage> {
  CurrenciesCubit get cubit => widget.cubit;

  @override
  void initState() {
    super.initState();
    cubit.navigator.context = context;
    cubit.onInit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: AppConstant.screenPadding,
        child: Column(
          children: [
            SizedBox(height: 10.h,),
            Padding(
              padding:  EdgeInsets.symmetric(vertical: 16.h),
              child: const Divider(
                thickness: 2,
                height: 0,
              ),
            ),
            Expanded(
              child: BlocBuilder<CurrenciesCubit,CurrenciesState>(
                bloc: cubit,
                builder: (context,state) {
                  return ListView.builder(
                    itemCount: cubit.currenciesList.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context,index){
                      return CurrencyTile(
                        currency: cubit.currenciesList[index],
                        isSelected: cubit.isSelected(cubit.currenciesList[index]),
                        onTap: (){
                          cubit.changeCurrency(cubit.currenciesList[index]);
                        },
                      );
                    },
                  );
                }
              ),
            )
          ],
        ),
      ),
    );
  }
}
