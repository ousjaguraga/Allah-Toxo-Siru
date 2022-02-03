//
//  ContentView.swift
//  Shared
//
//  Created by Ovenger on 28/01/2022.
//

import SwiftUI

struct ContentView: View {
    
   @ObservedObject var vm = NameVM()
    var names = ["Allah", "Ahad", "One", "MAalikul Mulk"]
    var body: some View {
        ScrollView {
            VStack {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 200))]) {
                    ForEach(vm.names){ n in
                        NameView(name: n)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                vm.touched(n.id)
                            }
                            
                    }
                }
            }.padding()
                
           
        }
    }
}

struct ContextView: View {
    var name: NameModel.Name
    
    var body: some View {
        GeometryReader { geometry in
            Spacer()
            ZStack {
                let shape = RoundedRectangle(cornerRadius: 10)
                shape.fill(name.touched ?  .primaryLight : Color.accentColor)
                shape.strokeBorder(lineWidth: 3).foregroundColor(.green)
            }
        }
    }
}




struct Player: View {
    var body: some View {
        Image(systemName: "play").font(Font.system(size: 30))
    }
}
struct NameView: View {
    var name: NameModel.Name
    
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: 10)
               
                shape.fill(name.touched ?  .primaryLight : Color.accentColor)
                shape.strokeBorder(lineWidth: 3).foregroundColor(.green)
                VStack {
                    
                    ZStack {
                        
                        Star(corners: 5, smoothness: 0.43).frame(width: min(geometry.size.width , geometry.size.width) * 0.223, height: min(geometry.size.width , geometry.size.width) * 0.223)
                            .foregroundColor(.green)
                        
                        Circle().strokeBorder(.white).frame(width: geometry.size.width / 4.3, height: geometry.size.height / 4.3)
                        
                       
                        Text(String(name.id)).font(.system(size: min(geometry.size.width, geometry.size.height) * DrawingConstants.scaleFactor))
                    }
                    Spacer()
                    Text(name.arabic).font(.system(size: min(geometry.size.width, geometry.size.height) * 0.26)).foregroundColor(.green)
                    Player()
                    Spacer()
                    
                    ForEach(name.name){ name in
                        
                        Text(name).font(.system(size: min(geometry.size.width, geometry.size.height) * DrawingConstants.scaleFactor))
                        Divider().background(Color.white).padding(.top, 0)
                        
                    }
                      .foregroundColor(.white)
                }.padding()
                    
                
            }
        }
        
    }
}
struct DrawingConstants {
    static var borderColor: Color = .green
    static var scaleFactor: CGFloat = 0.079
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
