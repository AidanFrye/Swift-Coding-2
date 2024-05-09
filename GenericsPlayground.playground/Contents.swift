import UIKit

//making a function using generics
//function allows you to compare multiple different data types, Ints, Arrays,
//Strings, by usinga a generic statement, <TypeToUse>, and replacing it with the
//data type called when the function is called. This makes the function applicable
//to almost every instance where you would need to find the largest between 2 objects

func max <TypeToUse> (_ x: TypeToUse, _ y: TypeToUse) -> TypeToUse where TypeToUse : Comparable {
    if y>=x {
        return y
    }
    else {
        return x
    }
}

max(5, 7)

max("Owen", "Aidan")

max("Aidan", "Beckett")

max (2.0, 5.7)

//generic function shown works for integers, strings, and floats / doubles
