class UserProfile {
  static var _username;
   static var _email;
   static var _permission;
   static var _token;

  static get username => _username;

  static set username(value) {
    _username = value;
  }

  static get email => _email;

  static get token => _token;

  static set token(value) {
    _token = value;
  }

  static get permission => _permission;

  static set permission(value) {
    _permission = value;
  }

  static set email(value) {
    _email = value;
  }
}
