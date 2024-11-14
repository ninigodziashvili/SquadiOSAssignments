//
//  NotFollowingInterfaceSegregationPrinciple.swift
//  SOLID
//
//  Created by Cotne Chubinidze on 13.11.24.
//
final class ClassForCapsulation2 {
    /*
     -- interface segragation principle- ის მიხედვით ობიექტი უნდა მოიცავდეს მხოლოდ მისთვის საჭირო და
     შესაფერის მეთოდებსა თუ ობიექტებს.
     
     -- ჩვენს შემთხვევაში არაცხადად გამიჯნული პროტოკოლის გამო Fan ის კლასში გვიწევს ისეთი მეთოდების
     შემოტანა რომელსაც კლასი არ იყენებს.
     
     -- ამ ყველაფერმა შეიძლება მიგვიყვანოს პროგრამის მოულოდნელ ქცევასთან
     */
    protocol RemoteControl {
        func turnOn()
        func turnOff()
        func volumeUp()
        func volumeDown()
        func changeChannel()
        func mute()
    }

    final class FanRemoteControl: RemoteControl {
        func turnOn() {
            print("turning on fan")
        }

        func turnOff() {
            print("turning off fan")
        }

        func volumeUp() {}
        
        func volumeDown() {}
        
        func changeChannel() {}
        
        func mute() {}
    }
    
    final class Tv: RemoteControl {
        func turnOn() {
            print("turning on Tv")
        }

        func turnOff() {
            print("turning off Tv")
        }

        func volumeUp() {
            print("increasing Tv volume")
        }

        func volumeDown() {
            print("decreasing Tv volume")
        }

        func mute() {
            print("volume muted")
        }

        func changeChannel() {
            print("changing Tv channel")
        }
    }
}
