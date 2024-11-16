//
//  FollowingInterfaceSegregationPrinciple.swift
//  SOLID
//
//  Created by Cotne Chubinidze on 13.11.24.
//
final class ClassForCapsulation1 {
    /*
     -- სწორ ვარიანტში გვაქვს ცხადად გამოყოფილი ინტერფეისი, ორივე ობიექტი ექვემდებარება თავისთვის
     შესაფერის პროტოკოლს და იყენებს მხოლოდ მისთვის შესაფერის მეთოდებს.
     */
    protocol PowerControl {
        func turnOn()
        func turnOff()
    }

    protocol VolumeControl {
        func volumeUp()
        func volumeDown()
        func mute()
    }

    protocol ChannelControl {
        func changeChannel()
    }
    
    final class CeilingFanRemoteControl: PowerControl {
        func turnOn() {
            print("Turning on ceiling fan")
        }

        func turnOff() {
            print("Turning off ceiling fan")
        }
    }

    final class TVRemoteControl: PowerControl, VolumeControl, ChannelControl {
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
