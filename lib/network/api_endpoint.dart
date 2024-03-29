class APIEndpoint {
  /// authentication
  static String registerWithEmailAndPassword = '/auth/register';
  static String loginWithEmailAndPassword = '/auth/login';
  static String forgetPassword = '/auth/forget-password';
  static String verifyOTP = '/auth/verify-otp';
  static String resetPassword = '/auth/reset-password';
  static String socialLogin = '/auth/social-login';

  /// home screen
  static String getHomeData = '/products/home-screen';
  static String getPopularDestinations = '/products/home-screen-popular-destinations';
  static String getPopularGatewaysDetail = '/products/popular-destination-details';
  static String getUncoverMore = '/products/uncover-more';
  static String getGuidedTours = '/products/guided-private-tours';
  static String getNearbySites = '/api/products/location';
  static String getNearbyAttractions = '/products/near-by-attractions';
  static String getSitesOfCity = '/products/search-by-location';
  static String searchByCityCountry = '/products/search-by-city-country';

  static String getSiteSeeingTours = '/products/home-screen-sightseeing-tours';
  static String getTopActivities = '/products/home-screen-top-activities';
  static String getTopActivityDetail = '/products/top-activity-products-details';
  static String getPopularDestinationTopActivityDetail = '/products/popular-destionation-activity-details';


  static String getAttractionWorldWide = '/products/home-screen-world-wide-attractions';
  static String getWaterAdventures = '/products/home-screen-water-adventures';
  static String getExploreMore = '/products/explore-more';
  static String getSimilarProducts = '/products/similar-products';
  static String getWishList = '/products/wishlist';
  static String addToWishList = '/products/wishlist';
  static String getSearchSuggestions = '/products/search-by-city-country';
  static String filterActivities = '/api/products/all';
  static String getReviews = '/api/products/product/reviews';
  static String changePassword = '/auth/update-password';
  static String deleteAccount = '/auth/delete-profile';
  static String getSiteById = '/products/product-detail';
  static String checkAvailability = '/products/availability-check';
  static String changeCurrency = '/api/products/set-application-currency-type';
}
