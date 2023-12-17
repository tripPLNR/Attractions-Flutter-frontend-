class APIEndpoint{

  /// authentication
  static String registerWithEmailAndPassword='/api/auth/register';
  static String loginWithEmailAndPassword='/api/auth/login';
  static String forgetPassword='/api/auth/forgot-password';
  static String socialLogin='/api/auth/social-oauth2';

  /// home screen
  static String getPopularGateways='/api/products/popular-gateways';
  static String getPopularGatewaysDetail='/api/products/gateway';
  static String getUncoverMore='/api/products/uncover';
  static String getGuidedTours='/api/tags/guided_tours';
  static String getNearbySites='/api/products/location';
  static String getNearbySitesByLatLong='/api/destinations/search-by-long-lat';





  static String getSiteSeeingTours='/api/products/sightseeing-tours';
  static String getTopActivities='/api/tags/top-activites';
  static String getTopActivityDetail='/api/tags/single-activity';

  static String getAttractionWorldWide='/api/products/attractions';
  static String getWaterAdventures='/api/products/water-adventures';
  static String getExploreMore='/api/products/explore';
  static String getSimilarProducts='/api/products/similar-products';
  static String getWishList='/api/wishlist';
  static String addToWishList='/api/wishlist';
  static String getSearchSuggestions='/api/destinations/search-cities-countries';
  static String filterActivities='/api/products/all';
  static String getReviews='/api/products/product/reviews';
  static String changePassword='/api/auth/change-password';













}