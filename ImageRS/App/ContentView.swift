//
//  ContentView.swift
//  ImageRS
//
//  Created by Karthik Manishankar on 8/9/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var im: ImageModel
    

    var body: some View {
        NavigationView{
            VStack{
                VStack{
                if let image = im.image{
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .onAppear{
                            print("Data:" + mlStuff().detect(img: image))
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
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        Button {
                            im.source = .camera
                            im.showPPicker()
                        } label: {
                            Image(systemName: "camera.circle").resizable().frame(width: 50, height: 50, alignment: .center).padding(.bottom, 20)                        }
                    }
                    ToolbarItem(placement: .bottomBar) {
                        Button {
                            im.source = .library
                            im.showPPicker()

                        } label: {
                            Image(systemName: "photo.circle").resizable().frame(width: 50, height: 50, alignment: .center).foregroundColor(.red).padding(.bottom, 20)                        }
                    }
                }
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
