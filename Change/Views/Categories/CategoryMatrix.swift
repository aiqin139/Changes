//
//  CategoryMatrix.swift
//  Change
//
//  Created by aiqin139 on 2021/1/28.
//

import SwiftUI

struct CategoryMatrix: View {
    var body: some View {
        CategoryRow(
            items: Array(derivedHexagrams.prefix(4)))
    }
}

struct CategoryMatrix_Previews: PreviewProvider {
    static var previews: some View {
        CategoryMatrix()
    }
}
