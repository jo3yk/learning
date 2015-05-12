/* FIND:
 1. Some Io example problems
 2. An Io community that will answer questions
 3. A style guide with Io idioms
*/

/* ANSWER:
 1. Evaluate 1 + 1 and then 1 + "one". Is Io strongly typed or weakly typed? Support your answer with code.
 Io> 1 + 1
 ==> 2
 Io> 1 + "one"
 ==> Exception: argument 0 to method '+' must be a Number, not a 'Sequence'
  ---------
  +                                   day1.io 20
  CLI doFile                           Z_CLI.io 140
  CLI run                              IoState_runCLI() 1
  
  Strongly typed - attempt to add two different types leads to an exception, rather than implicit conversion.
  
 2. Is 0 true or false? What about the empty string? Is nil true or false? Support your answer with code.
 Io> 0 == true
 ==> false
 Io> "" == true
 ==> false
 Io> nil == true
 ==> false
 
 3. How can you tell which slots a prototype supports?
 slotNames returns the slots supported explicitly by the prototype. To find the slots supported via inheritance, call slotNames on the type returned from protos (recursively) - getAllSlots method below.
 4. What is the difference between =, :=, and ::=? When would you use each one?
  ::= 	Creates slot, creates setter, assigns value
  := 	Creates slot, assigns value
  = 	Assigns value to slot if it exists, otherwise raises exception 
  Use = for pre-existing slots and ::=or := for new ones, depending on whether a setter is required.
*/

/* DO:
 1. Run an Io program from a file - this file!
 2. Execute the code in a slot given its name.
*/

Object getAllSlots := method(
  slots := self slotNames
  parent := self protos at(0)
  while (parent type != "Object",
    parent_slots := parent slotNames
    parent slotNames foreach (i, slot, 
    if (slot != "type",
      slots append(slot)
      )
    )
    parent = parent protos at(0)
  )
  return slots
)

/* Testing getAllSlots
MyObject := Object clone
MyObject myslot1 := "Slot from MyObject"
MyChild := MyObject clone
MyChild myslot2 := "Slot from MyChild"
MyGrandchild := MyChild clone
MyGrandchild myslot3 := "Slot from MyGrandchild"

MyGrandchild getAllSlots println
*/

// Executing the code in a slot
MyObject2 := Object clone
MyObject2 prop1 := method("Method: prop1 executed." println)
obj := MyObject2 clone
obj prop1
"executed directly" println
obj prop2 := method("Method: now with added prop2." println)
obj getAllSlots foreach (slot, 
  obj getSlot(slot) call
  "called from slot" println)




