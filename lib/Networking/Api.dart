class Api {
  static String domain = "https://hassle-free.herokuapp.com";
  // static String domain = "http://192.168.1.26:5000";

  //authentication
  static String login = domain + '/login';
  static String register = domain + '/register';
  static String auth = domain + '/auth';

  //data
  static String retrieve = domain + '/retrieve';
  static String decrypt = domain + '/decrypt';

  //add update delete
  static String add = domain + '/insertpassword';
  static String delete = domain + '/delete';
  static String updatepassword = domain + '/updatepassword'; 
  static String updateappname = domain + '/updateappname';
  static String updateappusername = domain + '/updateappusername';
}
