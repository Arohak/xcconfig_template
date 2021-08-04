//
//  Views.swift
//  xcconfig_template
//
//  Created by Ara Hakobyan on 11.06.21.
//  Copyright © 2021 Ara Hakobyan. All rights reserved.
//

import UIKit

enum Views { }

extension Views {
    static func background(color: UIColor) -> UIView {
        let view = UIView()
        view.backgroundColor = color
        return view
    }
    
    enum Cards {
        static func image() -> UIImageView {
            let view = UIImageView()
            view.contentMode = .scaleAspectFit
            return view
        }
        static func title() -> UILabel {
            let view = UILabel()
            view.textAlignment = .center
            return view
        }
        static func button() -> Button {
            let view = Button()
            view.backgroundColor = .orange
            return view
        }
    }
    
    enum Hero {
        static func title() -> UILabel {
            let view = UILabel()
            view.textAlignment = .center
            view.textColor = .gray
            return view
        }
    }
}

extension Views {
    enum Layout {
        static func makeWine(background: UIView, cardItems: [UIView], footer: UIView) -> UIView {
            let inset: CGFloat = 20
            let view = UIView()
            
            view.addSubview(background)
            background.anchors(top: .init(anchor: view.topAnchor),
                               left: .init(anchor: view.leftAnchor),
                               right: .init(anchor: view.rightAnchor),
                               bottom: .init(anchor: view.bottomAnchor))
            
            let stackView = makeStack(items: cardItems, axis: .vertical, spacing: inset)
            background.addSubview(stackView)
            stackView.anchors(top: .init(anchor: background.topAnchor, constant: 2*inset),
                              left: .init(anchor: background.leftAnchor, constant: 2*inset),
                              right: .init(anchor: background.rightAnchor, constant: 2*inset))
            
            background.addSubview(footer)
            footer.anchors(top: .init(anchor: stackView.bottomAnchor, constant: inset),
                           left: .init(anchor: background.leftAnchor, constant: inset),
                           right: .init(anchor: background.rightAnchor, constant: inset),
                           height: 50)
            
            return view
        }
        
        static func makeHero(background: UIView, items: [UIView]) -> UIView {
            let inset: CGFloat = 10
            let view = UIView()
            
            view.addSubview(background)
            background.anchors(top: .init(anchor: view.topAnchor),
                               left: .init(anchor: view.leftAnchor),
                               right: .init(anchor: view.rightAnchor),
                               bottom: .init(anchor: view.bottomAnchor))
            
            let stackView = makeStack(items: items, axis: .horizontal, spacing: inset)
            background.addSubview(stackView)
            stackView.anchors(top: .init(anchor: background.topAnchor, constant: inset),
                              left: .init(anchor: background.leftAnchor, constant: inset),
                              right: .init(anchor: background.rightAnchor, constant: inset),
                              bottom: .init(anchor: background.bottomAnchor, constant: inset))
            
            return view
        }
        
        static func makeStack(items: [UIView], axis: NSLayoutConstraint.Axis, spacing: CGFloat = 0) -> UIView {
            let stackView = UIStackView()
            stackView.axis = axis
            stackView.spacing = spacing
            items.forEach { stackView.addArrangedSubview($0) }
            return stackView
        }
    }
}

extension Views {
    class Button: UIButton {
        var action: (() -> ())?
        
        override init(frame: CGRect) {
            super.init(frame: .zero)
            addTarget(self, action: #selector(tapAction), for: .touchUpInside)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        @objc private func tapAction() {
            action?()
        }
    }
}
