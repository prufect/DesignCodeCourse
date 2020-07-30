//
//  CoursesView.swift
//  DesignCodeCourse
//
//  Created by Prudhvi Gadiraju on 7/29/20.
//

import SwiftUI

struct CoursesView: View {
    
    @State private var show: Bool = false
    @State private var selectedItem: Course? = nil
    @State private var isDisabled: Bool = false
    @Namespace var namespace
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 20.0) {
                    ForEach(courses) { item in
                        CourseItem(course: item)
                            .matchedGeometryEffect(id: item.id, in: namespace, isSource: !show)
                            .frame(width: 335, height: 250)
                            .onTapGesture { withAnimation(.spring()) {
                                show.toggle()
                                selectedItem = item
                                isDisabled = true
                            }}
                            .disabled(isDisabled)
                    }
                }.frame(maxWidth: .infinity)
            }
            if selectedItem != nil {
                ScrollView {
                    CourseItem(course: selectedItem!)
                        .matchedGeometryEffect(id: selectedItem!.id, in: namespace)
                        .frame(height: 300)
                        .onTapGesture { withAnimation(.spring()) {
                            show.toggle()
                            selectedItem = nil
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                isDisabled = false
                            }
                        }}
                    VStack(spacing: 4.0) {
                        ForEach(0 ..< 5) { item in
                            CourseRow()
                        }
                    }.padding()
                }
                .background(Color("Background 1"))
                .transition(.move(edge: .bottom))
//                .transition(
//                    .asymmetric(
//                        insertion: AnyTransition.opacity.animation(
//                            Animation.spring().delay(0.3)),
//                        removal: AnyTransition.opacity.animation(.spring())))
                    
                .edgesIgnoringSafeArea(.all)
            }
        }
    }
}

struct CoursesView_Previews: PreviewProvider {
    static var previews: some View {
        CoursesView()
    }
}
