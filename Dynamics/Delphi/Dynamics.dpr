Program Dynamics;
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
  Size, i, PosInRes, Shift : integer;
  flag: boolean;
  //InputNum - array of entered numbers
  //Res - array of frequency of repetition of each number
  //Size - size of used array
  //i - cycle counter
  //PosInRes - current position (where the numbers are stored) in Res
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

  //PosInRes:= -1 because at the beginning of the cycle add 2 and the position becomes 1
  PosInRes:= -1;

  //Count the frequency while Size >= 1 (the size of the used array is reduced using shifts)
  while Size >= 1 do
  begin

    //Position increases by 2, since in [Pos] stored number
    //and in [Pos+1] stored the frequency of repetition
    PosInRes:= PosInRes + 2;

    //Initialize the shift for the cycle
    Shift:= 1;

    //Write down the current number for which consider the frequency of repetition.
    //And write down that at least one number is already exists(the number itself)
    Res[PosInRes]:= InputNum[1];
    Res[PosInRes+1]:= 1;

    //Since looking for repetitions of the first element, iterate from 2 to Size
    for i := 2 to Size do
    begin

      //If find the same number, write down it and increase shift by 1
      if InputNum[i] = Res[PosInRes] then
      begin
        Res[PosInRes+1]:= Res[PosInRes+1] + 1;
        Shift:= Shift + 1;
      end

      //Else shift the current number
      else
        InputNum[i-Shift]:= InputNum[i];

    end;

    //Modernize Size
    Size:= Size - Shift;

  end;

  Writeln;

  //Output the number and frequency of repetition
  i:= 1;
  while i <= PosInRes do
  begin
    Writeln('Number ',Res[i],' occurs ',Res[i+1],' times in the sequence of numbers');
    i:= i + 2;
  end;

  Readln(i);
End.
