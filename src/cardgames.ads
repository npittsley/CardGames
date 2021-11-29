with Generic_Stack; 

package CardGames is
   
   type Game_T is (Solitaire, War, GoFish, Poker, Spades, Gin, Rummy, GinRummy);
   type Suit_T is (Spades, Diamonds, Clubs, Hearts);
   type GameChoice_T is (Pass, Bet, RaiseBet, Draw, Call, Fold, Quit);
   type Card_T is record
      Suit : Suit_T;
      Value : Integer := 1;
   end record;

   package CardStack is new Generic_Stack(Element_Type => Card_T);
   --use CardStack;
   package DeckStack is new Generic_Stack(Element_Type => Card_T);
   package DiscardStack is new Generic_Stack(Element_Type => Card_T);
   package HandStack is new Generic_Stack(Element_Type => Card_T);
   type CardStack_T is new HandStack.Stack;


   type Deck_T is array (Integer range <>) of Card_T;
   
   type Player_Hands_T is array (Positive range <>) of CardStack_T;

   type SuitReview_T is array (Positive range 1..4) of Integer with Default_Component_Value => 0;
   type FaceValueReview_T is array (Positive range 1..13) of Integer with Default_Component_Value => 0;
   type HandReview_T is record
      SuitReview: SuitReview_T;
      FaceValueReview: FaceValueReview_T;
      HighCard : Card_T;
      Most_Prevalent_Value : Integer :=0;
      Most_Prevalent_Value_Count : Integer := 0;
      Most_Prevalent_Suit : Integer := 0;
      Most_Prevalent_Suit_Count : Integer := 0;
      HasTwoOfAKind : Boolean := False;
      HasThreeOfAKind : Boolean := False;
      HasPossibleFullHouse : Boolean := False;
      HasFullHouse : Boolean := False;
      HasFourOfAKind : Boolean := False;
      HasTwoOfASuit : Boolean := False;
      HasThreeOfASuit : Boolean := False;
      HasFourOfASuit : Boolean := False;
      HasPossibleFlush : Boolean := False;
      HasFlush : Boolean := False;
      HasPossibleStraight : Boolean := False;
      HasStraight : Boolean := False;
      HasStraightFlush : Boolean := False;
      HasRoyalFlush : Boolean := False;

   end record;
   type Player_T is record
      Name : String(1..20) := "AAAAAAAAAAAAAAAAAAAA";
      Position : Positive;
      Hand : CardStack_T;
      HandReview : HandReview_T;
   end record;

   
   function Get_Random (Max_Value : Positive) return Integer;
   function Create_Deck(Game : Game_T) return Deck_T;
   procedure ShuffleDeck(Deck : in out Deck_T);
   procedure Shuffle(CardStack : in out CardStack_T);
   procedure Reshuffle(Deck : in out CardStack_T;DiscardPile : in out CardStack_T);

   function GetNewDeck(Game: Game_T) return DeckStack.Stack;

   function StackDeck(Deck : Deck_T) return DeckStack.Stack;
   function StackAsArray(CardStack : CardStack_T) return Deck_T;
   procedure ReverseStack(CardStack : in out CardStack_T);


   function Deal (Game:Game_T;Deck: in out CardStack_T;PlayerCount:Positive;Cards_Per_Player:Positive) return Player_Hands_T;
   
   procedure TestStack;
   procedure PlayPoker(PlayerCount:Positive; HandCount : Positive);
   procedure Draw(Deck : in out CardStack_T; Discard_Pile : in out CardStack_T; Player_Hand : in out CardStack_T; Count : Integer);
   procedure Discard(CardIndex : Positive;PlayerHand: in out CardStack_T; Discard_Pile : in out CardStack_T);
   procedure ChooseAndDiscard(Card : Card_T;DiscardPile : in out CardStack_T);
   
   function HandleOptionsEvent(Player_Hand : in out CardStack_T; IsLivePlayer : Boolean) return GameChoice_T;
   function HandleBetEvent(PlayerHand: CardStack_T; IsLivePlayer : Boolean) return Natural;
   function HandleRaiseEvent(PlayerHand: CardStack_T; IsLivePlayer : Boolean) return Natural;
   procedure HandleDrawEvent(Deck : in out CardStack_T; Discard_Pile : in out CardStack_T; Player_Hand : in out CardStack_T; IsLivePlayer : Boolean; MaxCardsPerHand : Positive);
   
   function GetPlayerChoice(PlayerHand: in out CardStack_T) return GameChoice_T;
   function GetRoboChoice(PlayerHand:CardStack_T) return GameChoice_T;
   function GetPlayerBet(PlayerHand : CardStack_T) return Integer;
   function GetRoboBet(PlayerHand : CardStack_T) return Integer;
   function GetPlayerRaise(PlayerHand : CardStack_T) return Integer;
   function GetRoboRaise(PlayerHand : CardStack_T) return Integer;
   --procedure RoboDraw(Deck : in out CardStack_T; Discard_Pile : in out CardStack_T; Player_Hand : in out CardStack_T; Count : Integer);
   procedure RoboDiscard(PlayerHand: in out CardStack_T; Discard_Pile : in out CardStack_T);
   function GetRoboChosenDiscard(PlayerHand : CardStack_T) return Positive;

   
   function GetNewHandReview return HandReview_T;
   procedure InspectHand(Current_Hand : CardStack_T; HandReview : in out HandReview_T);
   procedure InspectHandSuits(Current_Hand : CardStack_T; HandReview : in out HandReview_T);
   procedure InspectHandFaceValues(Current_Hand : CardStack_T; HandReview : in out HandReview_T);

   function HasAceInHand(Player_Hand : CardStack_T) return Boolean;
   procedure MarkHighCard(Current_Hand : CardStack_T; HandReview : in out HandReview_T);
   procedure HasXOfAKind(HandReview : in out HandReview_T); 
   procedure HasFullHouseOrPossible(HandReview : in out HandReview_T);
   procedure HasFlushOrPossible(HandReview : in out HandReview_T);
   procedure HasStraightOrPossible(HandReview : in out HandReview_T);
   procedure HasStraightFlushOrRoyalFlush(HandReview : in out HandReview_T);

   procedure DisplayPlayerHand(PlayerHand : in out CardStack_T; Text : String := "");
   procedure EndGame(Player_Hands: Player_Hands_T; Pot : Integer);
   
   function GetSuitAsSymbol(Card : Card_T) return String;
   function GetValueAsCardValue(Card : Card_T) return String;
   procedure PrintSummary(Round : Positive; Pot : Integer; CallCount : Integer);
   procedure Print(Card : Card_T; Index : Integer :=0);
   procedure Print(PlayerHands : Player_Hands_T);
   procedure Print(CurrentHand : in out CardStack_T;IsHorizontal : Boolean);
   procedure PrintCardRow(TempHand : CardStack_T; StartIndex : Integer :=0 );
   procedure Print(HandReview : HandReview_T);
   function GetSuitName(Index : Integer) return String;


   
end CardGames;
