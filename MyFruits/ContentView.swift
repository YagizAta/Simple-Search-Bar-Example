//
//  ContentView.swift
//  MyFruits
//
//  Created by Yaฤฤฑz Ata รzkan on 4.05.2021.
//

import SwiftUI

struct ContentView: View {
    
    @State var searchText = ""
    @State var searching = false
    let myFruits = [
             "Apple ๐", "Banana ๐", "Blueberry ๐ซ", "Strawberry ๐", "Avocado ๐ฅ", "Cherries ๐", "Mango ๐ฅญ", "Watermelon ๐", "Grapes ๐", "Lemon ๐"
         ]
    
    var body: some View {
        NavigationView{
            VStack (alignment : .leading){
                SearchBar(searchText: $searchText,searching: $searching)
                    List{
                        ForEach(myFruits.filter({ (fruit: String) -> Bool in
                            return fruit.hasPrefix(searchText) ||ย searchText == ""
                        }) , id : \.self )ย { fruit in
                            Text(fruit)
                            
                        }
                        .gesture(DragGesture()
                                    .onChanged({ _ in
                                        UIApplication.shared.dismissKeyboard()
                                    }))
                    }
                    
                
                .listStyle(GroupedListStyle())
                .navigationTitle(searching ? "Searching" : "MyFruits")
                .toolbar {
                            if searching {
                                Button("Cancel") {
                                    searchText = ""
                                    withAnimation {
                                        searching = false
                                        UIApplication.shared.dismissKeyboard()
                                    }
                                    }
                                }
                            }
            }
        }
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
extension UIApplication {
      func dismissKeyboard() {
          sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
      }
  }
struct SearchBar: View {
    @Binding var searchText: String
    @Binding var searching : Bool
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color("LightGray"))
            HStack{
                Image(systemName: "magnifyingglass")
                TextField("Search ..", text: $searchText){
                    startedEditing in
                    if startedEditing {
                        withAnimation {
                                     searching = true
                                 }
                    }
                    
                }
                onCommit: {
                    withAnimation {
                        searching = false
                    }
                }
            }
            .foregroundColor(.gray)
            .padding(.leading , 13)
            
        }
        .frame(height: 40)
        .cornerRadius(13)
        .padding()
    }
}

