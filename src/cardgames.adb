with Ada.Text_IO;           use Ada.Text_IO;
with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;
with Ada.Numerics.Discrete_Random;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package body CardGames is
   procedure TestStack is
      type Stack1_T is new CardStack.Stack;
      type Stack2_T is new CardStack.Stack;
      Stack1 : CardStack_T;
      Stack2 : CardStack_T;

      Deck     : CardStack_T;
      TempCard : Card_T;
      -- CIndex : Integer;
      --TopCard : Card_T;
      --Len : Integer;
      --Input : Character;
   begin
      Deck := GetNewDeck (Game => Poker);
      Print (CurrentHand => Deck, IsHorizontal => True);
      for Index in 1 .. 10 loop
         TempCard := Pop (Deck);
         case Index is
            when 1 | 3 | 5 | 7 | 9 =>
               Push (Stack1, TempCard);
            when others =>
               Push (Stack2, TempCard);
         end case;
      end loop;
      -- Put_Line("After loop");
      -- Put_Line("4Deck Length:" & Integer'Image(Length(Deck)));
      -- CIndex := 1;
      --There are definitely 42 cards at this point
      --  while not IsEmpty(Deck) loop
      --     TempCard := Pop(Deck);
      --     Print(Card => TempCard,Index => CIndex);
      --     CIndex := CIndex +1;
      --  end loop;

      Print (CurrentHand => Deck, IsHorizontal => True);
      Put_Line("After Print");
      DisplayPlayerHand(PlayerHand => Stack1,Text => "Before Stack 1");
      DisplayPlayerHand(PlayerHand => Stack2,Text => "Before Stack 2");
      TempCard := Pop(Stack1);
      DisplayPlayerHand(PlayerHand => Stack1,Text => "Pop Stack 1(" & Integer'Image(Length(Stack1)) & ")");
      Push(Stack2,TempCard);
      DisplayPlayerHand(PlayerHand => Stack2,Text => "Push Stack 2(" & Integer'Image(Length(Stack2)) & ")");
      TempCard := Pop(Stack1);
      DisplayPlayerHand(PlayerHand => Stack1,Text => "Pop Stack 1(" & Integer'Image(Length(Stack1)) & ")");
      Push(Stack2,TempCard);
      DisplayPlayerHand(PlayerHand => Stack2,Text => "Push Stack 2(" & Integer'Image(Length(Stack2)) & ")");
      TempCard := Pop(Stack1);
      DisplayPlayerHand(PlayerHand => Stack1,Text => "Pop Stack 1(" & Integer'Image(Length(Stack1)) & ")");
      Push(Stack2,TempCard);
      DisplayPlayerHand(PlayerHand => Stack2,Text => "Push Stack 2(" & Integer'Image(Length(Stack2)) & ")");
      TempCard := Pop(Stack1);
      DisplayPlayerHand(PlayerHand => Stack1,Text => "Pop Stack 1(" & Integer'Image(Length(Stack1)) & ")");
      Push(Stack2,TempCard);
      DisplayPlayerHand(PlayerHand => Stack2,Text => "Push Stack 2(" & Integer'Image(Length(Stack2)) & ")");
      TempCard := Pop(Stack1);
      DisplayPlayerHand(PlayerHand => Stack1,Text => "Pop Stack 1(" & Integer'Image(Length(Stack1)) & ")");
      Push(Stack2,TempCard);
      DisplayPlayerHand(PlayerHand => Stack2,Text => "Push Stack 2(" & Integer'Image(Length(Stack2)) & ")");

   end TestStack;
   procedure PlayPoker (PlayerCount : Positive; HandCount : Positive) is
      Game        : CardGames.Game_T;
      Deck        : CardStack_T;
      DiscardPile : CardStack_T;
      PlayerHands : Player_Hands_T (1 .. PlayerCount);
      TempHand    : CardStack_T;

      IsLivePlayer : Boolean;
      --DealerPositionIndex : Positive;
      LivePlayerPositionIndex : Positive := 1;
      CallCount               : Integer  := 0;
      CurrentBet              : Integer;
      TotalBet                : Integer;
      Pot                     : Integer  := 0;
      Round                   : Positive := 1;
      Choice                  : GameChoice_T;
      --PriorChoice : GameChoice_T;

      --HandReview : HandReview_T;
      --DidPriorPlayerBet : Boolean;
      IsGameOver : Boolean;
   begin
      IsGameOver := False;
      Game       := Poker;
      --SetName(S => DiscardPile,Name => "Disc");
      Deck       := GetNewDeck (Game);
      --SetName(S => Deck, Name => "Deck");
      -- Deal
      PlayerHands := Deal (Game, Deck, PlayerCount, HandCount);
      for PlayerHand of PlayerHands loop
         Put_Line(GetName(S => PlayerHand));
      end loop;
      --Play Loop
      while not IsGameOver loop
         Pot       := 0;
         Round     := 1;
         CallCount := 0;
         for Index in PlayerHands'Range loop
            IsLivePlayer := (Index = LivePlayerPositionIndex);
            TotalBet     := 0;
            --InspectHand(PlayerHands(Index),HandReview);
            Choice :=
              HandleOptionsEvent
                (Player_Hand  => PlayerHands (Index),
                 IsLivePlayer => IsLivePlayer);

            case Choice is
               when Quit =>
                  IsGameOver := True;
                  exit;
               when Pass =>
                  null;
               when Bet | RaiseBet =>
                  CurrentBet :=
                    HandleBetEvent
                      (PlayerHand   => PlayerHands (Index),
                       IsLivePlayer => IsLivePlayer);
                  if CurrentBet > TotalBet and TotalBet /= 0 then
                     Pot :=
                       Pot +
                       HandleRaiseEvent
                         (PlayerHand   => PlayerHands (Index),
                          IsLivePlayer => IsLivePlayer);
                  else
                     Pot := Pot + CurrentBet;
                  end if;
                  TotalBet := CurrentBet;
               when Call =>
                  CallCount := CallCount + 1;
                  if CallCount = 2 then
                     IsGameOver := True;
                     exit;
                  end if;
               when Fold =>
                  null;
               when Draw =>
                  HandleDrawEvent
                    (Deck            => Deck, Discard_Pile => DiscardPile,
                     Player_Hand     => PlayerHands (Index),
                     IsLivePlayer    => (Index = LivePlayerPositionIndex),
                     MaxCardsPerHand => HandCount);
            end case;
         end loop;
         PrintSummary (Round, Pot, CallCount);
      end loop;

      EndGame (PlayerHands, Pot);

   end PlayPoker;
   --Game Flow
   function Create_Deck (Game : Game_T) return Deck_T is
      Deck       : Deck_T (1 .. 52);
      Deck_Index : Positive;
      Card       : Card_T;
      --(range <>) of Card_T;
   begin
      --case Game is
      --   when others =>
      --    Deck := Basic_Deck;
      --end case;
      Deck_Index := 1;
      for Suit_Item in Suit_T'Range loop
         for Card_Index in 1 .. 13 loop
            Card              := (Suit => Suit_Item, Value => Card_Index);
            Deck (Deck_Index) := Card;
            Deck_Index        := Deck_Index + 1;

         end loop;
      end loop;
      return Deck;
   end Create_Deck;
   procedure ShuffleDeck (Deck : in out Deck_T) is
      Rand      : Integer := 0;
      Temp_Card : Card_T;
   begin
      for Index in 1 .. 7 loop
         for Deck_Index in Deck'Range loop
            Rand              := Get_Random (Deck'Length);
            Temp_Card         := Deck (Deck_Index);
            Deck (Deck_Index) := Deck (Rand);
            Deck (Rand)       := Temp_Card;
         end loop;
      end loop;
   end ShuffleDeck;
   procedure Shuffle (CardStack : in out CardStack_T) is
      TempCard : Card_T;
--      type CardArray is array (Integer range <>) of Card_T;
      TempCardArray : Deck_T (1 .. Length (CardStack));
      DidEmpty      : Boolean;
   begin
      for Index in TempCardArray'First .. TempCardArray'Last loop
         Pop (S => CardStack,Item => TempCard);
         TempCardArray (Index) := TempCard;
      end loop;
      ShuffleDeck (TempCardArray);
      DidEmpty := IsEmpty (CardStack);
      for Card of TempCardArray loop
         Push (CardStack, Card);
      end loop;
   end Shuffle;
   procedure Reshuffle
     (Deck : in out CardStack_T; DiscardPile : in out CardStack_T)
   is

   begin
      Put_Line ("Deck is out, need to shuffle discard pile");
      Deck := DiscardPile;
      Clear (DiscardPile);
      Shuffle (Deck);
      Put_Line ("Done Reshuffling");

   end Reshuffle;

   function StackDeck (Deck : Deck_T) return DeckStack is
      DeckStack : DeckStack;
      Temp_Card : Card_T;
   begin
      for Index in reverse Deck'Range loop
         Temp_Card := Deck (Index);
         Push (DeckStack, Deck (Index));
      end loop;
      return DeckStack;
   end StackDeck;
   function StackAsArray (CardStack : CardStack_T) return Deck_T is
      DeckArray         : Deck_T (1 .. Length (CardStack));
      Temp_Stack        : CardStack_T;
      Temp_Card         : Card_T;
      Card_Stack_Length : Integer;
   begin
      Temp_Stack        := CardStack;
      Card_Stack_Length := Length (Temp_Stack);
      for Index in reverse 1 .. Card_Stack_Length loop
         Pop (S => Temp_Stack, Item => Temp_Card);
         DeckArray (Index) := Temp_Card;
      end loop;
      return DeckArray;
   end StackAsArray;
   procedure ReverseStack(CardStack : in out CardStack_T) is
      NewStack : CardStack_T;
      Stack_Length : Integer;
      Temp_Card : Card_T;
   begin
      Stack_Length := Length(CardStack);
      for Index in 1..Stack_Length loop
         Pop(S => CardStack, Item => Temp_Card);
         Push(S => NewStack, Item => Temp_Card);
      end loop;
      CardStack := NewStack;
   end ReverseStack;


   function GetNewDeck (Game : Game_T) return DeckStack is
      DeckInit : Deck_T (1 .. 52);
      Deck     : CardStack_T;
   begin
      DeckInit := Create_Deck (Game);
      ShuffleDeck (DeckInit);
      Deck := StackDeck (DeckInit);
      return Deck;
   end GetNewDeck;
   function Deal
     (Game : Game_T; Deck : in out CardStack_T; PlayerCount : Positive;
      Cards_Per_Player : Positive) return Player_Hands_T
   is
      Player_Hands : Player_Hands_T (1 .. PlayerCount);
      Deck_Index   : Positive;
      Temp_Card    : Card_T;

   begin
      Deck_Index := 1;
      for Deal_Round_Index in 1 .. Cards_Per_Player loop
         for Player_Index in 1 .. PlayerCount loop
            if Deal_Round_Index = 1 then
               null;
               --SetName(S => Player_Hands(Player_Index),Name => "Ply"&Integer'Image(Player_Index));
            end if;
            Pop (S => Deck, Item => Temp_Card);
            Push (Player_Hands (Player_Index), Temp_Card);
         end loop;
      end loop;
      return Player_Hands;
   end Deal;

   procedure Draw
     (Deck        : in out CardStack_T; Discard_Pile : in out CardStack_T;
      Player_Hand : in out CardStack_T; Count : Integer)
   is
      --DrawnCards : CardStack_T;
      DrawnCard : Card_T;
      Index     : Integer;
   begin
      --If length of Deck is Zero then We must shuffle discard pile and set it to Deck and Discard Pile is empty
      Index := 1;
      while Index <= Count loop
         if IsEmpty (Deck) then
            Reshuffle (Deck => Deck, DiscardPile => Discard_Pile);
            Put_Line("--Reshuffled--");
            DisplayPlayerHand(PlayerHand => Deck, Text => "Deck");
            DisplayPlayerHand(PlayerHand => Discard_Pile,Text => "Discard Pile");
         end if;
         Put_Line("Deck POP: " & Integer'Image(Length(Deck)));
         Pop (S => Deck, Item => DrawnCard);
         Put_Line("Hand PUSH:"  & Integer'Image(Length(Player_Hand)));
         Push (S => Player_Hand, Item => DrawnCard);
         Index := Index + 1;
      end loop;
   end Draw;
   procedure RoboDiscard
     (PlayerHand : in out CardStack_T; Discard_Pile : in out CardStack_T)
   is
      CardIndex : Positive;
   begin
      --TODO: Figure out how many cars to discard
      CardIndex := 1;
      Discard
        (CardIndex    => 1, PlayerHand => PlayerHand,
         Discard_Pile => Discard_Pile);
   end RoboDiscard;

   procedure Discard
     (CardIndex : Positive; PlayerHand : in out CardStack_T;
      Discard_Pile : in out CardStack_T)
   is
      TestCard       : Card_T;
      New_PlayerHand : CardStack_T;
      Index          : Integer;
   begin
      Index := Length(PlayerHand);
      Put_Line("PlayerHand Length: " & Integer'Image(Index));
      Put_Line("Searching for # " & Integer'Image(CardIndex));
      while Index > 0 loop
         Pop (S =>  PlayerHand,Item => TestCard);
         Put_Line("--Pop Playerhand--");
         Print(Card => TestCard,Index => 0);
         --Find chosen Card
         if Index = CardIndex then
            Push (Discard_Pile, TestCard);
            Put_Line("--Discarding--");
            Print(Card => TestCard,Index => 0);
         else
            Put_Line("--Push Playerhand--");
            Push (New_PlayerHand, TestCard);
         end if;
         Index := Index - 1;
      end loop;
      DisplayPlayerHand(PlayerHand => PlayerHand,Text => "Reversed Hand");
      ReverseStack(New_PlayerHand);
      PlayerHand := New_PlayerHand;
      DisplayPlayerHand(PlayerHand => PlayerHand,Text => "My Hand");
      DisplayPlayerHand(PlayerHand => Discard_Pile,Text => "Discard_Pile");
   end Discard;

   procedure ChooseAndDiscard (Card : Card_T; DiscardPile : in out CardStack_T)
   is
   begin
      null;
   end ChooseAndDiscard;

   --hand Evaluation
   function GetNewHandReview return HandReview_T is
      HandReview : HandReview_T;
   begin
      return HandReview;
   end GetNewHandReview;

   function HasAceInHand (Player_Hand : CardStack_T) return Boolean is
      Success   : Boolean := False;
      TempArray : Deck_T (1 .. Length (Player_Hand));
   begin
      TempArray := StackAsArray (Player_Hand);
      for Card of TempArray loop
         if Card.Value = 1 then
            Success := True;
            exit;
         end if;
      end loop;
      return Success;
   end HasAceInHand;
   procedure MarkHighCard
     (Current_Hand : CardStack_T; HandReview : in out HandReview_T)
   is
      TempArray : Deck_T (1 .. Length (Current_Hand));
   begin
      TempArray := StackAsArray (Current_Hand);
      for Card of TempArray loop
         if Card.Value > HandReview.HighCard.Value then
            HandReview.HighCard := Card;
         end if;
      end loop;
   end MarkHighCard;
   procedure HasXOfAKind (HandReview : in out HandReview_T) is
   begin
      --Measure Value Counts
      case HandReview.Most_Prevalent_Value_Count is
         when 2 =>
            HandReview.HasTwoOfAKind := True;
         when 3 =>
            HandReview.HasTwoOfAKind   := True;
            HandReview.HasThreeOfAKind := True;
         when 4 =>
            HandReview.HasTwoOfAKind   := True;
            HandReview.HasThreeOfAKind := True;
            HandReview.HasFourOfAKind  := True;
         when others =>
            null;
      end case;
      --for Count of HandReview.FaceValueReview loop
      --   if Count>=2 then
      --      HandReview.HasTwoOfAKind :=True;
      --   end if;
      --   if Count>=3 then
      --      HandReview.HasThreeOfAKind := True;
      --   end if;
      --   if Count>=4 then
      --      HandReview.HasFourOfAKind := True;
      --   end if;
      --end loop;
   end HasXOfAKind;
   procedure HasFullHouseOrPossible (HandReview : in out HandReview_T) is
      HasTwo            : Boolean := False;
      HasThree          : Boolean := False;
      Count             : Integer;
      ThreeOfAKindIndex : Integer;
   begin
      for Index in HandReview.FaceValueReview'Range loop
         Count := HandReview.FaceValueReview (Index);
         if Count >= 3 then
            HasThree          := True;
            ThreeOfAKindIndex := Index;
         end if;
      end loop;
      if HasThree = True then
         for Index in HandReview.FaceValueReview'Range loop
            Count := HandReview.FaceValueReview (Index);
            if Count >= 2 and Index /= ThreeOfAKindIndex then
               HasTwo := True;
            end if;
         end loop;
      end if;
      HandReview.HasPossibleFullHouse := HasThree;
      HandReview.HasFullHouse         := HasTwo and HasThree;
   end HasFullHouseOrPossible;
   procedure HasStraightOrPossible (HandReview : in out HandReview_T) is
      ContiguousCount     : Integer;
      FaceValueReview_Ext : FaceValueReview_T;
   begin
      --Move ACE to High Position for second pass
      FaceValueReview_Ext (1 .. FaceValueReview_Ext'Last - 1) :=
        HandReview.FaceValueReview (2 .. HandReview.FaceValueReview'Last);
      FaceValueReview_Ext (FaceValueReview_Ext'Last) :=
        HandReview.FaceValueReview (HandReview.FaceValueReview'First);

      --Test ACE Low
      ContiguousCount := 0;
      for Value of HandReview.FaceValueReview loop
         if Value > 0 then
            ContiguousCount := ContiguousCount + 1;
         else
            ContiguousCount := 0;
         end if;
         if ContiguousCount = 4 then
            HandReview.HasPossibleStraight := True;
         end if;
         if ContiguousCount = 5 then
            HandReview.HasStraight := True;
            exit;
         end if;
      end loop;

      --Test Ace High
      ContiguousCount := 0;
      for Value of FaceValueReview_Ext loop
         if Value > 0 then
            ContiguousCount := ContiguousCount + 1;
         else
            ContiguousCount := 0;
         end if;
         if ContiguousCount = 4 then
            HandReview.HasPossibleStraight := True;
         end if;
         if ContiguousCount = 5 then
            HandReview.HasStraight := True;
            exit;
         end if;
      end loop;
   end HasStraightOrPossible;
   procedure HasFlushOrPossible (HandReview : in out HandReview_T) is
   begin
      --Measure Suit COunts
      case HandReview.Most_Prevalent_Suit_Count is
         when 4 =>
            HandReview.HasPossibleFlush := True;
         when 5 =>
            HandReview.HasFlush := True;
         when others =>
            null;
      end case;
   end HasFlushOrPossible;
   procedure HasStraightFlushOrRoyalFlush (HandReview : in out HandReview_T) is
   begin
      HandReview.HasStraightFlush :=
        HandReview.HasStraight and HandReview.HasFlush;
      HandReview.HasRoyalFlush :=
        HandReview.HasStraightFlush and
        (HandReview.HighCard.Value = 1 or HandReview.HighCard.Value = 13);
   end HasStraightFlushOrRoyalFlush;

   procedure InspectHand
     (Current_Hand : CardStack_T; HandReview : in out HandReview_T)
   is
   begin
      InspectHandSuits (Current_Hand, HandReview);
      InspectHandFaceValues (Current_Hand, HandReview);
      HasXOfAKind (HandReview);
      HasFlushOrPossible (HandReview);
      HasStraightOrPossible (HandReview);
      HasStraightFlushOrRoyalFlush (HandReview);

   end InspectHand;
   procedure InspectHandSuits
     (Current_Hand : CardStack_T; HandReview : in out HandReview_T)
   is
      This_Hand  : Deck_T (1 .. Length (Current_Hand));
      SuitReview : SuitReview_T;
   begin
      This_Hand := StackAsArray (Current_Hand);
      for Card of This_Hand loop
         case Card.Suit is
            when Spades =>
               SuitReview (1) := SuitReview (1) + 1;
            when Diamonds =>
               SuitReview (2) := SuitReview (2) + 1;
            when Clubs =>
               SuitReview (3) := SuitReview (3) + 1;
            when Hearts =>
               SuitReview (4) := SuitReview (4) + 1;
            when others =>
               SuitReview (4) := SuitReview (4) + 1;
         end case;
      end loop;
      --What's the most cards of a given Suit and of which suit is it?
      for Index in SuitReview'Range loop
         if SuitReview (Index) >= HandReview.Most_Prevalent_Suit_Count then
            HandReview.Most_Prevalent_Suit_Count := SuitReview (Index);
            HandReview.Most_Prevalent_Suit       := Index;
         end if;
         case SuitReview (Index) is
            when 2 =>
               HandReview.HasTwoOfASuit := True;
            when 3 =>
               HandReview.HasTwoOfASuit   := True;
               HandReview.HasThreeOfASuit := True;
            when 4 =>
               HandReview.HasTwoOfASuit    := True;
               HandReview.HasThreeOfASuit  := True;
               HandReview.HasFourOfASuit   := True;
               HandReview.HasPossibleFlush := True;
            when 5 =>
               HandReview.HasTwoOfASuit   := True;
               HandReview.HasThreeOfASuit := True;
               HandReview.HasFourOfASuit  := True;
               HandReview.HasFlush        := True;
            when others =>
               null;
         end case;
      end loop;
      HandReview.SuitReview := SuitReview;
   end InspectHandSuits;
   procedure InspectHandFaceValues
     (Current_Hand : CardStack_T; HandReview : in out HandReview_T)
   is
      This_Hand : Deck_T (1 .. Length (Current_Hand));

   begin
      --Find the highest card in the hand
      MarkHighCard (Current_Hand, HandReview);

      This_Hand := StackAsArray (Current_Hand);
      for Index in This_Hand'Range loop
         HandReview.FaceValueReview (This_Hand (Index).Value) :=
           HandReview.FaceValueReview (This_Hand (Index).Value) + 1;
      end loop;
      --What's the most cards of a given Value and how many are there?
      for Index in HandReview.FaceValueReview'Range loop
         if HandReview.FaceValueReview (Index) >=
           HandReview.Most_Prevalent_Value_Count
         then
            HandReview.Most_Prevalent_Value_Count :=
              HandReview.FaceValueReview (Index);
            HandReview.Most_Prevalent_Value := Index;
         end if;
      end loop;

   end InspectHandFaceValues;

   function HandleOptionsEvent
     (Player_Hand : in out CardStack_T; IsLivePlayer : Boolean)
      return GameChoice_T
   is
      Choice : GameChoice_T;
   begin
      if IsLivePlayer then
         Choice := GetPlayerChoice (PlayerHand => Player_Hand);
      else
         delay 0.5;
         Choice := GetRoboChoice (PlayerHand => Player_Hand);
      end if;
      return Choice;
   end HandleOptionsEvent;
   function HandleBetEvent
     (PlayerHand : CardStack_T; IsLivePlayer : Boolean) return Natural
   is
      Bet : Natural := 0;
   begin
      if IsLivePlayer then
         Bet := GetPlayerBet (PlayerHand);
      else
         Bet := GetRoboBet (PlayerHand);
      end if;
      return Bet;
   end HandleBetEvent;
   function HandleRaiseEvent
     (PlayerHand : CardStack_T; IsLivePlayer : Boolean) return Natural
   is
      RaiseAmount : Integer;
   begin
      if IsLivePlayer then
         RaiseAmount := GetPlayerRaise (PlayerHand => PlayerHand);
      else
         RaiseAmount := GetRoboRaise (PlayerHand => PlayerHand);
      end if;
      return RaiseAmount;
   end HandleRaiseEvent;
   procedure HandleDrawEvent
     (Deck            : in out CardStack_T; Discard_Pile : in out CardStack_T;
      Player_Hand     : in out CardStack_T; IsLivePlayer : Boolean;
      MaxCardsPerHand :        Positive)
   is
      Prompt       : String  := "Choose a card # to replace or (D)one?";
      Input        : Character;
      InputString  : String (1 .. 1);
      DiscardCount : Integer := 0;
      IsDone       : Boolean := False;
      CardIndex    : Positive;
   begin
      if IsLivePlayer then
         while not IsDone loop
            DisplayPlayerHand (Player_Hand, "Your Hand");
            Put (Prompt);
            Get (Input);
            case Input is
               --TODO Base on any integer value <= Length of PlayerHand
               when '1' | '2' | '3' | '4' | '5' =>
                  InputString (1) := Input;
                  CardIndex       := Integer'Value (InputString);
                  Put_Line("Chose # " & Integer'Image(CardIndex));
                  if DiscardCount < 3 or
                    (DiscardCount = 3 and HasAceInHand (Player_Hand))
                  then
                     Put_Line("Before Discard");
                     Discard
                       (CardIndex    => CardIndex, PlayerHand => Player_Hand,
                        Discard_Pile => Discard_Pile);
                     DiscardCount := DiscardCount + 1;
                  else
                     Put_Line ("You don't have an Ace. Limit is 3");
                  end if;
               when 'D' | 'd' =>
                  IsDone := True;
               when others =>
                  IsDone := False;
            end case;
         end loop;
      else
         RoboDiscard (PlayerHand => Player_Hand, Discard_Pile => Discard_Pile);
      end if;
      --DisplayPlayerHand(PlayerHand => Deck,Text => "Deck");
      --DisplayPlayerHand(PlayerHand => Player_Hand,Text => "Player Hand");
      --DisplayPlayerHand(PlayerHand => Discard_Pile, Text => "Discard Pile");
      DiscardCount := MaxCardsPerHand - Length (Player_Hand);
      Draw
        (Deck        => Deck, Discard_Pile => Discard_Pile,
         Player_Hand => Player_Hand, Count => DiscardCount);
   end HandleDrawEvent;

   function GetPlayerChoice (PlayerHand : in out CardStack_T) return GameChoice_T is
      Prompt : String :=
        "(B)et, (C)all, (D)raw, (F)old, (P)ass, (R)aise, (Q)uit: ";
      UserChoice : Character;
      Choice     : GameChoice_T;
   begin
      DisplayPlayerHand (PlayerHand, "-----Your Hand-----");
      UserChoice := '?';
      while UserChoice = '?' loop
         Ada.Text_IO.Put (Prompt);
         Ada.Text_IO.Get (UserChoice);
         case UserChoice is
            when 'B' | 'b' =>
               Choice := Bet;
            when 'C' | 'c' =>
               Choice := Call;
            when 'D' | 'd' =>
               Choice := Draw;
            when 'F' | 'f' =>
               Choice := Fold;
            when 'P' | 'p' =>
               Choice := Pass;
            when 'R' | 'r' =>
               Choice := RaiseBet;
            when 'Q' | 'q' =>
               Choice := Quit;
            when others =>
               UserChoice := '?';
         end case;
      end loop;
      return Choice;
   end GetPlayerChoice;
   function GetRoboChoice (PlayerHand : CardStack_T) return GameChoice_T is
      GameChoice : GameChoice_T;
      HandReview : HandReview_T;
      --DrawCount := Positive;
   begin
      InspectHand (Current_Hand => PlayerHand, HandReview => HandReview);
      --TODO Hard-coded for now
      GameChoice := Pass;
      --DrawCount := 2;
      return GameChoice;
   end GetRoboChoice;
   function GetPlayerBet (PlayerHand : CardStack_T) return Integer is
      Prompt    : String  := "Enter your bid amount: ";
      BetAmount : Integer := 0;
   begin
      Put (Prompt);
      Ada.Integer_Text_IO.Get (BetAmount);
      return BetAmount;
   end GetPlayerBet;
   function GetRoboBet (PlayerHand : CardStack_T) return Integer is
      Prompt    : String  := "Player bets: ";
      BetAmount : Integer := 5;
   begin
      --TODO: Add robot bet logic
      Put_Line (Prompt & Integer'Image (BetAmount));
      return BetAmount;
   end GetRoboBet;
   function GetPlayerRaise (PlayerHand : CardStack_T) return Integer is
      Prompt      : String  := "Enter raise amount:";
      RaiseAmount : Integer := 0;
   begin
      Put (Prompt);
      Get (RaiseAmount);
      return RaiseAmount;
   end GetPlayerRaise;
   function GetRoboRaise (PlayerHand : CardStack_T) return Integer is
      Prompt      : String  := "Player raises: ";
      RaiseAmount : Integer := 5;
   begin
      --TODO: Add Raise logic for robot
      Put_Line (Prompt & Integer'Image (RaiseAmount));
      return RaiseAmount;
   end GetRoboRaise;
   function GetRoboChosenDiscard (PlayerHand : CardStack_T) return Positive is
      CardIndex : Positive;
   begin
      CardIndex := 1;
      return CardIndex;
   end GetRoboChosenDiscard;

   procedure EndGame (Player_Hands : Player_Hands_T; Pot : Integer) is

   begin
      Ada.Text_IO.Put_Line ("Player 1 wins!");
   end EndGame;

   function Get_Random (Max_Value : Positive) return Integer is

      subtype Random_Range is Integer range 1 .. Max_Value;

      package R is new Ada.Numerics.Discrete_Random (Random_Range);
      use R;

      G : Generator;
      X : Random_Range;
   begin
      Reset (G);
      X := Random (G);
      return Integer'Value (Integer'Image (X));
   end Get_Random;

   function GetSuitAsSymbol (Card : Card_T) return String is
      Symbol : String (1 .. 1);
   begin
      case Card.Suit is
         when Spades =>
            Symbol := "S";
         when Hearts =>
            Symbol := "H";
         when Clubs =>
            Symbol := "C";
         when Diamonds =>
            Symbol := "D";
         when others =>
            Symbol := "?";
      end case;
      return Symbol;
   end GetSuitAsSymbol;

   function GetValueAsCardValue (Card : Card_T) return String is
      Value : Unbounded_String;
   begin
      case Card.Value is
         when 1 =>
            Value := To_Unbounded_String (" A");
         when 11 =>
            Value := To_Unbounded_String (" J");
         when 12 =>
            Value := To_Unbounded_String (" Q");
         when 13 =>
            Value := To_Unbounded_String (" K");
         when others =>
            Value := To_Unbounded_String (Integer'Image (Card.Value));
      end case;
      return To_String (Value);
   end GetValueAsCardValue;

   procedure DisplayPlayerHand (PlayerHand : in out CardStack_T; Text : String := "")
   is

   begin
      if Text /= "" then
         Put_Line ("*** " & Text & " ***");
      end if;
      Print (CurrentHand => PlayerHand, IsHorizontal => True);
   end DisplayPlayerHand;
   procedure PrintSummary
     (Round : Positive; Pot : Integer; CallCount : Integer)
   is
      Separator : String := "-------------------";
   begin
      Put_Line (Separator);
      Put_Line ("Round: " & Integer'Image (Round));
      Put_Line ("Pot: " & Integer'Image (Pot));
      Put_Line ("CallCount: " & Integer'Image (CallCount));
      Put_Line (Separator);
   end PrintSummary;
   procedure Print (Card : Card_T; Index : Integer := 0) is

   begin
      if Index > 0 then
         Put (Integer'Image (Index) & ". ");
      else
         Put ("-- ");
      end if;
      Put_Line
        (Integer'Image (Card.Value) & " of " & Suit_T'Image (Card.Suit));
   end Print;
   procedure Print (PlayerHands : Player_Hands_T) is
      Temp_Hand : CardStack_T;
   begin
      for Index in PlayerHands'First .. PlayerHands'Last loop
         Put_Line
           ("-------------Player " & Integer'Image (Index) & "------------");
         Temp_Hand := PlayerHands (Index);
         Print (Temp_Hand, True);
      end loop;
   end Print;

   procedure Print (CurrentHand : in out CardStack_T; IsHorizontal : Boolean) is
      PlayerHand : Deck_T (1 .. Length (CurrentHand));
      CardIndex  : Integer;
      Stack_Size : Integer;
      TempStack  : CardStack_T;
      ReturnStack  : CardStack_T;
   begin
      Clear(ReturnStack);
      --TempStack := CurrentHand;
      PlayerHand := StackAsArray (CurrentHand);
      if not IsHorizontal then
         CardIndex  := 1;
         for Card of PlayerHand loop
            Put_Line
              (Integer'Image (CardIndex) & ". " & Integer'Image (Card.Value) &
               ":" & Suit_T'Image (Card.Suit));
            CardIndex := CardIndex + 1;
         end loop;
      else
         Stack_Size := PlayerHand'Length;
         CardIndex := 0;
         Clear(TempStack);
         for Index in 1 .. Stack_Size loop
            Push (S => TempStack, Item => PlayerHand (Index));
            Push (S => ReturnStack, Item => PlayerHand (Index));
            if Index mod 10 = 0 or Index = Stack_Size then
               PrintCardRow (TempHand => TempStack, StartIndex => CardIndex);
               Clear (S => TempStack);
               CardIndex := CardIndex + 10;
            end if;
         end loop;
         CurrentHand := ReturnStack;
      end if;
   end Print;

   procedure PrintCardRow (TempHand : CardStack_T; StartIndex : Integer := 0) is
      Temp_Int : Integer;
      TempHandArray : Deck_T (1 .. Length (TempHand));
   begin
      TempHandArray := StackAsArray (CardStack => TempHand);
      for LineIndex in 1 .. 4 loop
         for CardIndex in TempHandArray'First .. TempHandArray'Last loop
            case LineIndex is
               when 1 =>
                  if CardIndex + StartIndex < 10 then
                     Put (" ~~" & Integer'Image (StartIndex + CardIndex) & " ~ ");
                  else
                     Put (" ~" & Integer'Image (StartIndex + CardIndex) & " ~ ");
                  end if;
               when 2 =>
                  Put
                    (" [" & GetSuitAsSymbol (TempHandArray (CardIndex)) &
                     "   ] ");
               when 3 =>
                  Temp_Int := TempHandArray (CardIndex).Value;
                  if Temp_Int = 10 then
                     Put(" [" );
                  else
                     Put(" [ ");
                  end if;
                  Put(GetValueAsCardValue (TempHandArray (CardIndex)) & " ] ");
               when 4 =>
                  Put
                    (" [   " & GetSuitAsSymbol (TempHandArray (CardIndex)) &
                     "] ");
                  --when 5 => Put("~~~~~~ ");
               when others =>
                  null;
            end case;
         end loop;
         New_Line;
      end loop;
      New_Line;
   end PrintCardRow;

   procedure Print (HandReview : HandReview_T) is
   begin
      Put_Line ("?????????????????????");

      Put_Line
        ("HighCard : " & Integer'Image (HandReview.HighCard.Value) & ":" &
         Suit_T'Image (HandReview.HighCard.Suit));
      Put_Line
        ("Most Prevalent Value : " &
         Integer'Image (HandReview.Most_Prevalent_Value_Count) & " " &
         Integer'Image (HandReview.Most_Prevalent_Value) & "'s");
      Put_Line
        ("Most Prevalent Suit : " &
         Integer'Image (HandReview.Most_Prevalent_Suit_Count) & " " &
         GetSuitName (HandReview.Most_Prevalent_Suit) & "'s");
      New_Line;
      Put_Line ("HasTwoOfAKind : " & Boolean'Image (HandReview.HasTwoOfAKind));
      Put_Line
        ("HasThreeOfAKind : " & Boolean'Image (HandReview.HasThreeOfAKind));
      Put_Line
        ("HasPossibleFullHouse : " &
         Boolean'Image (HandReview.HasPossibleFullHouse));
      Put_Line
        ("HasFourOfAKind : " & Boolean'Image (HandReview.HasFourOfAKind));
      New_Line;
      Put_Line ("HasTwoOfASuit : " & Boolean'Image (HandReview.HasTwoOfASuit));
      Put_Line
        ("HasThreeOfASuit : " & Boolean'Image (HandReview.HasThreeOfASuit));
      Put_Line
        ("HasPossibleFlush : " & Boolean'Image (HandReview.HasPossibleFlush));
      Put_Line
        ("HasFourOfASuit : " & Boolean'Image (HandReview.HasFourOfASuit));
      Put_Line ("HasFlush : " & Boolean'Image (HandReview.HasFlush));
      New_Line;
      Put_Line
        ("HasPossibleStraight : " &
         Boolean'Image (HandReview.HasPossibleStraight));
      Put_Line ("HasStraight : " & Boolean'Image (HandReview.HasStraight));
      Put_Line
        ("HasStraightFlush : " & Boolean'Image (HandReview.HasStraightFlush));
      Put_Line ("HasRoyalFlush : " & Boolean'Image (HandReview.HasRoyalFlush));
      Put_Line ("---------------------");
   end Print;
   function GetSuitName (Index : Integer) return String is
      --Spades, Diamonds, Clubs, Hearts
      Name : Unbounded_String;
   begin
      case Index is
         when 1 =>
            Name := To_Unbounded_String ("Spades");
         when 2 =>
            Name := To_Unbounded_String ("Diamonds");
         when 3 =>
            Name := To_Unbounded_String ("Clubs");
         when 4 =>
            Name := To_Unbounded_String ("Hearts");
         when others =>
            Name := To_Unbounded_String ("Unknown");
      end case;
      return To_String (Name);
   end GetSuitName;

end CardGames;
