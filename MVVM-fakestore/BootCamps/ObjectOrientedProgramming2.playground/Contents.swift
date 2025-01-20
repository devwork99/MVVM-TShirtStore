import UIKit



/*
 
 //Object Oriented Programming
 
 //During the life of the app, we create and destroy objects
 //Create = Initialize(init) = Allocate (Add to memory)
 //Destroy = Deinitialize (deinit) = Deallocate(remove from memory)
 
 //Automatic Reference Counting (ARC)
 //A live count of number of objects in the memory
 //Create 1 object, count goes up by 1
 //Create 2 objects, count goes up by 2
 //Destory 1 object, count goes down by 1
 
 //The more objects in the memory, the slower the app performs
 // We want to keep the ARC count as low as possible
 // We only want to create an object when we need them
 // and destory them as soon as we do not need them any longer
 
 //For example, if an app has 2 screens and user is moving from screen 1 to screen2. We only want to allocate screen 2 WHEN we need it (i.e when user click a button to segue to screen 2). When we get to screen 2, we may want to deallocate screen 1.
 
 //There are 2 types of Memory
 // Stack & heap
 // Only objects in the heap are counted towards ARC
 
 //Advanced info here
 // https://www.youtube.com/watch?v=-JLenSTKEcA&themeRefresh=1
 
 //Objects in the Stack
 // String, Bool, Int - the most basic types
 // New types - Struct, Enum
 
 
 //Objects in the heap
 //Functions
 //New : Classes & Actors
 
 
 
 //iPhone is a m"ulti-threaded environment"
 // There are multiple "threads" or engines running simultaneously
 // Each thread has a stack
 // But there is only 1 heap for all threads
 
 //Therefore :
 // Stack is faster, lower memroy footprint, preferable
 //Heap is slower, higher memory footprint
 
 
 //Value vs Reference types
 //Objects in the Stact are "Value" types
 //That means, when you edit a valye type, you create a copy of it with new data.
 
 //Objects in the Heap are "Reference" types.
 //When you edit a Reference type, you edit the object that you are referencing. This reference is called "Pointer" becasue if "Points" to an object in the heap (in memory)
 
 // we want to use classes for things like
 // "Manager", "DataService", "Service", "Factor" ,"ViewModels"
 //Objects that we create and perform functions inside
 
 // We want to use a struct for things like:
 // Data Models
 // objects that we create and pass around our app.
 
 
 
 
 */
