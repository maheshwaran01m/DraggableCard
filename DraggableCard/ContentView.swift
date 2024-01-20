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
  
  // MARK: - DragView
  
  var dragView: some View {
    VStack {
      ForEach(records, id: \.self) { item in
        Text(item)
          .padding()
          .frame(maxWidth: .infinity)
          .background(Color.blue.opacity(0.2), in: Capsule())
          .contentShape(.dragPreview, Capsule())
          .onDrag({ onDragView(item) }, preview: previewItemView)
          .onDrop(
            of: [.text],
            delegate: DropViewDelegate(destinationItem: item, items: $records, draggedItem: $draggedItem))
      }
    }
  }
  
  private func onDragView(_ item: String) -> NSItemProvider {
    self.draggedItem = item
    return .init()
  }
  
  // MARK: - Drag Preview
  
  private func previewItemView() -> some View {
    Color.clear
      .contentShape(.dragPreview, Circle())
      .frame(width: 1, height: 1)
  }
  
  // MARK: - ResetView
  
  @ToolbarContentBuilder
  private func resetView() -> some ToolbarContent {
    ToolbarItem(placement: .automatic) {
      Button("Reset") {
        records = (0...10).map { String("Item \($0)") }
      }
    }
  }
}

// MARK: - Preview

#Preview {
  ContentView()
}
