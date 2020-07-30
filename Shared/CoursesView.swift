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
            #if os(iOS)
            content
                .navigationBarHidden(true)
            fullContent
                .background(VisualEffectBlur(blurStyle: .systemMaterial).edgesIgnoringSafeArea(.all))
            #else
            content
            fullContent
                .background(VisualEffectBlur().edgesIgnoringSafeArea(.all))
            #endif
        }
        
        .navigationBarTitle("Courses")
    }
    
    
    var content: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 160))], spacing: 16) {
                ForEach(courses) { item in
                    VStack {
                        CourseItem(course: item)
                            .matchedGeometryEffect(id: item.id, in: namespace, isSource: !show)
                            .frame(height: 200)
                            .onTapGesture { withAnimation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0)) {
                                show.toggle()
                                selectedItem = item
                                isDisabled = true
                            }}
                            .disabled(isDisabled)
                    }
                    .matchedGeometryEffect(id: "container\(item.id)", in: namespace, isSource: !show)

                }
            }
            .padding()
            .frame(maxWidth: .infinity)
        }
        .zIndex(1)
    }
    
    @ViewBuilder
    var fullContent: some View {
        if selectedItem != nil {
            ZStack(alignment: .topTrailing) {
                CourseDetail(course: selectedItem!, namespace: namespace)
                
                CloseButton()
                    .padding(16)
                    .onTapGesture { withAnimation(.spring()) {
                        show.toggle()
                        selectedItem = nil
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            isDisabled = false
                        }
                    }}
            }
            .zIndex(2)
            .frame(maxWidth: 712)
            .frame(maxWidth: .infinity)
        }
    }
}

struct CoursesView_Previews: PreviewProvider {
    static var previews: some View {
        CoursesView()
    }
}
