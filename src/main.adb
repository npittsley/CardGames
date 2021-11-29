with Text_IO; use Text_IO;
with CardGames; use CardGames;
procedure Main is
   PlayerCount : Positive;
   HandCount : Positive;
begin
   --5 card draw
   PlayerCount := 4;
   HandCount := 5;
   PlayPoker(PlayerCount,HandCount);
   --TestStack;

end Main;
