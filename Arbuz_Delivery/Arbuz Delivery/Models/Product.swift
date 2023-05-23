import Foundation

enum ProductType {
    case dairy
    case fruit
    case vegetable
}

enum OriginCountry: String {
    case kazakhstan = "Казахстан"
    case china = "Китай"
    case russia = "Россия"
}

enum MeasureUnit: String {
    case millilitre = "мл"
    case litre = "л"
    case gram = "г"
    case kilogram = "кг"
    case piece = "шт"
}

class Product {
    var id: Int
    var name: String
    var type: ProductType
    var description: String
    var price: Int
    var origin: OriginCountry
    var weight: Int
    var measure: MeasureUnit
    var imageName: String
    var isAvailable: Bool
    var chosenAmount: Int
    
    init(id: Int, name: String, type: ProductType, description: String, price: Int, origin: OriginCountry, weight: Int, measure: MeasureUnit, imageName: String, isAvailable: Bool, chosenAmount: Int) {
        self.id = id
        self.name = name
        self.type = type
        self.description = description
        self.price = price
        self.origin = origin
        self.weight = weight
        self.measure = measure
        self.imageName = imageName
        self.isAvailable = isAvailable
        self.chosenAmount = chosenAmount
    }
}
