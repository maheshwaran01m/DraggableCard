//
//  ContentView.swift
//  DraggableCard
//
//  Created by MAHESHWARAN on 19/01/24.
//

import SwiftUI

struct ContentView: View {
  
  @State private var records = (0...10).map { String("Item \($0)")}
  @State private var draggedItem: String?
  
  var body: some View {
    NavigationStack {
      dragView
        .navigationTitle("Draggable Cards")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(content: resetView)
    }
  }
  
  var dragView: some View {
    VStack {
      ForEach(records, id: \.self) { item in
        Text(item)
          .padding()
          .frame(maxWidth: .infinity)
          .background(Color.blue.opacity(0.2), in: Capsule())
          .onDrag({
            self.draggedItem = item
            return .init()
            
          }, preview: {  })
          .onDrop(
            of: [.text],
            delegate: DropViewDelegate(destinationItem: item, items: $records, draggedItem: $draggedItem))
      }
    }
  }
  
  @ToolbarContentBuilder
  private func resetView() -> some ToolbarContent {
    ToolbarItem(placement: .automatic) {
      Button("Reset") {
        records = (0...10).map { String("Item \($0)") }
      }
    }
  }
}



#Preview {
  ContentView()
}
