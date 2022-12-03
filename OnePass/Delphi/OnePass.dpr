Program OnePass;
{
 Enter a sequence of numbers,
 find the frequency of repetition of each number.
 Put the results into a one-dimensional array
}

{$APPTYPE CONSOLE}

Uses
  System.SysUtils;

Const
  MaxSize= 100;
  //MaxSize - maximum amount of numbers

Var
  InputNum: Array [1..MaxSize] of Integer;
  Res: Array [1..MaxSize*2] of Integer;
  Size, i, j, LastPosRes: integer;
  flag, FindNumInRes: boolean;
  //InputNum - array of entered numbers
  //Res - array of frequency of repetition of each number
  //Size - size of used array
  //i, j - cycle counter
  //LastPosRes - last position (where the numbers are stored) in Res
  //Shift - amount of shifts
  //flag - flag to confirm the correctness of entering numbers
  //FindNumInRes - indicator of finding the current number in Res

Begin

  Writeln('Enter the amount of numbers in the sequence (no more than ',MaxSize,' and more than 1)');

  //Cycle with postcondition for entering correct data.
  Repeat

    //Initialize the flag
    flag:= False;

    //Validating the correct input data type
    Try
      Readln(Size);
    Except
      Writeln('Wrong input of amount of numbers! It must be an integer');
      flag:= True;
    End;

    //Validate Range
    if ((Size > MaxSize) or (Size <= 1)) and (flag = False) then
    begin
      Writeln('Wrong input of amount of numbers! It must be >1 and <=',MaxSize);
      flag:= True;
    end;

  Until flag = False;

  Writeln('Enter a sequence of numbers');

  //Cycle with a parameter to write a sequence of numbers into an array
  //Cycle with postcondition for entering correct data.
  for i := 1 to Size do
    repeat

      //Initialize the flag
      flag:= False;

      //Validating the correct input data type
      Try
        Read(InputNum[i]);
      Except
        Writeln('The last number is entered incorrectly! Keep entering numbers');
        flag:= True;
      End;

    until flag = False;

  //Initializing variables for a cycle
  LastPosRes:= 1;
  Res[LastPosRes]:= InputNum[1];
  Res[LastPosRes+1]:= 1;

  //Iterate all the numbers in sequence from the 2nd number,
  //since the 1st number is already written
  for i := 2 to Size do
  begin

    //Initializing variables for a cycle
    FindNumInRes:= False;
    j:= 1;

    //Iterate current exist numbers in Res
    while (j <= LastPosRes) and (FindNumInRes = False) do
    begin

      //If the number exists in Res, then write it down
      //Exiting the cycle
      if InputNum[i] = Res[j] then
      begin
        Res[j+1]:= Res[j+1] + 1;
        FindNumInRes:= True;
      end;

      //Modernize j
      j:= j + 2;
    end;

    //If it does not exist in Res, then create the current number in it
    if FindNumInRes = False then
    begin
      LastPosRes:= LastPosRes + 2;
      Res[LastPosRes]:= InputNum[i];
      Res[LastPosRes+1]:= 1;
    end;

  end;

  Writeln;

  //Output the number and frequency of repetition
  i:= 1;
  while i <= LastPosRes do
  begin
    Writeln('Number ',Res[i],' occurs ',Res[i+1],' times in the sequence of numbers');
    i:= i + 2;
  end;

  Readln(i);
End.
