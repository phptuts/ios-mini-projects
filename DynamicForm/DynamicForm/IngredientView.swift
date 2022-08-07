//
//  IngredientView.swift
//  DynamicForm
//
//  Created by Noah Glaser on 8/6/22.
//

import SwiftUI
import UIKit


struct IngredientView: View {
    @Binding var ingredient: Ingredient
                    
    private var onOrderChange: (UUID, Direction) -> Void
    
    private var onDelete: (UUID) -> Void
    
    private var isLastIngredient: Bool
    
    init (onOrderChange: @escaping (UUID, Direction) -> Void,
          onDelete: @escaping (UUID) -> Void,
          ingredient: Binding<Ingredient>,
          isLastIngredient: Bool) {
        self._ingredient = ingredient
        self.onOrderChange = onOrderChange
        self.onDelete = onDelete
        self.isLastIngredient = isLastIngredient
    }
    
    

    var body: some View {
        Section {
            TextField("Name", text: $ingredient.name)
                .submitLabel(.done)
            
            Picker("Unit", selection: $ingredient.unit) {
                ForEach(Unit.allCases, id: \.self) { unit in
                    Text(unit.rawValue)
                }
            }.pickerStyle(.segmented)
            HStack {
                Text(ingredient.unit.rawValue)
                TextField("Amount", value: $ingredient.amount, format: .number)
                    .keyboardType(.decimalPad)
            }
            
            HStack {
                    Image(systemName: "arrow.up.circle.fill")
                        .font(.largeTitle)
                        .foregroundColor(ingredient.order == 0 ? Color.gray : Color.black)
                        .allowsHitTesting(ingredient.order != 0)
                        .onTapGesture {
                            onOrderChange(ingredient.id, .up)
                        }
                Spacer()
                Image(systemName: "arrow.down.circle.fill")
                        .font(.largeTitle)
                        .allowsHitTesting(!isLastIngredient)
                        .foregroundColor(isLastIngredient ? Color.gray : Color.black)
                        .onTapGesture {
                            onOrderChange(ingredient.id, .down)
                        }
            }
            HStack {
                Spacer()
                Image(systemName: "trash.fill")
                        .foregroundColor(.red)
                        .font(.largeTitle)
                        .onTapGesture {
                            onDelete(ingredient.id)
                        }
              
                Spacer()
            }
        }
    }
    
}

struct IngredientView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientView(
            onOrderChange: { _, _ in }, onDelete: { _ in }, ingredient: .constant(Ingredient(name: "Eggs", unit: .cup, amount: 1, order: 0, id: UUID())), isLastIngredient: false)
    }
}
