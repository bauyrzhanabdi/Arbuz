import Foundation

final class PasswordValidator {
    
    static var shared = PasswordValidator()

    func isValid(password: String) -> Bool {
        
        /// list of regex rules for strong password
        let uppercaseLetter: String = "(?=.*[A-Z])"
        let lowercaseLetter: String = "(?=.*[a-z])"
        let digit: String = "(?=.*[0-9])"
        let specialCharacter: String = "(?=.*[!#$%&'()\\*+,-./:;<=>?@^_`{|}~\\[\\]\"\\\\])"
        let noSpace: String = "(?!.*[\\s])"
        
        /// minMaxSymbols should be in the end as per regex syntax
        let minMaxSymbols: String = ".{8,64}"

        let passwordShouldContain = uppercaseLetter + lowercaseLetter + digit + specialCharacter + noSpace + minMaxSymbols
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordShouldContain)
        return passwordPredicate.evaluate(with: password)
    }
    
    func assertEqual(password: String, confirmPassword: String) -> Bool {
        return password == confirmPassword
    }
    
}
