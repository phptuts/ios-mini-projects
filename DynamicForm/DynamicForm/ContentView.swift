//
//  ContentView.swift
//  DynamicForm
//
//  Created by Noah Glaser on 8/6/22.
//

import SwiftUI

// https://www.hackingwithswift.com/forums/swiftui/textfield-dismiss-keyboard-clear-button/240
extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct ContentView: View {
    
    
    @State var recipe = Recipe(name: "", description: "", ingredients: [
        Ingredient(name: "", unit: .cup, amount: 1, order: 0, id: UUID())
    ], id: UUID())
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name", text: $recipe.name)
                        .submitLabel(.done)
                }
                Section("Description") {
                    TextEditor(text: $recipe.description)
                        .textFieldStyle(.roundedBorder)
                        .submitLabel(.done)
                }
                
                Button("Add Ingredient") {
                    withAnimation(.easeIn) {
                        recipe.addIngredient()
                    }
                }
                ForEach(recipe.sortedIngredients, id: \.id) {
                    ingredient in
                    let index = recipe.sortedIngredients.firstIndex(of: ingredient) ?? 0
                    IngredientView(onOrderChange: onChange, onDelete: onDelete, ingredient: $recipe.sortedIngredients[index], isLastIngredient: index + 1 == recipe.ingredients.count)
                }
            }
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    HStack {
                        Spacer()
                        Button("Done") {
                            UIApplication.shared.endEditing()
                        }
                    }
                    
                    
                }
            }
            .navigationTitle("Recipe Form")
        }
    }
    
    func onChange(id: UUID, direction: Direction) {
        withAnimation(.easeIn) {
            recipe.move(move: id, direction: direction)
        }
    }
    
    func onDelete(id: UUID) {
        withAnimation(.easeOut) {
            recipe.delete(id)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
