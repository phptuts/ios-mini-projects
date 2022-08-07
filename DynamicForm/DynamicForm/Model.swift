//
//  Model.swift
//  DynamicForm
//
//  Created by Noah Glaser on 8/6/22.
//

import Foundation

struct Recipe {
    var name: String
    var description: String
    var ingredients: [Ingredient]
    var id: UUID
    
    var sortedIngredients: [Ingredient] {
        get {
            ingredients.sorted(by: { $0.order < $1.order })
        }
        set {
            ingredients.removeAll()
            newValue.forEach { c in
                ingredients.append(c)
            }
        }
    }
    
    mutating func move(move id: UUID, direction: Direction) {
        guard var selectedIngredient = ingredients.first(where: { $0.id == id }) else { return }
        let swapOrder = selectedIngredient.order + ((direction == .up) ? -1 : 1)
        guard var swapIngredient = ingredients.first(where: { swapOrder == $0.order }) else { return }
        swapIngredient.order = selectedIngredient.order
        selectedIngredient.order = swapOrder
        ingredients = ingredients.filter({ $0.id != swapIngredient.id && $0.id != selectedIngredient.id })
        ingredients.append(swapIngredient)
        ingredients.append(selectedIngredient)
    }
    
    mutating func delete(_ id: UUID) {
        ingredients = ingredients.filter({ $0.id != id })
        sortedIngredients = sortedIngredients.enumerated().map {
            index, ingredient in
            return Ingredient(name: ingredient.name, unit: ingredient.unit, amount: ingredient.amount, order: index, id: ingredient.id)
        }
    }
    
    mutating func addIngredient() {
        ingredients = ingredients.map {
            return Ingredient(name: $0.name, unit: $0.unit, amount: $0.amount, order: $0.order + 1, id: $0.id)
        }
        
        ingredients.append(Ingredient(name: "", unit: .cup, amount: 1, order: 0, id: UUID()))
    }
}

enum Unit: String, CaseIterable {
    case cup = "Cups"
    case ounces = "Ounces"
    case pounds = "Pounds"
    case item = "Items"
}

enum Direction {
    case up, down
}

struct Ingredient: Equatable, Identifiable {
    var name: String
    var unit: Unit
    var amount: Double
    var order: Int
    var id: UUID
    
    
}
