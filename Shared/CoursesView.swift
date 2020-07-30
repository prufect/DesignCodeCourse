//
//  CoursesView.swift
//  DesignCodeCourse
//
//  Created by Prudhvi Gadiraju on 7/29/20.
//

import SwiftUI

struct CoursesView: View {
    
    @State private var show: Bool = false
    
    var body: some View {
        ZStack {
            CourseItem()
                .frame(width: 335, height: 250)
            VStack {
                if show {
                    CourseItem()
                        .transition(.move(edge: .leading))
                        .edgesIgnoringSafeArea(.all)
                }
            }
        }.onTapGesture { withAnimation(.spring()) { show.toggle() }}
    }
}

struct CoursesView_Previews: PreviewProvider {
    static var previews: some View {
        CoursesView()
    }
}
