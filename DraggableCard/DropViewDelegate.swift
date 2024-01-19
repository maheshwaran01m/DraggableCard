//
//  DropViewDelegate.swift
//  DraggableCard
//
//  Created by MAHESHWARAN on 19/01/24.
//

import SwiftUI

struct DropViewDelegate<T: Hashable>: DropDelegate {
  
  let destinationItem: T
  @Binding var items: [T]
  @Binding var draggedItem: T?
  
  func dropUpdated(info: DropInfo) -> DropProposal? {
    .init(operation: .move)
  }
  
  func performDrop(info: DropInfo) -> Bool {
    draggedItem = nil
    return true
  }
  
  func dropEntered(info: DropInfo) {
    guard let draggedItem,
          let fromIndex = items.firstIndex(of: draggedItem),
          let toIndex = items.firstIndex(of: destinationItem),
          fromIndex != toIndex else {
      return
    }
    withAnimation {
      items.move(
        fromOffsets: .init(integer: fromIndex),
        toOffset: toIndex > fromIndex ? toIndex+1 : toIndex)
    }
  }
}
