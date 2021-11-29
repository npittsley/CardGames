with Ada.Text_IO;

package body Generic_Stack is
   
   procedure Push (S : in out Stack; Item : in Element_Type) is
      NewIndex : Positive;
      CurrentIndex : Natural;
   begin
      if S /= null  then
         CurrentIndex := S.Index;
         NewIndex := S.Index + 1;
      else
         CurrentIndex := 0;
         NewIndex := 1;
      end if;
      Ada.Text_IO.Put_Line("-Internal Push");
      Ada.Text_IO.Put_Line("--Befor Length: " & Integer'Image(CurrentIndex));
      S := new Node'(Value => Item, Next => S, Index => NewIndex);
      Ada.Text_IO.Put_Line("--After Length: " & Integer'Image(NewIndex));
   end Push;
   procedure Pop(S : in out Stack; Item : out Element_Type) is
      Head   : Stack := S;
      CurrentIndex : Natural;
   begin
      Ada.Text_IO.Put_Line("-Internal Pop");
      if Head = null then
         CurrentIndex := 0;
         raise Empty_Stack;
      else
         CurrentIndex := Head.Index;
      end if;
      Ada.Text_IO.Put_Line("--Befor Length: " & Integer'Image(CurrentIndex));
      Item := Head.Value;
      S      := Head.Next;
      if S /= null then
         CurrentIndex := S.Index;
      else
         CurrentIndex := 0;
      end if;
      Ada.Text_IO.Put_Line("--After Length: " & Integer'Image(CurrentIndex));
      Free_Node (Head);
   end Pop;
   function Pop (S : in out Stack) return Element_Type is
      Head   : Stack := S;
      Result : Element_Type;
      CurrentIndex : Natural;
   begin
      Ada.Text_IO.Put_Line("-Internal Pop");
      if Head = null then
         CurrentIndex := 0;
         raise Empty_Stack;
      else
         CurrentIndex := Head.Index;
      end if;
      Ada.Text_IO.Put_Line("--Befor Length: " & Integer'Image(CurrentIndex));
      Result := Head.Value;
      S      := Head.Next;
      if S /= null then
         CurrentIndex := S.Index;
      else
         CurrentIndex := 0;
      end if;
      Ada.Text_IO.Put_Line("--After Length: " & Integer'Image(CurrentIndex));
      Free_Node (Head);
      return Result;
   end Pop;

   function IsEmpty(S: Stack) return Boolean is
   begin
      return S = null;
   end IsEmpty;

   function Top (S : Stack) return Element_Type is
      Head   : Stack := S;
   begin
      if Head = null then
         raise Empty_Stack;
      end if;
      return Head.Value;
   end Top;
   
   function Length(S: Stack) return Natural is
   Head   : Stack := S;
   begin
      if Head = null then
         return 0;
      end if;
      return Head.Index;
   end Length;
   procedure Clear (S : out Stack) is
      Current : Stack;
   begin
      while S /= null loop
         Current := S;
         --Current.Size := 0;
         S       := S.Next;
         Free_Node (Current);
      end loop;
   end Clear;
   
end Generic_Stack;
