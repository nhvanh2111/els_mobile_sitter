import 'package:elssit/core/models/rating_model/rating_data_model.dart';

abstract class RatingState{

}
class OtherRatingState extends RatingState{}
class GetAllRatingState extends RatingState{
  GetAllRatingState({required this.ratingData});
  final RatingDataModel ratingData;
}