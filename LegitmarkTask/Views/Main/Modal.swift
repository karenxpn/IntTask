//
//  Modal.swift
//  LegitmarkTask
//
//  Created by Karen Mirakyan on 20.12.23.
//

import SwiftUI

struct Modal: View {
    
    @StateObject private var viewModel = ViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            
            VStack(alignment: .leading, spacing: 15) {
                
                TextHelper(text: "Details", fontSize: 16)
                    .fontWeight(.semibold)
                
                // pickers
                CustomPicker(selectedItem: $viewModel.selectedBrand,
                             items: viewModel.brands,
                             disabled: viewModel.brands.isEmpty,
                             placeholder: "Brand") { brand in
                    if let id = brand?.id {
                        viewModel.getBrandModels(id: id)
                    }
                }
                
                CustomPicker(selectedItem: $viewModel.selectedModel,
                             items: viewModel.models,
                             disabled: viewModel.models.isEmpty || viewModel.selectedBrand == nil,
                             placeholder: "Model") { _ in
                    
                }
                //optional textfields
                
                TextFieldHelper(placeholder: "Style (Optional)",
                                disabled: viewModel.selectedBrand == nil || viewModel.selectedModel == nil,
                                text: $viewModel.style)
                
                TextFieldHelper(placeholder: "SKU (Optional)",
                                disabled: viewModel.selectedBrand == nil || viewModel.selectedModel == nil,
                                text: $viewModel.sku)
                
                ButtonHelper(disabled: viewModel.selectedBrand == nil || viewModel.selectedModel == nil, label: "Save") {
                    dismiss()
                }
                
                Spacer()
                
            }.padding(16)
            
                .navigationTitle(Text(""))
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        TextHelper(text: "Item Details", fontSize: 28)
                            .fontWeight(.semibold)
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            dismiss()
                        } label: {
                            Image("close")
                        }
                        
                    }
                }.task {
                    viewModel.getBrands()
                }.alert("Error", isPresented: $viewModel.showAlert, actions: {
                    Button("Ok", role: .cancel) { }
                }, message: {
                    Text(viewModel.alertMessage)
                })
        }
    }
}

#Preview {
    Modal()
}
