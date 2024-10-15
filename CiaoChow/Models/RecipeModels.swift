import Foundation

// MARK: - User Model
struct User: Identifiable, Codable {
    let id: UUID
    var name: String
    var email: String
    var sharedLists: [UUID] // IDs of SharedRecipeList the user is part of
}

// MARK: - Recipe Model
struct Recipe: Identifiable, Codable {
    let id: UUID
    var name: String
    var description: String
    var ingredients: [Ingredient]
    var instructions: [Instruction]
    var prepTime: TimeInterval
    var cookTime: TimeInterval
    var servings: Int
    var tags: Set<String>
    var imageURL: URL?
    var difficulty: Difficulty
    var nutritionalInfo: NutritionalInfo?
    
    // Nested enum for recipe difficulty
    enum Difficulty: String, Codable, CaseIterable {
        case easy, medium, hard
    }
    
    init(id: UUID = UUID(), name: String, description: String, ingredients: [Ingredient], instructions: [Instruction], prepTime: TimeInterval, cookTime: TimeInterval, servings: Int, tags: Set<String>, imageURL: URL? = nil, difficulty: Difficulty, nutritionalInfo: NutritionalInfo? = nil) {
        self.id = id
        self.name = name
        self.description = description
        self.ingredients = ingredients
        self.instructions = instructions
        self.prepTime = prepTime
        self.cookTime = cookTime
        self.servings = servings
        self.tags = tags
        self.imageURL = imageURL
        self.difficulty = difficulty
        self.nutritionalInfo = nutritionalInfo
    }
}

// MARK: - Ingredient Model
struct Ingredient: Identifiable, Codable, Hashable {
    let id: UUID
    var name: String
    var amount: Double
    var unit: Unit
    
    // Nested enum for ingredient units
    enum Unit: String, Codable, CaseIterable {
        case gram, kilogram, milliliter, liter, teaspoon, tablespoon, cup, piece
        
        var abbreviation: String {
            switch self {
            case .gram: return "g"
            case .kilogram: return "kg"
            case .milliliter: return "ml"
            case .liter: return "L"
            case .teaspoon: return "tsp"
            case .tablespoon: return "tbsp"
            case .cup: return "cup"
            case .piece: return "pc"
            }
        }
    }
    
    init(id: UUID = UUID(), name: String, amount: Double, unit: Unit) {
        self.id = id
        self.name = name
        self.amount = amount
        self.unit = unit
    }
}

// MARK: - Instruction Model
struct Instruction: Identifiable, Codable {
    let id: UUID
    var stepNumber: Int
    var description: String
    
    init(id: UUID = UUID(), stepNumber: Int, description: String) {
        self.id = id
        self.stepNumber = stepNumber
        self.description = description
    }
}

// MARK: - Nutritional Information Model
struct NutritionalInfo: Codable {
    var calories: Int
    var protein: Double
    var carbohydrates: Double
    var fat: Double
    
    init(calories: Int, protein: Double, carbohydrates: Double, fat: Double) {
        self.calories = calories
        self.protein = protein
        self.carbohydrates = carbohydrates
        self.fat = fat
    }
}

// MARK: - Shared Recipe List Model
struct SharedRecipeList: Identifiable, Codable {
    let id: UUID
    var name: String
    var members: [UUID] // User IDs
    var recipes: [UUID] // Recipe IDs
}

// MARK: - Vote Model
struct Vote: Identifiable, Codable {
    let id: UUID
    var userID: UUID
    var recipeID: UUID
    var liked: Bool
    var timestamp: Date
}

// MARK: - Weekly Menu Model
struct WeeklyMenu: Identifiable, Codable {
    let id: UUID
    var sharedListID: UUID
    var weekStartDate: Date
    var recipes: [WeekDay: UUID]
}

// MARK: - Weekday Enum
enum WeekDay: String, Codable, CaseIterable {
    case monday, tuesday, wednesday, thursday, friday
}