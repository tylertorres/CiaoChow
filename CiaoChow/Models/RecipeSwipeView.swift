import SwiftUI

struct RecipeSwipeView: View {
    @State private var recipes: [Recipe] = Recipe.sampleRecipes
    @State private var offset: CGSize = .zero
    @State private var currentRecipe: Recipe?
    
    var body: some View {
        VStack {
            recipeCards
            actionButtons
        }
        .onAppear { currentRecipe = recipes.first }
    }
    
    private var recipeCards: some View {
        ZStack {
            ForEach(recipes) { recipe in
                RecipeCard(recipe: recipe)
                    .offset(x: currentRecipe?.id == recipe.id ? offset.width : 0)
                    .rotationEffect(.degrees(Double(offset.width / 20)))
                    .gesture(dragGesture)
                    .zIndex(currentRecipe?.id == recipe.id ? 1 : 0)
            }
        }
        .padding()
    }
    
    private var actionButtons: some View {
        HStack {
            swipeButton(direction: .left)
            Spacer()
            swipeButton(direction: .right)
        }
        .padding(.horizontal, 50)
    }
    
    private var dragGesture: some Gesture {
        DragGesture()
            .onChanged { gesture in
                if currentRecipe != nil {
                    offset = gesture.translation
                }
            }
            .onEnded { _ in
                withAnimation {
                    swipeCard(width: offset.width)
                }
            }
    }
    
    private func swipeButton(direction: SwipeDirection) -> some View {
        Button(action: { swipeCard(width: direction == .left ? -500 : 500) }) {
            Image(systemName: direction == .left ? "xmark.circle.fill" : "heart.circle.fill")
                .foregroundColor(direction == .left ? .red : .green)
                .font(.system(size: 50))
        }
    }
    
    private func swipeCard(width: CGFloat) {
        guard currentRecipe != nil else { return }
        
        if abs(width) > 100 {
            vote(liked: width > 0)
        }
        
        withAnimation {
            offset = .zero
            removeCard()
        }
    }
    
    private func removeCard() {
        recipes.removeAll { $0.id == currentRecipe?.id }
        currentRecipe = recipes.first
    }
    
    private func vote(liked: Bool) {
        guard let recipe = currentRecipe else { return }
        print("Voted \(liked ? "like" : "dislike") for recipe: \(recipe.name)")
        // Here you would record the vote, e.g.:
        // saveVote(for: recipe.id, liked: liked)
    }
}

struct RecipeCard: View {
    let recipe: Recipe
    
    var body: some View {
        VStack {
            recipeImage
            recipeDetails
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
    
    private var recipeImage: some View {
        Group {
            if let imageURL = recipe.imageURL {
                AsyncImage(url: imageURL) { image in
                    image.resizable()
                } placeholder: {
                    Color.gray
                }
            } else {
                Color.gray
            }
        }
        .aspectRatio(contentMode: .fill)
        .frame(height: 300)
        .clipped()
    }
    
    private var recipeDetails: some View {
        VStack {
            Text(recipe.name)
                .font(.title)
                .padding()
            
            Text(recipe.description)
                .padding()
            
            Spacer()
        }
    }
}

enum SwipeDirection {
    case left, right
}

extension Recipe {
    static var sampleRecipes: [Recipe] {
        [
            Recipe(name: "Spaghetti Carbonara", description: "A classic Italian pasta dish...", ingredients: [], instructions: [], prepTime: 600, cookTime: 900, servings: 4, tags: ["Italian", "Pasta", "Quick"], imageURL: URL(string: "https://example.com/carbonara.jpg"), difficulty: .medium),
            Recipe(name: "Chicken Stir Fry", description: "A quick and healthy Asian-inspired dish...", ingredients: [], instructions: [], prepTime: 900, cookTime: 600, servings: 4, tags: ["Asian", "Quick", "Healthy"], imageURL: URL(string: "https://example.com/stirfry.jpg"), difficulty: .easy),
            Recipe(name: "Chocolate Chip Cookies", description: "Classic homemade cookies...", ingredients: [], instructions: [], prepTime: 1200, cookTime: 720, servings: 24, tags: ["Dessert", "Baking"], imageURL: URL(string: "https://example.com/cookies.jpg"), difficulty: .easy)
        ]
    }
}

#Preview {
    RecipeSwipeView()
}
