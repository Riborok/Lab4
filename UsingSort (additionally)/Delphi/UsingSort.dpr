Program UsingSort;
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
  InputNum: Array [0..MaxSize] of Integer;
  Res: Array [1..MaxSize*2] of Integer;
  Size, i, j, LastPosRes: integer;
  flag: boolean;
  //InputNum - array of entered numbers
  //Res - array of frequency of repetition of each number
  //Size - size of used array
  //i,j - cycle counter
  //LastPosRes - last position (where the numbers are stored) in Res
  //Shift - amount of shifts
  //flag - flag to confirm the correctness of entering numbers

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

  //Sort array InputNum using insertion method with barrier element
  for i:= 2 to Size do
  begin

    //Adding the current checked number to the barrier element
    InputNum[0]:= InputNum[i];

    //Initialize j for the cycle
    j:=i-1;

    //Change numbers until all elements are sorted up to the current number
    while (j>=1) and (InputNum[j] > InputNum[0]) do
    begin
      InputNum[j+1]:=InputNum[j];
      j:=j-1
    end;

    //Assign the number reached in the cycle to the barrier element
    InputNum[j+1]:= InputNum[0];
  end;

  //Initializing variables for a cycle
  LastPosRes:= 1;
  Res[LastPosRes]:= InputNum[1];
  Res[LastPosRes+1]:= 1;

  //Iterate all the numbers in sequence from the 2nd number,
  //since the 1st number is already written
  for i := 2 to Size do
  begin

    //If current number = current value in Res, increase frequency of repetition of a number
    if InputNum[i] = Res[LastPosRes] then
      Res[LastPosRes+1]:= Res[LastPosRes+1] + 1

    //Else create a new number in Res for which will look for the repetition frequency
    else
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
