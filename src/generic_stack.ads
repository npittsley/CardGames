with Ada.Unchecked_Deallocation;

generic
   type Element_Type is private;
package Generic_Stack is
   type Stack is private;
   procedure Push (S : in out Stack; Item : in Element_Type);
   function Pop (S : in out Stack) return Element_Type;
   procedure Pop (S : in out Stack; Item : out Element_Type);
   function Top (S : Stack) return Element_Type;
   function IsEmpty(S: Stack) return Boolean;
   function Length(S: Stack) return Natural;
   procedure Clear (S : out Stack);
   Empty_Stack : exception;
private
   type Node;
   type Stack is access Node;
   type Node is record
      Index  : Positive;
      Value : Element_Type;
      Next  : Stack;
   end record;
   procedure Free_Node is new Ada.Unchecked_Deallocation (Node, Stack);
end Generic_Stack;
