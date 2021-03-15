//
//  ToolView.swift
//  RockPaperScissors-HWS
//
//  Created by Nikola Anastasovski on 15.3.21.
//

import SwiftUI

struct ToolView: View {
    let imageName: String
    
    var assetsImageName: String {
        imageName.lowercased()
    }
    
    var body: some View {
        Image(assetsImageName)
            .resizable()
            .frame(width: 100, height: 100)
    }
}

struct ToolView_Previews: PreviewProvider {
    static var previews: some View {
        ToolView(imageName: "Rock")
    }
}
