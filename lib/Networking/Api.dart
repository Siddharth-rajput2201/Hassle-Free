class Api { 
  static String domain = "https://hassle-free.herokuapp.com";
  // static String domain = "http://127.0.0.1:5000/";

  //authentication auth / endpoint
  static String login = domain + '/auth/login';
  static String register = domain + '/auth/register';
  static String auth = domain + '/auth/verify';

  //data data / endpoint
  static String retrieve = domain + '/data/retrieve';
  static String decrypt = domain + '/data/decrypt';

  //add update delete

  // insert insert / endpoint
  static String add = domain + '/insert/insertpass';

  // delete delete / endpoint
  static String deletepass = domain + '/delete/deletepass';
  static String deleteaccount = domain + '/delete/delaccemail';

  // update update /  endpoint
  static String updatepassword = domain + '/update/updatepass'; 
  static String updateappname = domain + '/update/updateappname';
  static String updateappusername = domain + '/update/updateappusername';

  // email emailauth / endpoint
  static String resendEmail = domain + '/emailauth/resendemail';
}
