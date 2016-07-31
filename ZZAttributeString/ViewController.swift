//
//  ViewController.swift
//  ZZAttributeString
//
//  Created by duzhe on 16/7/31.
//  Copyright © 2016年 dz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var demoLabel:UILabel!
    @IBOutlet weak var linkLabel:UILabel!
    @IBOutlet weak var functionalLabel:UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        demoLabel.attributedText = self.normalAttr("1500", addr: "南京东路步行街")
        linkLabel.attributedText = self.linkedAttr("190000", addr: "人民广场地下车库")
        functionalLabel.attributedText = self.linkedAttr("9930000", addr: "函数式的测试地址")
    }
    
    private func normalAttr(money:String,addr:String)->NSMutableAttributedString{
        let starAttr = NSMutableAttributedString(string:"￥ ")
        starAttr.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor(), range: NSMakeRange(0,starAttr.length))
        starAttr.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(18), range: NSMakeRange(0,starAttr.length))
        
        let moneyAttr = NSMutableAttributedString(string:money)
        moneyAttr.addAttribute(NSForegroundColorAttributeName, value: UIColor.blackColor(), range: NSMakeRange(0,moneyAttr.length))
        moneyAttr.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(14), range: NSMakeRange(0,moneyAttr.length))
        
        let yAttr = NSMutableAttributedString(string:" 元")
        yAttr.addAttribute(NSForegroundColorAttributeName, value: UIColor.lightGrayColor(), range: NSMakeRange(0,yAttr.length))
        yAttr.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(10), range: NSMakeRange(0,yAttr.length))
        
        let addrAttr = NSMutableAttributedString(string:"    \(addr)")
        addrAttr.addAttribute(NSForegroundColorAttributeName, value: UIColor.blueColor(), range: NSMakeRange(0,addrAttr.length))
        addrAttr.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(14), range: NSMakeRange(0,addrAttr.length))
        starAttr.appendAttributedString(moneyAttr)
        starAttr.appendAttributedString(yAttr)
        starAttr.appendAttributedString(addrAttr)
        return starAttr
    }
    
    
    func linkedAttr(money:String,addr:String) -> NSMutableAttributedString {
        return "￥ ".toAttr().foreColor(UIColor.redColor()).font(UIFont.systemFontOfSize(18))
        >>>
            money.toAttr().foreColor(UIColor.blackColor()).font(UIFont.systemFontOfSize(14))
        >>>
            " 元".toAttr().foreColor(UIColor.lightGrayColor()).font(UIFont.systemFontOfSize(10))
        >>>
            "    \(addr)".toAttr().foreColor(UIColor.blueColor()).font(UIFont.systemFontOfSize(14))
    }
    
    func functionalAttr(money:String,addr:String)->NSMutableAttributedString{
        
        return (zz_foreColor(UIColor.redColor()) >>> zz_font(UIFont.boldSystemFontOfSize(18)))("￥ ".toAttr())
        >>>
            (zz_foreColor(UIColor.blackColor()) >>> zz_font(UIFont.boldSystemFontOfSize(14)))(money.toAttr())
        >>>
            (zz_foreColor(UIColor.lightGrayColor()) >>> zz_font(UIFont.boldSystemFontOfSize(10)))(" 元".toAttr())
        >>>
            (zz_foreColor(UIColor.blueColor()) >>> zz_font(UIFont.boldSystemFontOfSize(14)))("    \(addr)".toAttr())
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}



infix operator >>> {
    associativity left
}

func >>> (attr1 : NSMutableAttributedString ,attr2 : NSMutableAttributedString ) -> NSMutableAttributedString{
    attr1.appendAttributedString(attr2)
    return attr1
}

typealias Attribute = NSMutableAttributedString -> NSMutableAttributedString

func >>> (attr1:Attribute , attr2 : Attribute) -> Attribute{
    return { attr in
        return attr1(attr2(attr))
    }
}

func zz_foreColor(color:UIColor)->Attribute{
    return { attr in
        attr.addAttributes([NSForegroundColorAttributeName:color], range: attr.allRange())
        return attr
    }
}

func zz_font(font:UIFont)->Attribute{
    return { attr in
        attr.addAttributes([NSFontAttributeName:font], range: attr.allRange())
        return attr
    }
}

extension NSMutableAttributedString{
    
    func foreColor(color:UIColor)->NSMutableAttributedString{
        self.addAttributes([NSForegroundColorAttributeName:color], range: self.allRange())
        return self
    }
    
    func font(font:UIFont)->NSMutableAttributedString{
        self.addAttributes([NSFontAttributeName:font], range: self.allRange())
        return self
    }
    
    func allRange()->NSRange{
        return NSMakeRange(0,self.length)
    }
}


extension String{
    
    func toAttr()->NSMutableAttributedString{
        return NSMutableAttributedString(string: self)
    }
    
}

