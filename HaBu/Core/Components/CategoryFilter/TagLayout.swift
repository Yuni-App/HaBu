//
//  TagLayout.swift
//  HaBu
//
//  Created by OmerErbalta on 25.11.2023.
//

import SwiftUI
    struct TagLayout: Layout {
        var alignment: Alignment = .center
        var spacing : CGFloat = 10
        func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
            let maxWidth = proposal.width ?? 0
            var height : CGFloat = 0
            let col = generateRows(maxWidth, proposal, subviews)
            
            for (index,row) in col.enumerated(){
                if (index == row.count - 1){
                    
                }
                else{
                    height += row.maxHeight(proposal) + spacing
                }
            }
            return .init(width: maxWidth, height: height)
        }
        
        func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
            var origin = bounds.origin
            let maxWidth = bounds.width
            let col = generateRows(maxWidth, proposal, subviews)
            for row in col{
                let leading: CGFloat =  bounds.maxX - maxWidth
                let trailing = bounds.maxX - ( row.reduce(CGFloat.zero) { partialResult, view in
                    let width = view.sizeThatFits(proposal).width
                    if view == row.last{
                        return partialResult + width
                    }
                    else{
                        return partialResult + width + spacing
                    }
                })
                let center = (trailing + leading) / 2
                
                
                origin.x = (alignment == .leading ? leading : alignment == .trailing ? trailing : center)
                for view in row{
                    let viewSize = view.sizeThatFits(proposal)
                    view.place(at: origin, proposal: proposal)
                    origin.x += (viewSize.width + spacing)
                }
                origin.y += (row.maxHeight(proposal) + spacing)
            }
        }
        
        func generateRows(_ maxWidth : CGFloat, _ proposal : ProposedViewSize, _ subviews : Subviews) -> [[Layout.Subviews.Element]]{
            var row : [LayoutSubviews.Element] = []
            var col : [[LayoutSubviews.Element]] = []
            
            var origin  = CGRect.zero.origin
            for view in subviews{
                let viewSize = view.sizeThatFits(proposal)
                if (origin.x + viewSize.width + spacing) > maxWidth{
                    col.append(row)
                    row.removeAll()
                    origin.x = 0
                    row.append(view)
                    origin.x += (viewSize.width + spacing)
                }
                else{
                    row.append(view)
                    origin.x += (viewSize.width + spacing)
                }
            }
            
            if !row.isEmpty{
                col.append(row)
                row.removeAll()
            }
            return col
        }
}






