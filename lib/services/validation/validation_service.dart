
abstract class ValidationService {
   String validateUserUsername(String username);
   String validateUserPassword(String password);
   bool isUsernameAllowedLength(String username);
   bool isUsernameAllowedCharacters(String username);
   bool isPasswordAllowedLength(String password);
   String validateEmail(String email) ;
}