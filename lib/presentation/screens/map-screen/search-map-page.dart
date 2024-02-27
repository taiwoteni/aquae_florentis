import 'package:aquae_florentis/data/network.dart';
import 'package:aquae_florentis/domain/models/autocomplete-prediction.dart';
import 'package:aquae_florentis/domain/models/place-autocomplete-response.dart';
import 'package:aquae_florentis/presentation/resources/color-manager.dart';
import 'package:aquae_florentis/presentation/resources/font-manager.dart';
import 'package:aquae_florentis/presentation/resources/value-manager.dart';
import 'package:aquae_florentis/presentation/widgets/error-screen.dart';
import 'package:aquae_florentis/presentation/widgets/spacers.dart';
import 'package:aquae_florentis/presentation/widgets/svg-icon.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchMapPage extends StatefulWidget {
  final void Function()? onPressed;
  const SearchMapPage({super.key, this.onPressed});

  @override
  State<SearchMapPage> createState() => _SearchMapPageState();
}

class _SearchMapPageState extends State<SearchMapPage> {
  final TextEditingController searchController = TextEditingController();
  List<AutoCompletePrediction> predictions = [];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: SizeManager.medium, vertical: SizeManager.medium),
          child: TextFormField(
            controller: searchController,
            maxLines: 1,
            onChanged: searchPlaceAutoComplete,
            cursorColor: ColorManager.primary,
            cursorRadius: const Radius.circular(SizeManager.medium),
            style: GoogleFonts.quicksand(
                color: ColorManager.primary,
                fontSize: FontSizeManager.regular * 0.9,
                fontWeight: FontWeightManager.medium),
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                    vertical: SizeManager.medium,
                    horizontal: SizeManager.regular * 1.5),
                isDense: true,
                hintText: "Search Place",
                floatingLabelBehavior: FloatingLabelBehavior.never,
                hintStyle: GoogleFonts.quicksand(
                    color: ColorManager.secondary,
                    fontSize: FontSizeManager.regular * 0.9,
                    fontWeight: FontWeightManager.medium),
                fillColor: const Color.fromARGB(64, 226, 226, 226),
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(SizeManager.regular),
                    borderSide: BorderSide.none)),
          ),
        ),
        const Divider(),
        mediumSpacer(),
        if (searchController.text.isNotEmpty)
          if (predictions.isEmpty)
            ErrorScreen(
              lottie: "no-results",
              label: 'no search results for "${searchController.text}" ',
            )
          else
            ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final AutoCompletePrediction prediction = predictions[index];
                  return ListTile(
                    onTap: () {
                      Navigator.pop(context, {
                        "place name": prediction.description!,
                        "place id": prediction.placeId!,
                      });
                    },
                    dense: true,
                    leading: Container(
                      width: 43,
                      height: 43,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: ColorManager.tertiary),
                      child: SvgIcon(
                        'location-marker',
                        size: IconSizeManager.regular * 0.8,
                        color: ColorManager.primaryColor,
                      ),
                    ),
                    title: Text(prediction.description!),
                    titleTextStyle: GoogleFonts.quicksand(
                        color: ColorManager.primary,
                        fontSize: FontSizeManager.regular,
                        fontWeight: FontWeightManager.medium),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: SizeManager.medium,
                        vertical: SizeManager.regular * 0.8),
                    tileColor: Colors.transparent,
                  );
                },
                separatorBuilder: (context, index) => Divider(
                    thickness: index != predictions.length - 1 ? null : 0),
                itemCount: predictions.length)
        else
          const ErrorScreen(
            lottie: "search-map",
            label: "Search for a place 😀",
          )
      ]),
    );
  }

  Future<void> searchPlaceAutoComplete(String search) async {
    Uri uri = Uri.https(
        "maps.googleapis.com", // authority
        "maps/api/place/autocomplete/json", //unencoded path
        {"input": search, "key": ValuesManager.MAP_API_KEY});
    final queryJson = await NetworkService.getUri(uri: uri);

    if (queryJson != null) {
      PlaceAutoCompleteResponse response =
          PlaceAutoCompleteResponse.parseAutoCompleteResult(queryJson);

      if (response.predictions != null) {
        setState(() {
          predictions = response.predictions!;
        });
      }
    }
  }
}
