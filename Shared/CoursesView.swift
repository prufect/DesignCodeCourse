//
//  CoursesView.swift
//  DesignCodeCourse
//
//  Created by Prudhvi Gadiraju on 7/29/20.
//

import SwiftUI

struct CoursesView: View {
    
    @State private var show: Bool = false
    @Namespace var namespace
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 20.0) {
                    CourseItem()
                        .matchedGeometryEffect(id: "Card", in: namespace, isSource: !show)
                        .frame(width: 335, height: 250)
                    
                    CourseItem()
                        .frame(width: 335, height: 250)
                }.frame(maxWidth: .infinity)
            }
            if show {
                ScrollView {
                    CourseItem()
                        .matchedGeometryEffect(id: "Card", in: namespace)
                        .frame(height: 300)
                    VStack(spacing: 4.0) {
                        ForEach(0 ..< 5) { item in
                            CourseRow()
                        }
                    }.padding()
                }
                .background(Color("Background 1"))
                .transition(
                    .asymmetric(
                        insertion: AnyTransition.opacity.animation(
                            Animation.spring().delay(0.3)),
                        removal: AnyTransition.opacity.animation(.spring())))
                    
                .edgesIgnoringSafeArea(.all)
            }
        }.onTapGesture { withAnimation(.spring()) { show.toggle() }}
    }
}

struct CoursesView_Previews: PreviewProvider {
    static var previews: some View {
        CoursesView()
    }
}
