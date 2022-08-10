//
//  ContentView.swift
//  ImageRS
//
//  Created by Karthik Manishankar on 8/9/22.
//

import SwiftUI


struct ContentView: View {
    @EnvironmentObject var im: ImageModel
    @State var stg: String = ""

    var body: some View {
        NavigationView{
            VStack{
                
                HStack(alignment: .center, spacing: 3, content: {
                    
                    
                    NavigationLink(destination: WebView(url: URL(string: "https://www.google.com/search?tbm=shop&hl=en&psb=1&q=\(stg)")!), label: {
                        Image(systemName: "magnifyingglass.circle").resizable().frame(width: 50, height: 50, alignment: .center).padding(.bottom, 20).foregroundColor(.red)
                        
                    }).padding()
                    
                    Spacer()
                    
                    Button {
                        stg = ""
                        im.source = .camera
                        im.showPPicker()
//                        if let image = im.image{
//                            stg = mlStuff().detect(img: image)
//                            print("STG: " + stg)
//                        }

                    } label: {
                        Image(systemName: "camera.circle").resizable().frame(width: 50, height: 50, alignment: .center).padding(.bottom, 20)
                        
                    }.padding()
                }
                
                
                )
                
                VStack{
                if let image = im.image{
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(minWidth: 0, maxWidth: 250, minHeight: 0, maxHeight: 250)
                        .onAppear{
                            stg = mlStuff().detect(img: image)
                            print("Data:" + stg)
                        }
                }
                else{
                    Image(systemName: "photo.fill")
                        .resizable()
                        .scaledToFit()
                        .opacity(0.6)
                        .frame(minWidth: 0, maxWidth: 250, minHeight: 0, maxHeight: 250)
                        .padding(.horizontal)
                    
                }
                Spacer()
                    
                }
                .sheet(isPresented: $im.showPicker, content: {
                    ImagePicker(sourceType: im.source == .library ? .photoLibrary :.camera, selectedImage: $im.image)
                })
                .navigationTitle("ImageRS")
                .navigationBarTitleDisplayMode(.large)
        }
    }
}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ImageModel())
        
    }
}
