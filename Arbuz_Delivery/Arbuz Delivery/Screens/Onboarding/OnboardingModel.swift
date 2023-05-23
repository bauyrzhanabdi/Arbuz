import Foundation

class OnboardingModel {
    
    func createModels() -> [Onboarding] {
        return [
            Onboarding(
                index: 0,
                title: "Добро пожаловать",
                description: "Давай ознакомимся с условиями подписки.",
                imageName: "onboarding0.jpeg"
            ),
            Onboarding(
                index: 1,
                title: "Привет",
                description: "Давай ознакомимся с условиями подписки.",
                imageName: "onboarding0.jpeg"
            ),
            Onboarding(
                index: 2,
                title: "Салем",
                description: "Давай ознакомимся с условиями подписки.",
                imageName: "onboarding0.jpeg"
            )
        ]
    }
}
