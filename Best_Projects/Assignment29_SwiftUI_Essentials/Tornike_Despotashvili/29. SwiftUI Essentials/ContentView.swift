//
//  ContentView.swift
//  29. SwiftUI Essentials
//
//  Created by Despo on 09.12.24.
//

import SwiftUI

struct FieldModel: Identifiable {
    let id = UUID()
    let label: String
    let placeholder: String
    var value: String
}

struct ContentView: View {
    @State private var fieldsArray: [FieldModel] = [
        FieldModel(label: "Company", placeholder: "Enter Company Name", value: ""),
        FieldModel(label: "Role", placeholder: "Enter Role", value: ""),
        FieldModel(label: "Duration", placeholder: "Enter Duration", value: ""),
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 23) {
                VStack(spacing: 15) {
                    Image("hablo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 102, height: 102)
                        .clipShape(Circle())
                        .padding(10)
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 5)
                        .padding(.horizontal, 5)
                    
                    Text("Hablo Escobar")
                        .styledText(24, .black, .semibold)
                    
                    Text("iOS Developer | Swift Enthusiast | Tech Lover")
                        .styledText(15, .secondaryCol, .semibold)
                }
                
                VStack(alignment: .leading, spacing: 23) {
                    Text("Work Experience")
                        .styledText(17, .black, .semibold)
                        .padding(.leading, 13)
                    
                    LazyVStack {
                        VStack(alignment: .leading, spacing: 6) {
                            Text("HDR Solutions Inc.")
                                .styledText(17, .black, .semibold)
                            
                            Text("iOS Developer")
                                .styledText(15, .secondaryCol, .light)
                            
                            Text("2021 - Present")
                                .styledText(15, .secondaryCol, .light)
                        }
                        .styledBox()
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Add New Working Experience:")
                            .styledText(17, .black, .semibold)
                        
                        LazyVStack(spacing: 8) {
                            ForEach($fieldsArray) { $field in
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(field.label)
                                        .styledText(9, .secondaryCol, .regular)
                                        .textCase(.uppercase)
                                        .kerning(3)
                                    
                                    TextField(field.placeholder, text: $field.value)
                                        .styledField()
                                }
                            }
                        }
                        
                        
                        Button("Add Experience", action: {})
                            .frame(maxWidth: .infinity)
                            .frame(height: 40)
                            .background(.buttonGreen)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .padding(.top)
                            .foregroundStyle(Color.white)
                    }
                    .styledBox()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding(.horizontal, 30)
        .padding(.vertical, 25)
    }
}

#Preview {
    ContentView()
}
